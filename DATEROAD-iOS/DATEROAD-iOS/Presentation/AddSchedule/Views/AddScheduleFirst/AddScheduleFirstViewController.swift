//
//  AddScheduleFirstViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

final class AddScheduleFirstViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    let addScheduleFirstView = AddScheduleFirstView()
    
    let addSheetView = AddSheetView(isCustomPicker: false)
    
    lazy var alertVC = DRBottomSheetViewController(contentView: addSheetView,
                                                   height: 304,
                                                   buttonType: EnabledButton(),
                                                   buttonTitle: StringLiterals.AddCourseOrSchedule.AddBottomSheetView.datePickerBtnTitle)
    
    let locationFilterVC = LocationFilterViewController()
    
    private let loadingView: DRLoadingView = DRLoadingView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    let viewModel: AddScheduleViewModel
    
    
    // MARK: - Initializer
    
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
        broughtButtonHandling()
        
        AmplitudeManager.shared.trackEventWithProperties(StringLiterals.Amplitude.EventName.viewAddSchedule, properties: [StringLiterals.Amplitude.Property.viewPath: viewModel.viewPath])
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


// MARK: - AddScheduleFirstVC Methods

private extension AddScheduleFirstViewController {
    
    func bindViewModel() {
        self.viewModel.outputIsBroughtDataConfigured.lazyBind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.addScheduleFirstView.inAddScheduleFirstView.tendencyTagCollectionView.reloadData()
            }
        }
        
        self.viewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            
            // 에러 발생 시 에러 뷰로 push
            if onFailure {
                let errorVC = DRErrorViewController()
                
                // DRErrorViewController가 닫힐 때의 동작 정의
                errorVC.onDismiss = {
                    print("🚀onDismiss 출동🚀")
                    // 일정 등록 1 로딩뷰, 에러뷰 false 설정
                    self?.viewModel.onFailNetwork.value = false
                    self?.viewModel.onLoading.value = false
                }
                
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.viewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.viewModel.onFailNetwork.value else { return }
            // getData 중이거나, 에러 발생 X라면
            if onFailNetwork == false || onLoading == false {
                self?.hideLoadingView()
                self?.addScheduleFirstView.isHidden = onLoading
                self?.tabBarController?.tabBar.isHidden = onLoading
            }
        }
        
        viewModel.outputDateNameVaild.lazyBind { [weak self] value in
            guard let self, let value else {return}
            self.addScheduleFirstView.updateDateNameTextField(isPassValid: value)
            self.addScheduleFirstView.inAddScheduleFirstView.updateDateName(text: viewModel.inputDateName.value ?? "")
            isValidNextBtn()
        }
        
        viewModel.outputVisitDateVaild.bind { [weak self] value in
            guard let self, let value,
                  let data = self.viewModel.inputVisitDate.value
            else {return}
            
            self.addScheduleFirstView.updateVisitDateTextField(isPassValid: value)
            
            let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: data)
            self.addScheduleFirstView.inAddScheduleFirstView.updateVisitDate(text: formattedDate)
            isValidNextBtn()
        }
        
        viewModel.outputDateStartAtVaild.bind { [weak self] value in
            guard let self, let value,
                  let data = self.viewModel.inputDateStartAt.value
            else {return}
            self.addScheduleFirstView.inAddScheduleFirstView.updatedateStartTime(text: data)
            isValidNextBtn()
        }
        
        viewModel.outputDateTag.bind { [weak self] bool in
            guard let self else {return}
            let count = viewModel.selectedTagData.count
            self.addScheduleFirstView.inAddScheduleFirstView.updateTagCount(count: count)
            isValidNextBtn()
        }
        
        viewModel.outputDateLocation.lazyBind { [weak self] city in
            guard let self, let city else {return}
            self.addScheduleFirstView.inAddScheduleFirstView.updateDateLocation(text: city)
            isValidNextBtn()
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
        addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.addTarget(self, action: #selector(dateNameTextFieldDidChange(_:)), for: .editingChanged)
        
        addScheduleFirstView.inAddScheduleFirstView.sixCheckNextButton.addTarget(self, action: #selector(sixCheckBtnTapped), for: .touchUpInside)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(visitDateTapped))
        addScheduleFirstView.inAddScheduleFirstView.visitDateContainer.addGestureRecognizer(tapGesture1)
        addScheduleFirstView.inAddScheduleFirstView.visitDateContainer.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dateStartAtTapped))
        addScheduleFirstView.inAddScheduleFirstView.dateStartAtContainer.addGestureRecognizer(tapGesture2)
        addScheduleFirstView.inAddScheduleFirstView.dateStartAtContainer.isUserInteractionEnabled = true
        
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(datePlaceContainerTapped))
        addScheduleFirstView.inAddScheduleFirstView.datePlaceContainer.addGestureRecognizer(tapGesture3)
        addScheduleFirstView.inAddScheduleFirstView.datePlaceContainer.isUserInteractionEnabled = true
    }
    
    func isValidNextBtn() {
        self.addScheduleFirstView.inAddScheduleFirstView.updateSixCheckButton(isValid: self.viewModel.isEnableNextButton())
    }
    
    /// 우측 상단 '불러오기' 버튼 함수
    @objc
    func didTapNavRightBtn() {
        let vc = NavViewedCourseViewController(viewedCourseViewModel: MyCourseListViewModel())
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickBringCourse)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}


