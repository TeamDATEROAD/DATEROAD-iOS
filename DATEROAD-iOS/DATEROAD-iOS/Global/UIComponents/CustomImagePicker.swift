//
//  CustomImagePicker.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/15/24.
//

import UIKit

import PhotosUI

protocol ImagePickerDelegate: AnyObject {
   func didPickImages(_ images: [UIImage])
}

final class CustomImagePicker: NSObject, PHPickerViewControllerDelegate {
   
   // MARK: - Properties
   
   weak var delegate: ImagePickerDelegate?
   
   let isProfilePicker: Bool
   
   private var selections = [String: PHPickerResult]()
   
   private var selectedAssetIdentifiers = [String]()
   
   private var itemProviders: [NSItemProvider] = []
   
   
   // MARK: - Initializer
   
   init(isProfilePicker: Bool) {
      self.isProfilePicker = isProfilePicker
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}


// MARK: - PHPickerViewControllerDelegate Methods

extension CustomImagePicker {
   
   /// ImagePicker 열 때에 해당 피커 관련 설정 작업
   func presentPicker(from viewController: UIViewController) {
      switch isProfilePicker {
      case true:
         var config = PHPickerConfiguration()
         config.filter = .images
         config.selectionLimit = 1
         
         let imagePicker = PHPickerViewController(configuration: config)
         imagePicker.delegate = self
         
         viewController.present(imagePicker, animated: true)
      default:
         selections.removeAll()
         selectedAssetIdentifiers.removeAll()
         
         var config = PHPickerConfiguration(photoLibrary: .shared())
         config.filter = PHPickerFilter.any(of: [.images])
         config.selectionLimit = 10
         config.selection = .ordered
         config.preferredAssetRepresentationMode = .current
         
         let imagePicker = PHPickerViewController(configuration: config)
         imagePicker.delegate = self
         
         viewController.present(imagePicker, animated: true)
      }
   }
   
   /// ImagePicker가 종료된 이후 실행되는 함수
   func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      
      switch isProfilePicker {
         
      case true:
         itemProviders = results.map(\.itemProvider)
         print("Item Providers Count: \(itemProviders.count)")
         displayImage()
         
      case false:
         var newSelections = [String: PHPickerResult]()
         
         for result in results {
            let identifier = result.assetIdentifier ?? ""
            newSelections[identifier] = selections[identifier] ?? result
         }
         
         selections = newSelections
         selectedAssetIdentifiers = results.compactMap { $0.assetIdentifier }
         
         if selections.isEmpty {
            delegate?.didPickImages([])
         } else {
            displayImage()
         }
         selections.removeAll()
      }
   }
   
   /// ImagePicker에서 이미지를 선택한 이후 해당 이미지 delegate로 넘기기
   private func displayImage() {
      switch isProfilePicker {
         
      case true:
         guard let itemProvider = itemProviders.first else {
            print("No item provider found")
            return
         }
         if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
               guard let self = self, let image = image as? UIImage else {
                  print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                  return
               }
               
               DispatchQueue.main.async {
                  self.delegate?.didPickImages([image])
               }
            }
         } else {
            print("Item provider cannot load UIImage")
         }
         
      case false:
         let dispatchGroup = DispatchGroup()
         var imagesDict = [String: UIImage]()
         
         for (identifier, result) in selections {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
               itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                  guard let image = image as? UIImage else {
                     dispatchGroup.leave()
                     return
                  }
                  imagesDict[identifier] = image
                  dispatchGroup.leave()
               }
            }
         }
         
         dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            
            var images = [UIImage]()
            for identifier in self.selectedAssetIdentifiers {
               if let image = imagesDict[identifier] {
                  images.append(image)
               }
            }
            
            self.delegate?.didPickImages(images)
         }
      }
   }
   
}
