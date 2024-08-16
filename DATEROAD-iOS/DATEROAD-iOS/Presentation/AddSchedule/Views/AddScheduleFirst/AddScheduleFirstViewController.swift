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
   
   let viewModel: AddScheduleViewModel
   
   init(viewModel: AddScheduleViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
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
      pastDateBindViewModel()
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
   
   func pastDateBindViewModel() {
      if !viewModel.isImporting {
         setRightBtnStyle()
         setRightButtonAction(target: self, action: #selector(didTapNavRightBtn))
      }
      viewModel.ispastDateVaild.value = true
   }
   
   func bindViewModel() {
       self.viewModel.onReissueSuccess.bind { [weak self] onSuccess in
           guard let onSuccess else { return }
           if onSuccess {
               // TODO: - 서버 통신 재시도
           } else {
               self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
           }
       }
       
      viewModel.ispastDateVaild.bind { [weak self] isValid in
         guard let self = self else { return }
         self.viewModel.fetchPastDate {
            self.addScheduleFirstView.inAddScheduleFirstView.tendencyTagCollectionView.reloadData()
            print("지금 tendencyTagCollectionView reload")
         }
      }
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
   func didTapNavRightBtn() {
      let vc = NavViewedCourseViewController()
      self.navigationController?.pushViewController(vc, animated: true)
   }
   
   @objc
   func visitDate() {
      addSheetView.datePickerMode(isDatePicker: true)
      viewModel.isTimePicker = false
      alertVC.delegate = self
      addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.resignFirstResponder()
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
      addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.resignFirstResponder()
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
   func didTapTagButton(_ sender: UIButton) {
      guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
      
      let maxTags = 3
      
      // 3이 아닐 때
      if self.viewModel.selectedTagData.count != maxTags {
         sender.isSelected.toggle()
         sender.isSelected ? self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: SelectedButton())
         : self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: UnselectedButton())
         self.viewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
         self.viewModel.isValidTag.value = true
      }
      // 그 외
      else {
         if sender.isSelected {
            sender.isSelected.toggle()
            self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType:  UnselectedButton())
            self.viewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
            self.viewModel.isValidTag.value = true
         }
      }
   }
   
   @objc
   func importingTagBtn(_ sender: UIButton) {
      guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
      self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: SelectedButton())
      self.viewModel.isValidTag.value = true
      
   }
   
   @objc
   func sixCheckBtnTapped() {
      let secondVC = AddScheduleSecondViewController(viewModel: self.viewModel)
      navigationController?.pushViewController(secondVC, animated: false)
      //      print(viewModel.selectedTags.count)
   }
   
   @objc
   private func datePlaceContainerTapped() {
      // datePlaceContainer가 탭되었을 때 수행할 동작을 여기에 구현합니다.
      print("datePlaceContainer tapped!")
      let locationFilterVC = LocationFilterViewController()
      locationFilterVC.modalPresentationStyle = .overFullScreen
      locationFilterVC.delegate = self
      self.present(locationFilterVC, animated: false)
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
      
      print("Setting up cell for tag: \(cell.tendencyTagButton.tag)")
      print("pastDateTagIndex: \(viewModel.pastDateTagIndex)")
      
      if viewModel.pastDateTagIndex.contains(cell.tendencyTagButton.tag) {
         print("Found matching tag in pastDateTagIndex: \(cell.tendencyTagButton.tag)")
         importingTagBtn(cell.tendencyTagButton)
         print("!!!!!!!!!!!!!!!!")
//         viewModel.pastDateTagIndex.removeFirst()
//         if viewModel.pastDateTagIndex.count == 0 {
//            collectionView.reloadData()
//         }
      }
      
      
      return cell
   }
   
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
    func didTapFirstLabel() {
        print("d")
    }
    
   
   func didTapBottomButton() {
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
    func getCourse() {
        return
    }
    
   func didSelectCity(_ country: LocationModel.Country, _ city: LocationModel.City) {
      print("selected country : \(country.rawValue)")
      print("Selected city: \(city.rawValue)")
      viewModel.dateLocation.value = city.rawValue
      viewModel.satisfyDateLocation(str: city.rawValue)
      let country = LocationModelCountryKorToEng.Country(rawValue: country.rawValue).rawValue
      let city = LocationModelCityKorToEng.City(rawValue: city.rawValue).rawValue
      viewModel.country = country
      viewModel.city = city
   }
   
   
   //   func didSelectLocation(country: LocationModel.Country, city: LocationModel.City) {
   //      print("selected country : \(country.rawValue)")
   //      print("Selected city: \(city.rawValue)")
   //      viewModel.dateLocation.value = city.rawValue
   //      viewModel.satisfyDateLocation(str: city.rawValue)
   //      let country = LocationModelCountryKorToEng.Country(rawValue: country.rawValue).rawValue
   //      let city = LocationModelCityKorToEng.City(rawValue: city.rawValue).rawValue
   //      viewModel.country = country
   //      viewModel.city = city
   //   }
   
}