//MARK: - AddScheduleFirstViewController: BaseNavBarViewController

extension AddScheduleFirstViewController {
    
    // '일정 등록' 중 불러오기 버튼 핸들링
    func broughtButtonHandling() {
        switch viewModel.isBroughtData {
        case true:
            self.showLoadingView(type: StringLiterals.AddCourseOrSchedule.addScheduleTitle)
            viewModel.inputIsBroughtData.value = true
        case false:
            setRightBtnStyle()
            setRightButtonAction(target: self, action: #selector(didTapNavRightBtn))
        }
    }
    
    /// BaseNavBarViewController에서 backButtonTapped() 오버라이드
    @objc
    override func backButtonTapped() {
        viewModel.addScheduleAmplitude.sendAmplitudeEvent(step: 1)
        super.backButtonTapped()
    }
    
}


//MARK: - AddScheduleFirstViewController: '일정등록 뷰1 프로퍼티' 관련 함수

private extension AddScheduleFirstViewController {
    
    /// DatePicker 관련
    func presentDatePicker(mode: DatePickerMode) {
        addSheetView.datePickerMode(isDatePicker: mode == .date)
        alertVC.delegate = self
        addScheduleFirstView.inAddScheduleFirstView.dateNameTextField.resignFirstResponder()
        alertVC.presentBottomSheet(in: self)
    }
    
    /// about 데이트이름
    @objc
    func dateNameTextFieldDidChange(_ textField: UITextField) {
        viewModel.inputDateName.value = textField.text
    }
    
    /// '방문일자' 관련
    @objc
    func visitDateTapped() {
        presentDatePicker(mode: .date)
    }
    
    /// '데이트 시작 시간' 관련
    @objc
    func dateStartAtTapped() {
        presentDatePicker(mode: .time)
    }
    
    /// dateTag 관련
    @objc
    func didTapTagButton(_ sender: UIButton) {
        guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
        let maxTags = 3
        
        if sender.isSelected { //해당 버튼이 이미 눌린 상태라면
            sender.isSelected.toggle()
            self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: UnselectedButton())
            self.viewModel.countSelectedTag(isSelected: false, tag: tag)
        } else { //해당 버튼이 안 눌린 상태라면
            // 새로 선택하는 태그가 최대 개수 이내일 때만 처리
            if self.viewModel.selectedTagData.count < maxTags {
                sender.isSelected.toggle()
                self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: sender, buttonType: SelectedButton())
                self.viewModel.countSelectedTag(isSelected: true, tag: tag)
            }
        }
    }
    
    /// datePlace 관련
    @objc
    func datePlaceContainerTapped() {
        locationFilterVC.isAddType = true
        locationFilterVC.delegate = self
        DispatchQueue.main.async {
            self.locationFilterVC.presentBottomSheet(in: self)
        }
    }
    
    /// 일정등록 뷰1 '다음' 버튼 관련
    @objc
    func sixCheckBtnTapped() {
        let secondVC = AddScheduleSecondViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(secondVC, animated: false)
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


//MARK: - Tag CollectionView 세팅

extension AddScheduleFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
        cell.updateButtonTitle(tag: self.viewModel.tagData[indexPath.item])
        cell.tendencyTagButton.tag = indexPath.item
        cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
        
        if viewModel.pastDateTagIndex.contains(cell.tendencyTagButton.tag) {
            cell.tendencyTagButton.isSelected = true
            self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: cell.tendencyTagButton, buttonType: SelectedButton())
        } else {
            cell.tendencyTagButton.isSelected = false
            self.addScheduleFirstView.inAddScheduleFirstView.updateTag(button: cell.tendencyTagButton, buttonType: UnselectedButton())
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
    
    func didTapBottomButton() {
        let selectedDate = addSheetView.datePicker.date
        alertVC.dismissBottomSheet()
        
        if addSheetView.datePicker.datePickerMode == .date {
            updateTextField(selectedValue: selectedDate, mode: .date)
        } else {
            updateTextField(selectedValue: selectedDate, mode: .time)
        }
    }
    
    //'방문일자', '시작시간' 업데이트 함수
    func updateTextField(selectedValue: Date, mode: DatePickerMode) {
        switch mode {
        case .date:
            viewModel.inputVisitDate.value = selectedValue
        case .time:
            viewModel.inputDataStartAtTransForm.value = selectedValue
        }
    }
    
}

extension AddScheduleFirstViewController: LocationFilterDelegate {
    
    //TODO: CourseViewController와 LocationFilterDelegate를 함께 사용하여 getCourse() 메서드를 사용하게 되었으니, 추후 분리해야함.
    func getCourse() {
    }
    
    func didSelectCity(_ country: LocationModel.Country, _ city: LocationModel.City) {
        print("selected country : \(country.rawValue)")
        print("Selected city: \(city.rawValue)")
        var arr = Array(repeating: "", count: 2)
        arr[0] = country.rawValue
        arr[1] = city.rawValue
        viewModel.inputDateLocation.value = arr
    }
    
}

