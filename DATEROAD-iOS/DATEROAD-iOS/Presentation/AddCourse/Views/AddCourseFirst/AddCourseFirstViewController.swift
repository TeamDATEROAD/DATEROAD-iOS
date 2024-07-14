//
//  AddCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then
import PhotosUI

final class AddCourseFirstViewController: BaseNavBarViewController {
   
   // MARK: - UI Properties
   
   var addCourseFirstView = AddCourseFirstView()
   
   
   // MARK: - Properties
   
   private let viewModel = AddCourseViewModel()
   
   // Identifier와 PHPickerResult로 만든 Dictionary (이미지 데이터를 저장하기 위해 만들어 줌)
   private var selections = [String : PHPickerResult]()
   // 선택한 사진의 순서에 맞게 Identifier들을 배열로 저장해줄 겁니다.
   // selections은 딕셔너리이기 때문에 순서가 없습니다. 그래서 따로 식별자를 담을 배열 생성
   private var selectedAssetIdentifiers = [String]()
   
   
   // MARK: - Life Cycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addCourseTitle, alignment: .center)
      setLeftBackButton()
      viewModel.getSampleImages()
      setAddTarget()
      registerCell()
      setDelegate()
      bindViewModel()
      setupKeyboardDismissRecognizer()
   }
   
   // MARK: - Methods
   
   override func setHierarchy() {
      super.setHierarchy()
      
      self.view.addSubview(contentView)
      contentView.addSubview(addCourseFirstView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addCourseFirstView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      addCourseFirstView.do {
         $0.isUserInteractionEnabled = true
      }
   }
   
}

private extension AddCourseFirstViewController {
   
   func bindViewModel() {
      viewModel.dateName.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.dateNameTextField.text = date
      }
      viewModel.visitDate.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.visitDateTextField.text = date
      }
      viewModel.dateStartAt.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.dateStartTimeTextField.text = date
      }
      viewModel.isDateNameValid.bind { [weak self] date in
         self?.addCourseFirstView.updateDateNameTextField(isPassValid: date ?? true)
      }
      viewModel.isVisitDateValid.bind { [weak self] date in
         self?.addCourseFirstView.updateVisitDateTextField(isPassValid: date ?? true)
      }
      viewModel.tagCount.bind { [weak self] count in
         self?.addCourseFirstView.addFirstView.updateTagCount(count: count ?? 0)
      }
      //보완 예정
      //      viewModel.isSixCheckPass.bind { [weak self] date in
      //         self?.viewModel.isPassSixCheckBtn()
      //      }
      
   }
   
   func registerCell() {
      addCourseFirstView.collectionView.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
   }
   
   func setDelegate() {
      addCourseFirstView.collectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
      addCourseFirstView.addFirstView.dateNameTextField.delegate = self
   }
   
   func setAddTarget() {
      addCourseFirstView.addFirstView.dateNameTextField.addTarget(self, action: #selector(textFieldDidChanacge(_:)), for: .editingChanged)
      addCourseFirstView.addFirstView.visitDateTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
      addCourseFirstView.addFirstView.dateStartTimeTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
      for button in addCourseFirstView.addFirstView.tagBtns {
         button.addTarget(self, action: #selector(changeTagBtnState), for: .touchUpInside)
      }
      addCourseFirstView.addFirstView.sixCheckNextButton.addTarget(self, action: #selector(sixCheckBtnTapped), for: .touchUpInside)
   }
   
   
   @objc
   func removeCell(sender: UIButton) {
      guard let cell = sender.superview?.superview as? AddCourseImageCollectionViewCell,
            let indexPath = addCourseFirstView.collectionView.indexPath(for: cell) else { return }
      
      viewModel.pickedImageArr.remove(at: indexPath.item)
      
      let dataSourceCnt = viewModel.pickedImageArr.count
      if dataSourceCnt < 1 {
         cell.updateImageCellUI(isImageEmpty: true, vcCnt: 1)
         addCourseFirstView.collectionView.reloadData()
      } else {
         addCourseFirstView.collectionView.deleteItems(at: [indexPath])
      }
   }
   
   @objc
   func didTapCameraBtn() {
      presentPicker()
   }
   
   @objc
   func changeTagBtnState(sender: UIButton) {
      sender.isSelected.toggle()
      addCourseFirstView.addFirstView.updateTagButtonStyle(btn: sender, isSelected: sender.isSelected)
      viewModel.countSelectedTag(isSelected: sender.isSelected)
   }
   
   @objc
   func sixCheckBtnTapped() {
      let secondVC = AddCourseSecondViewController(viewModel: self.viewModel)
      navigationController?.pushViewController(secondVC, animated: true)
   }
   
   
}

extension AddCourseFirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let cnt = viewModel.pickedImageArr.count
      return viewModel.isPickedImageEmpty(cnt: cnt) ? 1 : viewModel.pickedImageArr.count
   }
   
   //완벽
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
         for: indexPath
      ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
      
      let cnt = viewModel.pickedImageArr.count
      let flag = viewModel.isPickedImageEmpty(cnt: cnt)
      
      cell.updateImageCellUI(isImageEmpty: flag, vcCnt: 1)
      
      if !flag {
         self.addCourseFirstView.updateImageCellUI(isEmpty: flag, ImageDataCount: cnt)
         print(viewModel.pickedImageArr.count)
         cell.configurePickedImage(pickedImage: viewModel.pickedImageArr[indexPath.row])
         cell.prepare(image: viewModel.pickedImageArr[indexPath.row])
         
         cell.deleteImageBtn.tag = indexPath.row
         cell.deleteImageBtn.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
         addCourseFirstView.cameraBtn.addTarget(self, action: #selector(didTapCameraBtn), for: .touchUpInside)
      } else {
         print(viewModel.pickedImageArr.count)
         self.addCourseFirstView.updateImageCellUI(isEmpty: flag, ImageDataCount: 0)
      }
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let isImageEmpty = (viewModel.pickedImageArr.count<1) ? true : false
      if isImageEmpty  && collectionView == addCourseFirstView.collectionView {
         presentPicker()
      }
   }
   
}

