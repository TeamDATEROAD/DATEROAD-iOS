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
   
   let addSheetView = AddSheetView(isCustomPicker: false)
   
   lazy var alertVC = DRBottomSheetViewController(contentView: addSheetView, height: 304, buttonType: EnabledButton(), buttonTitle: StringLiterals.AddCourseOrSchedule.AddBottomSheetView.datePickerBtnTitle)
   
   private let imagePickerViewController = CustomImagePicker(isProfilePicker: false)
   
   
   
   
   // MARK: - Properties
   
   private let viewModel = AddCourseViewModel()
   
   // Identifier와 PHPickerResult로 만든 Dictionary (이미지 데이터를 저장하기 위해 만들어 줌)
   //   private var selections = [String : PHPickerResult]()
   //
   //   // 선택한 사진의 순서에 맞게 Identifier들을 배열로 저장해줄 겁니다.
   //   // selections은 딕셔너리이기 때문에 순서가 없습니다. 그래서 따로 식별자를 담을 배열 생성
   //   private var selectedAssetIdentifiers = [String]()
   
   
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
      imagePickerViewController.delegate = self
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
      imagePickerViewController.presentPicker(from: self)
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
         imagePickerViewController.presentPicker(from: self)
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
      if textField == addCourseFirstView.addFirstView.visitDateTextField {
         addSheetView.datePickerMode(isDatePicker: true)
      } else if textField == addCourseFirstView.addFirstView.dateStartTimeTextField {
         addSheetView.datePickerMode(isDatePicker: false)
      }
      
      alertVC.bottomButtonAction = { [weak self] in
         guard let self = self else { return }
         if textField == self.addCourseFirstView.addFirstView.visitDateTextField {
            let selectedDate = addSheetView.datePicker.date
            viewModel.isFutureDate(date: selectedDate, dateType: "date")
            dismiss(animated: true)
         } else if textField == addCourseFirstView.addFirstView.dateStartTimeTextField {
            let formattedDate = addSheetView.datePicker.date
            viewModel.isFutureDate(date: formattedDate, dateType: "time")
         }
      }
      
      DispatchQueue.main.async {
         self.alertVC.modalPresentationStyle = .overFullScreen
         self.present(self.alertVC, animated: true, completion: nil)
      }
   }
   
   @objc
   func textFieldDidChanacge(_ textField: UITextField) {
      viewModel.isDateNameValid(cnt: textField.text?.count ?? 0)
   }
   
}

extension AddCourseFirstViewController: ImagePickerDelegate {
   
   func didPickImages(_ images: [UIImage]) {
      print("images : \(images)")
      viewModel.pickedImageArr = images
      addCourseFirstView.collectionView.reloadData()
   }
   
}
