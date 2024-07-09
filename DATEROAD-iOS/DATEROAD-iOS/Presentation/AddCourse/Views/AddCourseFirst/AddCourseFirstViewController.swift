//
//  AddCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseFirstViewController: BaseNavBarViewController {
   
   // MARK: - UI Properties
   
   var addCourseFirstView = AddCourseFirstView()
   
   // MARK: - Properties
   
   private let viewModel = AddCourseViewModel()
   
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

extension AddCourseFirstViewController {
   
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
      viewModel.isDateNameValid.bind { [weak self] date in
         self?.addCourseFirstView.updateDateNameTextField(isPassValid: date ?? true)
      }
      viewModel.isVisitDateValid.bind { [weak self] date in
         self?.addCourseFirstView.updateVisitDateTextField(isPassValid: date ?? true)
      }
      viewModel.tagCount.bind { [weak self] count in
         self?.addCourseFirstView.addFirstView.updateTagCount(count: count ?? 0)
      }
//      viewModel.isSixCheckPass.bind { [weak self] date in
//         self?.viewModel.isPassSixCheckBtn()
//      }
   }
   
   private func setAddTarget() {
      addCourseFirstView.addFirstView.dateNameTextField.addTarget(self, action: #selector(textFieldDidChanacge(_:)), for: .editingChanged)
      addCourseFirstView.addFirstView.visitDateTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
      addCourseFirstView.addFirstView.dateStartTimeTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .touchDown)
      for button in addCourseFirstView.addFirstView.tagBtns {
         button.addTarget(self, action: #selector(changeTagBtnState), for: .touchUpInside)
      }
      setupKeyboardDismissRecognizer()
   }
   
}

extension AddCourseFirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   private func registerCell() {
      addCourseFirstView.collectionView.do {
         $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
         $0.delegate = self
         $0.dataSource = self
      }
      addCourseFirstView.addFirstView.dateNameTextField.delegate = self
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.getSampleImages() ? 1 : viewModel.dataSource.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
         for: indexPath
      ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
      
      let isImageEmpty = viewModel.isImageEmpty.value ?? true
      isImageEmpty ? cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: nil)
      : cell.updateImageCellUI(isImageEmpty: isImageEmpty, image: self.viewModel.dataSource[indexPath.item])
      
      self.addCourseFirstView.updateImageCellUI(isEmpty: isImageEmpty,ImageDataCount: self.viewModel.dataSource.count )
      
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
      textField.tintColor = UIColor.clear
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
   
   @objc
   func changeTagBtnState(sender: UIButton) {
      sender.isSelected.toggle()
      addCourseFirstView.addFirstView.updateTagButtonStyle(btn: sender, isSelected: sender.isSelected)
      viewModel.countSelectedTag(isSelected: sender.isSelected)
   }
   
}