extension AddCourseFirstViewController: UITextFieldDelegate {
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField == addCourseFirstView.addFirstView.dateNameTextField {
         return true
      } else {
         textFieldTapped(textField)
         return false
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
   // MARK: - @objc Methods
   
   @objc
   private func textFieldTapped(_ textField: UITextField) {
      let addSheetVC = AddSheetViewController(viewModel: self.viewModel)
      if textField == addCourseFirstView.addFirstView.visitDateTextField {
         addSheetVC.addCourseFirstView = self.addCourseFirstView
         addSheetVC.addSheetView.datePicker.datePickerMode = .date
      } else if textField == addCourseFirstView.addFirstView.dateStartTimeTextField {
         addSheetVC.addCourseFirstView = self.addCourseFirstView
         addSheetVC.addSheetView.datePicker.datePickerMode = .time
      }
      DispatchQueue.main.async {
         addSheetVC.modalPresentationStyle = .overFullScreen
         self.present(addSheetVC, animated: true, completion: nil)
      }
   }
   
   @objc
   func textFieldDidChanacge(_ textField: UITextField) {
      viewModel.isDateNameValid(cnt: textField.text?.count ?? 0)
   }
   
}

extension AddCourseFirstViewController: PHPickerViewControllerDelegate {
   
   /// 이미지 피커 종료시 실행
   func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      
      picker.dismiss(animated: true)
      
      var newSelections = [String: PHPickerResult]()
      
      for result in results {
         let identifier = result.assetIdentifier ?? ""
         newSelections[identifier] = selections[identifier] ?? result
      }
      
      selections = newSelections
      selectedAssetIdentifiers = results.compactMap { $0.assetIdentifier }
      
      /// 선택한 이미지가 어
      if selections.isEmpty {
         viewModel.pickedImageArr.removeAll()
         addCourseFirstView.collectionView.reloadData()
      } else {
         displayImage()
      }
      selections.removeAll()
   }
   
   private func presentPicker() {
      viewModel.pickedImageArr.removeAll()
      // 이미지의 Identifier를 사용하기 위해서는 초기화를 shared로 해줘야 합니다.
      var config = PHPickerConfiguration(photoLibrary: .shared())
      config.filter = PHPickerFilter.any(of: [.images])
      config.selectionLimit = 10
      config.selection = .ordered
      config.preferredAssetRepresentationMode = .current
      
      // 이 동작이 있어야 PHPicker를 실행 시, 선택했던 이미지를 기억해 표시할 수 있다. (델리게이트 코드 참고)
      // config.preselectedAssetIdentifiers = selectedAssetIdentifiers
      
      // 만들어준 Configuration를 사용해 PHPicker 컨트롤러 객체 생성
      let imagePicker = PHPickerViewController(configuration: config)
      imagePicker.delegate = self
      
      self.present(imagePicker, animated: true)
   }
   
   private func displayImage() {
      let dispatchGroup = DispatchGroup()
      // identifier와 이미지로 dictionary를 만듦 (selectedAssetIdentifiers의 순서에 따라 이미지를 받을 예정입니다.)
      var imagesDict = [String: UIImage]()
      
      for (identifier, result) in selections {
         dispatchGroup.enter()
         let itemProvider = result.itemProvider
         
         // 만약 itemProvider에서 UIImage로 로드가 가능하다면?
         if itemProvider.canLoadObject(ofClass: UIImage.self) {
            // 로드 핸들러를 통해 UIImage를 처리해 줍시다. (비동기적으로 동작)
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
               guard let image = image as? UIImage else { return }
               imagesDict[identifier] = image
               dispatchGroup.leave()
            }
         }
      }
      
      dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
         guard let self = self else { return }
         
         // 선택한 이미지의 순서대로 정렬하여 스택뷰에 올리기
         for identifier in self.selectedAssetIdentifiers {
            guard let image = imagesDict[identifier] else { return }
            self.viewModel.pickedImageArr.append(image)
         }
         
         addCourseFirstView.collectionView.reloadData()
      }
   }
}
