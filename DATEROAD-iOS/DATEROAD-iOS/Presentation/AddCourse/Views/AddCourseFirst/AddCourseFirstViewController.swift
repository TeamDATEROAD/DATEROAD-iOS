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
   
   let viewModel: AddCourseViewModel
   
   var viewPath: String
   
   
   // MARK: - Initializer
   
   init(viewModel: AddCourseViewModel, viewPath: String) {
      self.viewModel = viewModel
      self.viewPath = viewPath
      
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - Life Cycle
   
   override func viewWillAppear(_ animated: Bool) {
      self.tabBarController?.tabBar.isHidden = true
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
      setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addCourseTitle, alignment: .center)
      setLeftBackButton()
      setAddTarget()
      registerCell()
      setDelegate()
      bindViewModel()
      pastDateBindViewModel()
      setupKeyboardDismissRecognizer()
      AmplitudeManager.shared.trackEventWithProperties(StringLiterals.Amplitude.EventName.viewCourse1, properties: [StringLiterals.Amplitude.Property.viewPath: viewPath])
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
   
   func pastDateBindViewModel() {
      if let pastDateDetailData = viewModel.pastDateDetailData {
         print("Received date detail data: \(pastDateDetailData)")
         viewModel.ispastDateVaild.value = true
      }
   }
   
   func bindViewModel() {
      viewModel.ispastDateVaild.bind { date in
         self.viewModel.fetchPastDate()
         self.addCourseFirstView.addFirstView.tendencyTagCollectionView.reloadData()
      }
      
      viewModel.isPickedImageVaild.bind { date in
         guard let value = self.viewModel.isPickedImageVaild.value else {return}
         self.viewModel.courseImage = value
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.isDateNameVaild.bind { date in
         guard let date else {return}
         self.addCourseFirstView.updateDateNameTextField(isPassValid: date)
         
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.isVisitDateVaild.bind { date in
         guard let date else {return}
         self.addCourseFirstView.updateVisitDateTextField(isPassValid: date)
         
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.isDateStartAtVaild.bind { date in
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.isValidTag.bind { date in
         guard let value = self.viewModel.isValidTag.value else {return}
         //코스는 아직 불러오기 기능이 없기에 isValidTag 속에 아래 코드 적용
         self.viewModel.courseTags = value
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.isDateLocationVaild.bind { date in
         let flag = self.viewModel.isOkSixBtn()
         self.addCourseFirstView.addFirstView.updateSixCheckButton(isValid: flag)
      }
      
      viewModel.dateName.bind { date in
         guard let text = date else {return}
         self.addCourseFirstView.addFirstView.updateDateName(text: text)
      }
      
      viewModel.visitDate.bind { date in
         guard let text = date else {return}
         self.addCourseFirstView.addFirstView.updateVisitDate(text: text)
         self.viewModel.courseDate = true
      }
      
      viewModel.dateStartAt.bind { date in
         guard let text = date else {return}
         self.addCourseFirstView.addFirstView.updatedateStartTime(text: text)
         self.viewModel.courseStartTime = true
      }
      
      viewModel.tagCount.bind { count in
         self.addCourseFirstView.addFirstView.updateTagCount(count: count ?? 0)
      }
      
      viewModel.dateLocations.bind { date in
         guard let date else {return}
         self.addCourseFirstView.addFirstView.updateDateLocation(text: date)
         self.viewModel.courseLocation = true
      }
   }
   
   func registerCell() {
      addCourseFirstView.collectionView.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
      addCourseFirstView.addFirstView.tendencyTagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
   }
   
   func setDelegate() {
      addCourseFirstView.collectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
      
      addCourseFirstView.addFirstView.tendencyTagCollectionView.do {
         $0.delegate = self
         $0.dataSource = self
      }
      
      addCourseFirstView.addFirstView.dateNameTextField.delegate = self
      imagePickerViewController.delegate = self
   }
   
   func setAddTarget() {
      addCourseFirstView.addFirstView.dateNameTextField.addTarget(self, action: #selector(textFieldDidChanacge(_:)), for: .editingChanged)
      
      addCourseFirstView.addFirstView.sixCheckNextButton.addTarget(self, action: #selector(sixCheckBtnTapped), for: .touchUpInside)
      
      let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(visitDate))
      addCourseFirstView.addFirstView.visitDateContainer.addGestureRecognizer(tapGesture1)
      addCourseFirstView.addFirstView.visitDateContainer.isUserInteractionEnabled = true
      
      let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dateStartAt))
      addCourseFirstView.addFirstView.dateStartAtContainer.addGestureRecognizer(tapGesture2)
      addCourseFirstView.addFirstView.dateStartAtContainer.isUserInteractionEnabled = true
      
      
      let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(datePlaceContainerTapped))
      addCourseFirstView.addFirstView.datePlaceContainer.addGestureRecognizer(tapGesture3)
      addCourseFirstView.addFirstView.datePlaceContainer.isUserInteractionEnabled = true
   }
   
   @objc
   func visitDate() {
      addSheetView.datePickerMode(isDatePicker: true)
      viewModel.isTimePicker = false
      alertVC.delegate = self
      addCourseFirstView.addFirstView.dateNameTextField.resignFirstResponder()
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
      addCourseFirstView.addFirstView.dateNameTextField.resignFirstResponder()
      DispatchQueue.main.async {
         self.alertVC.modalPresentationStyle = .overFullScreen
         self.present(self.alertVC, animated: true, completion: nil)
      }
   }
   
   @objc
   func textFieldDidChanacge(_ textField: UITextField) {
      guard let text = textField.text else {return}
      viewModel.dateName.value = text
      viewModel.satisfyDateName(str: text)
      self.viewModel.courseTitle = !text.isEmpty ? true : false
   }
   
   @objc
   func removeCell(sender: UIButton) {
      guard let cell = sender.superview?.superview as? AddCourseImageCollectionViewCell,
            let indexPath = addCourseFirstView.collectionView.indexPath(for: cell) else { return }
      
      viewModel.pickedImageArr.remove(at: indexPath.item)
      
      let dataSourceCnt = viewModel.pickedImageArr.count
      if dataSourceCnt < 1 {
         cell.updateImageCellUI(isImageEmpty: true, vcCnt: 1)
         viewModel.isPickedImageVaild.value = false
         addCourseFirstView.collectionView.reloadData()
      } else {
         addCourseFirstView.collectionView.deleteItems(at: [indexPath])
      }
      
      self.addCourseFirstView.addFirstView.tendencyTagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
   }
   
   @objc
   func didTapCameraBtn() {
      addCourseFirstView.addFirstView.dateNameTextField.resignFirstResponder()
      viewModel.pickedImageArr.removeAll()
      viewModel.isPickedImageVaild.value = false
      imagePickerViewController.presentPicker(from: self)
   }
   
   @objc
   func didTapTagButton(_ sender: UIButton) {
      guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
      let maxTags = 3
      
      if sender.isSelected {
         // 이미 선택된 태그를 해제하는 로직
         sender.isSelected = false
         self.addCourseFirstView.addFirstView.updateTag(button: sender, buttonType: UnselectedButton())
         self.viewModel.countSelectedTag(isSelected: false, tag: tag)
      } else {
         // 새로 선택하는 태그가 최대 개수 이내일 때만 처리
         if self.viewModel.selectedTagData.count < maxTags {
            sender.isSelected = true
            self.addCourseFirstView.addFirstView.updateTag(button: sender, buttonType: SelectedButton())
            self.viewModel.countSelectedTag(isSelected: true, tag: tag)
         }
      }
   }
   
   @objc
   func broughtTagBtn(_ sender: UIButton) {
      self.addCourseFirstView.addFirstView.updateTag(button: sender, buttonType: SelectedButton())
      self.viewModel.isValidTag.value = true
   }
   
   @objc
   func sixCheckBtnTapped() {
      let secondVC = AddCourseSecondViewController(viewModel: self.viewModel)
      navigationController?.pushViewController(secondVC, animated: false)
   }
   
   @objc
   func datePlaceContainerTapped() {
      // datePlaceContainer가 탭되었을 때 수행할 동작을 여기에 구현합니다.
      print("datePlaceContainer tapped!")
      let locationFilterVC = LocationFilterViewController()
      locationFilterVC.modalPresentationStyle = .overFullScreen
      locationFilterVC.isAddType = true
      locationFilterVC.delegate = self
      self.present(locationFilterVC, animated: true)
   }
   
}

extension AddCourseFirstViewController {
   
   @objc
   override func backButtonTapped() {
      viewModel.course1BackAmplitude()
      super.backButtonTapped()
   }
   
}

extension AddCourseFirstViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      if collectionView == addCourseFirstView.collectionView {
         return CGSize(width: 130, height: 130)
      } else {
         let tagTitle = viewModel.tagData[indexPath.item].tagTitle
         let font = UIFont.suit(.body_med_13)
         let textWidth = tagTitle.width(withConstrainedHeight: 30, font: font)
         let padding: CGFloat = 44
         
         return CGSize(width: textWidth + padding, height: 30)
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      if collectionView == addCourseFirstView.collectionView {
         return 12
      } else {
         return 8
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      if collectionView == addCourseFirstView.collectionView {
         return 0
      } else {
         return 7
      }
   }
   
}

extension AddCourseFirstViewController: UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if collectionView == addCourseFirstView.collectionView {
         let isImageEmpty = (viewModel.pickedImageArr.count<1) ? true : false
         if isImageEmpty  && collectionView == addCourseFirstView.collectionView {
            imagePickerViewController.presentPicker(from: self)
         }
      }
   }
   
}

extension AddCourseFirstViewController: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if collectionView == addCourseFirstView.collectionView {
         let cnt = viewModel.pickedImageArr.count
         if cnt < 1 {
            return 1
         } else {
            viewModel.isPickedImageVaild.value = true
            return cnt
         }
      } else {
         return viewModel.tagData.count
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == addCourseFirstView.collectionView {
         guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
            for: indexPath
         ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
         
         let cnt = viewModel.pickedImageArr.count
         guard let imageIsNotEmpty = viewModel.isPickedImageVaild.value else {return UICollectionViewCell()}
         
         cell.updateImageCellUI(isImageEmpty: !imageIsNotEmpty, vcCnt: 1)
         
         if imageIsNotEmpty {
            self.addCourseFirstView.updateImageCellUI(isEmpty: !imageIsNotEmpty, ImageDataCount: cnt)
            
            cell.configurePickedImage(
               pickedImage: viewModel.pickedImageArr[indexPath.row])
            cell.prepare(image: viewModel.pickedImageArr[indexPath.row])
            cell.deleteImageBtn.tag = indexPath.row
            
            cell.deleteImageBtn.addTarget(self, action: #selector(removeCell(sender:)), for: .touchUpInside)
            
            addCourseFirstView.cameraBtn.addTarget(self, action: #selector(didTapCameraBtn), for: .touchUpInside)
         } else {
            self.addCourseFirstView.updateImageCellUI(isEmpty: !imageIsNotEmpty, ImageDataCount: 0)
         }
         return cell
      } else {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
         cell.updateButtonTitle(tag: self.viewModel.tagData[indexPath.item])
         cell.tendencyTagButton.tag = indexPath.item
         cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
         
         if viewModel.pastDateTagIndex.contains(cell.tendencyTagButton.tag) {
            cell.tendencyTagButton.isSelected = true
            self.addCourseFirstView.addFirstView.updateTag(button: cell.tendencyTagButton, buttonType: SelectedButton())
         } else {
            cell.tendencyTagButton.isSelected = false
            self.addCourseFirstView.addFirstView.updateTag(button: cell.tendencyTagButton, buttonType: UnselectedButton())
         }
         
         return cell
      }
   }
   
}

extension AddCourseFirstViewController: UITextFieldDelegate {
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField == addCourseFirstView.addFirstView.dateNameTextField {
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

extension AddCourseFirstViewController: ImagePickerDelegate {
   
   func didPickImages(_ images: [UIImage]) {
      print("images : \(images)")
      viewModel.pickedImageArr = images
      addCourseFirstView.collectionView.reloadData()
   }
   
}

extension AddCourseFirstViewController: DRBottomSheetDelegate {
   
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

extension AddCourseFirstViewController: LocationFilterDelegate {
   
   //TODO: CourseViewController와 LocationFilterDelegate를 함께 사용하여 getCourse() 메서드를 사용하게 되었으니, 추후 분리해야함.
   func getCourse() {
   }
   
   func didSelectCity(_ country: LocationModel.Country, _ city: LocationModel.City) {
      print("selected : \(city)")
      print("Selected city: \(city.rawValue)")
      viewModel.dateLocations.value = city.rawValue
      viewModel.satisfyDateLocation(str: city.rawValue)
      viewModel.country = country.rawValue
      viewModel.city = city.rawValue
   }
   
}
