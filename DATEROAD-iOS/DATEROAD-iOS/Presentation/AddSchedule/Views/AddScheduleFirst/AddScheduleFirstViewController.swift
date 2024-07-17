//
//  AddScheduleFirstViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

class AddScheduleFirstViewController: BaseNavBarViewController {
   
   let addScheduleFirstView = AddScheduleFirstView()
   
   let addSheetView = AddSheetView(isCustomPicker: false)
   
   lazy var alertVC = DRBottomSheetViewController(contentView: addSheetView, height: 304, buttonType: EnabledButton(), buttonTitle: StringLiterals.AddCourseOrSchedule.AddBottomSheetView.datePickerBtnTitle)
   
   // MARK: - Properties
   
    let viewModel = AddScheduleViewModel()
   

   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addScheduleTitle, alignment: .center)
      setLeftBackButton()
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
      contentView.addSubview(addScheduleFirstView)
   }
   
   override func setLayout() {
      super.setLayout()
      
      addScheduleFirstView.snp.makeConstraints {
         $0.top.equalToSuperview().offset(4)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
      }
   }
   
   override func setStyle() {
      super.setStyle()
      
      addScheduleFirstView.do {
         $0.isUserInteractionEnabled = true
      }
   }

}

extension AddScheduleFirstViewController {
   
   func bindViewModel() {
      viewModel.isDateNameVaild.bind { date in
         guard let date = date else {return}
         self.addScheduleFirstView.updateDateNameTextField(isPassValid: date)
         
         let flag = self.viewModel.isOkSixBtn()
         self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: flag)
      }
      viewModel.isVisitDateVaild.bind { date in
         guard let date = date else {return}
         self.addScheduleFirstView.updateVisitDateTextField(isPassValid: date)
         
         let flag = self.viewModel.isOkSixBtn()
         self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: flag)
      }
      viewModel.isDateStartAtVaild.bind { date in
         let flag = self.viewModel.isOkSixBtn()
         self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: flag)
      }
      viewModel.isValidTag.bind { date in
         let flag = self.viewModel.isOkSixBtn()
         self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: flag)
      }
      viewModel.isDateLocationVaild.bind { date in
         let flag = self.viewModel.isOkSixBtn()
         self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.dateName.bind { date in
         guard let text = date else {return}
         self.addScheduleFirstView.inAddScheduleFirstView.updateDateName(text: text)
      }
      viewModel.visitDate.bind { date in
         guard let text = date else {return}
         self.addScheduleFirstView.inAddScheduleFirstView.updateVisitDate(text: text)
      }
      viewModel.dateStartAt.bind { date in
         guard let text = date else {return}
         self.addScheduleFirstView.inAddScheduleFirstView.updatedateStartTime(text: text)
      }
      viewModel.tagCount.bind { count in
         self.addScheduleFirstView.inAddScheduleFirstView.updateTagCount(count: count ?? 0)
      }
      viewModel.dateLocation.bind { date in
         guard let date = date else {return}
         self.addScheduleFirstView.inAddScheduleFirstView.updateDateLocation(text: date)
      }
   }
   
   func registerCell() {
      addScheduleFirstView.inAddScheduleFirstView.tendencyTagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
   }
   
   func setDelegate() {
      addScheduleFirstView.inAddScheduleFirstView.tendencyTagCollectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
      addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.delegate = self
   }
   
   func setAddTarget() {
      addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.addTarget(self, action: #selector(textFieldDidChanacge(_:)), for: .editingChanged)
      
      addScheduleFirstView.inAddScheduleFirstView.sixCheckNextButton.addTarget(self, action: #selector(sixCheckBtnTapped), for: .touchUpInside)
      
      let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(visitDate))
      addScheduleFirstView.inAddScheduleFirstView.visitDateContainer.addGestureRecognizer(tapGesture1)
      addScheduleFirstView.inAddScheduleFirstView.visitDateContainer.isUserInteractionEnabled = true
      
      let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dateStartAt))
      addScheduleFirstView.inAddScheduleFirstView.dateStartAtContainer.addGestureRecognizer(tapGesture2)
      addScheduleFirstView.inAddScheduleFirstView.dateStartAtContainer.isUserInteractionEnabled = true
      
      
      let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(datePlaceContainerTapped))
      addScheduleFirstView.inAddScheduleFirstView.datePlaceContainer.addGestureRecognizer(tapGesture3)
      addScheduleFirstView.inAddScheduleFirstView.datePlaceContainer.isUserInteractionEnabled = true
   }
   
   @objc
   func visitDate() {
         addSheetView.datePickerMode(isDatePicker: true)
         viewModel.isTimePicker = false
      alertVC.delegate = self
      DispatchQueue.main.async {
         self.alertVC.modalPresentationStyle = .overFullScreen
         self.present(self.alertVC, animated: true, completion: nil)
      }
   }
   
   @objc
   func dateStartAt() {
         addSheetView.datePickerMode(isDatePicker: false)
         viewModel.isTimePicker = true
      alertVC.delegate = self
      DispatchQueue.main.async {
         self.alertVC.modalPresentationStyle = .overFullScreen
         self.present(self.alertVC, animated: true, completion: nil)
      }
   }
   
   @objc
   func textFieldDidChanacge(_ textField: UITextField) {
      viewModel.dateName.value = textField.text ?? ""
      viewModel.satisfyDateName(str: textField.text ?? "")
   }
   
   @objc
   func changeTagBtnState(sender: UIButton) {
      sender.isSelected.toggle()
      addScheduleFirstView.inAddScheduleFirstView.updateTagButtonStyle(btn: sender, isSelected: sender.isSelected)
      viewModel.countSelectedTag(isSelected: sender.isSelected)
   }
   
   @objc
   func didTapTagButton(_ sender: UIButton) {
      // 0 ~ 2개 선택되어 있는 경우
      if self.viewModel.tagCount.value != 3 {
         sender.isSelected = !sender.isSelected
         sender.isSelected ? self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: SelectedButton())
         : self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: UnselectedButton())
         self.viewModel.countSelectedTag(isSelected: sender.isSelected)
      }
      // 3개 선택되어 있는 경우
      else {
         // 취소 하려는 경우
         if sender.isSelected {
            sender.isSelected = !sender.isSelected
            self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: UnselectedButton())
            self.viewModel.countSelectedTag(isSelected: sender.isSelected)
         }
      }
   }
   
   @objc
   func sixCheckBtnTapped() {
      let secondVC = AddScheduleSecondViewController(viewModel: self.viewModel)
      navigationController?.pushViewController(secondVC, animated: true)
   }
   
   @objc
   private func datePlaceContainerTapped() {
      // datePlaceContainer가 탭되었을 때 수행할 동작을 여기에 구현합니다.
      print("datePlaceContainer tapped!")
      let locationFilterVC = LocationFilterViewController()
      locationFilterVC.modalPresentationStyle = .overFullScreen
      locationFilterVC.delegate = self
      self.present(locationFilterVC, animated: true)
   }
}

