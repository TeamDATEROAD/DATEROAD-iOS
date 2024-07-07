//
//  AddCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

@available(iOS 17.0, *)
#Preview {
   AddCourseViewController()
}

final class AddCourseViewController: BaseNavBarViewController {
   
   //   private var isImageEmpty = true
   //
   //   private var dataSource = getSampleImages()
   
   private let viewModel = AddCourseViewModel()
   
   private var addCourseFirstView = AddCourseFirstView()
   
   // MARK: - Life Cycle
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrScheduleFirst.addCourseTitle)
      setLeftBackButton()
      setAddTarget()
      registerCell()
      bindViewModel()
   }
   
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

extension AddCourseViewController {
   private func bindViewModel() {
      viewModel.dateName.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.dateNameTextField.text = date
      }
      viewModel.visitDate.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.visitDateTextField.text = date
      }
      
      viewModel.dateStartTime.bind { [weak self] date in
         self?.addCourseFirstView.addFirstView.dateStartTimeTextField.text = date
      }
   }
   
   private func setAddTarget() {
      addCourseFirstView.addFirstView.dateNameTextField.addTarget(self, action: #selector(textFieldDidChanacge(_:)), for: .editingChanged)
      addCourseFirstView.addFirstView.visitDateTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
      addCourseFirstView.addFirstView.dateStartTimeTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
   }

}

extension AddCourseViewController: UITextFieldDelegate {
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField == addCourseFirstView.addFirstView.dateNameTextField {
         return true
      } else {
         textFieldTapped(textField)
         return false
      }
   }
   
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
      if textField.text?.count ?? 0 >= 5 {
         addCourseFirstView.updateDateNameTextField(isPassValid: true)
      } else {
         addCourseFirstView.updateDateNameTextField(isPassValid: false)
      }
   }
   
}

extension AddCourseViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   private func registerCell() {
      addCourseFirstView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: "AddCourseImageCollectionViewCell")
         $0.delegate = self
         $0.dataSource = self
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if viewModel.dataSource.isEmpty {
         return 1
      } else {
         return viewModel.dataSource.count
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: AddCourseImageCollectionViewCell.id,
         for: indexPath
      ) as! AddCourseImageCollectionViewCell
      
      if viewModel.dataSource.isEmpty {
         addCourseFirstView.cameraBtn.isHidden = true
         cell.cellType = .EmptyType
         addCourseFirstView.imageCountLabel.text = "\(0)/10"
      } else {
         addCourseFirstView.cameraBtn.isHidden = false
         cell.cellType = .NotEmptyPType
         cell.prepare(image: viewModel.dataSource[indexPath.item])
         addCourseFirstView.imageCountLabel.text = "\(viewModel.dataSource.count)/10"
      }
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if viewModel.dataSource.isEmpty {
         print("Empty cell selected")
      } else {
         print("Cell \(indexPath.item) selected")
      }
   }
   
}

func getSampleImages() -> [UIImage?] {
   (1...9).map { _ in return UIImage(resource: .test) }
   //      return []
}