extension AddScheduleFirstViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let tagTitle = viewModel.tagData[indexPath.item].tagTitle
         let font = UIFont.suit(.body_med_13)
         let textWidth = tagTitle.width(withConstrainedHeight: 30, font: font)
         let padding: CGFloat = 44
         
         return CGSize(width: textWidth + padding, height: 30)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 8
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 7
   }
   
}

extension AddScheduleFirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.tagData.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
         cell.updateButtonTitle(tag: self.viewModel.tagData[indexPath.item])
         cell.tendencyTagButton.tag = indexPath.item
         cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
         return cell
   }
   
//   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      if collectionView == addCourseFirstView.collectionView {
//         let isImageEmpty = (viewModel.pickedImageArr.count<1) ? true : false
//         if isImageEmpty  && collectionView == addCourseFirstView.collectionView {
//            imagePickerViewController.presentPicker(from: self)
//         }
//      }
//   }
   
}

extension AddScheduleFirstViewController: UITextFieldDelegate {
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField == addScheduleFirstView.inAddScheduleFirstView.dateNameTextField {
         return true
      } else {
         return false
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
}

extension AddScheduleFirstViewController: DRBottomSheetDelegate {
   
   func didTapBottomButton() {
      print("")
      self.dismiss(animated: true)
      updateTextField()
   }
   
   func updateTextField() {
      let isTimePickerFlag = viewModel.isTimePicker ?? false
      
      if !isTimePickerFlag {
         let selectedDate = addSheetView.datePicker.date
         viewModel.isFutureDate(date: selectedDate, dateType: "date")
         dismiss(animated: true)
      } else {
         let formattedDate = addSheetView.datePicker.date
         viewModel.isFutureDate(date: formattedDate, dateType: "time")
      }
   }
   
}

extension AddScheduleFirstViewController: LocationFilterDelegate {
   
   func didSelectCity(_ city: LocationModel.City) {
      print("selected : \(city)")
      print("Selected city: \(city.rawValue)")
      viewModel.dateLocation.value = city.rawValue
      viewModel.satisfyDateLocation(str: city.rawValue)
   }
   
}

