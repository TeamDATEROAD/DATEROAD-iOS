//
//  AddCourseThirdViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseThirdViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private var addCourseThirdView = AddCourseThirdView()
    
    private let viewModel: AddCourseViewModel
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    private var keyboardHeight: CGFloat = 0.0
    
    
    // MARK: - Initializer
    
    init(viewModel: AddCourseViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addCourseThirdView.addThirdView.updateContentTextView(
            addCourseThirdView.addThirdView.contentTextView,
            withText: viewModel.contentText,
            placeholder: addCourseThirdView.addThirdView.textViewPlaceHolder
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setTitleLabelStyle(title: StringLiterals.AddCourseOrSchedule.addCourseTitle, alignment: .center)
        setLeftBackButton()
        setDelegate()
        registerCell()
        addTarget()
        bindViewModel()
        setupKeyboardDismissRecognizer()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        addCourseThirdView.addThirdView.contentTextView.addDoneButton()
    }
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubview(contentView)
        contentView.addSubview(addCourseThirdView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        addCourseThirdView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        addCourseThirdView.do {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
}


// MARK: - ViewController Methods

private extension AddCourseThirdViewController {
    
    func registerCell() {
        addCourseThirdView.collectionView.do {
            $0.register(AddCourseImageCollectionViewCell.self, forCellWithReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier)
        }
    }
    
    func setDelegate() {
        addCourseThirdView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
        addCourseThirdView.addThirdView.contentTextView.delegate = self
        addCourseThirdView.addThirdView.priceTextField.delegate = self
    }
    
    func addTarget() {
        addCourseThirdView.addThirdDoneBtn.addTarget(self, action: #selector(didTapAddCourseBtn), for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.viewModel.isSuccessPostData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.successDone()
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
                    // 코스 등록 3 로딩뷰, 에러뷰 false 설정
                    self?.viewModel.onFailNetwork.value = false
                    self?.viewModel.onLoading.value = false
                    self?.addCourseThirdView.addThirdDoneBtn.isUserInteractionEnabled = true
                }
                
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.viewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.viewModel.onFailNetwork.value else { return }
            
            if !onFailNetwork {
                onLoading ? self?.showLoadingView(type: StringLiterals.TabBar.myPage) : self?.hideLoadingView()
            }
        }
        
        self.viewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.viewModel.postAddCourse()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        viewModel.contentTextCount.bind { [weak self] date in
            self?.addCourseThirdView.addThirdView.updateContentTextCount(textCnt: date ?? 0)
            let flag = (date ?? 0) >= 200 ? true : false
            self?.viewModel.contentFlag = flag
            self?.viewModel.isDoneBtnValid()
        }
        
        viewModel.priceText.bind { [weak self] date in
            guard let date else {return}
            self?.addCourseThirdView.addThirdView.updatePriceText(price: date)
            let flag = (date >= 0)
            self?.viewModel.courseCost = flag
            self?.viewModel.price = date
            self?.viewModel.priceFlag = flag
            self?.viewModel.isDoneBtnValid()
        }
        
        viewModel.isDoneBtnOK.bind { [weak self] date in
            self?.addCourseThirdView.updateAddThirdDoneBtn(isValid: date ?? false)
        }
    }
    
    func successDone() {
        let customAlertVC = DRCustomAlertViewController(
            rightActionType: .none,
            alertTextType: .hasDecription,
            titleText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertTitleLabel,
            descriptionText: StringLiterals.AddCourseOrSchedule.AddCourseAlert.alertSubTitleLabel,
            longButton: DRTextButton(title: StringLiterals.AddCourseOrSchedule.AddCourseAlert.doneButton, buttonName: .bold_purple_10)
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    func goBackOriginVCForAddCourse() {
        let tabbarVC = TabBarController()
        tabbarVC.selectedIndex = 1
        navigationController?.popToPreviousViewController(ofType: AddCourseFirstViewController.self, defaultViewController: tabbarVC)
    }
    
    func adjustScrollViewForKeyboard(showKeyboard: Bool) {
        let maxKeyboardHeight: CGFloat = 90
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: showKeyboard ? min(keyboardHeight, maxKeyboardHeight) : 0, right: 0)
        addCourseThirdView.scrollView.contentInset = contentInsets
        addCourseThirdView.scrollView.scrollIndicatorInsets = contentInsets
        
        var visibleRect = CGRect()
        visibleRect.size = addCourseThirdView.scrollView.contentSize
        addCourseThirdView.scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            adjustScrollViewForKeyboard(showKeyboard: true)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        adjustScrollViewForKeyboard(showKeyboard: false)
    }
    
}

extension AddCourseThirdViewController {
    
    @objc
    override func backButtonTapped() {
        viewModel.course3BackAmplitude()
        super.backButtonTapped()
    }
    
}


extension AddCourseThirdViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == addCourseThirdView.addThirdView.textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
        /// textView가 선택되면 priceTextField 키보드 비활성화
        addCourseThirdView.addThirdView.priceTextField.resignFirstResponder()
        print(textView.text ?? "")
        
        viewModel.contentText = textView.text ?? ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        addCourseThirdView.addThirdView.updateContentTextView(
            addCourseThirdView.addThirdView.contentTextView,
            withText: viewModel.contentText,
            placeholder: addCourseThirdView.addThirdView.textViewPlaceHolder
        )
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.setFontAndLineLetterSpacing(textView.text,
                                             font:UIFont.systemFont(ofSize: 13, weight: .semibold))
        
        viewModel.contentText = textView.text
        viewModel.contentTextCount.value = textView.text.count
        viewModel.courseContentNum = textView.text.count
        print("🎉\(textView.text.count)🎉")
        viewModel.courseContentBool = textView.text.count > 0 ? true : false
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
}


// MARK: - UITextFieldDelegate Methods

extension AddCourseThirdViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            // 뷰를 이동시키지 않고 제약 조건만 변경
            self.addCourseThirdView.addThirdDoneBtn.snp.remakeConstraints { make in
                make.height.equalTo(54)
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-10) // 키보드 위로 위치
            }
            self.view.layoutIfNeeded() // 레이아웃 즉시 갱신
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            // 원래의 제약 조건으로 되돌림
            self.addCourseThirdView.addThirdDoneBtn.snp.remakeConstraints { make in
                make.height.equalTo(54)
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-4) // 안전 영역 하단에 위치
            }
            self.view.layoutIfNeeded() // 레이아웃 즉시 갱신
        }
        // textField 값이 변경된 경우 ',' 제거한 값으로 처리
        let money = textField.text?.filter { $0.isNumber }
        viewModel.priceText.value = Int(money ?? "0")
    }
    
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate Methods

extension AddCourseThirdViewController: UICollectionViewDelegate {
    
}

extension AddCourseThirdViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pickedImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddCourseImageCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? AddCourseImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.updateImageCellUI(isImageEmpty: false, vcCnt: 2)
        cell.configurePickedImage(pickedImage: viewModel.pickedImageArr[indexPath.item])
        cell.prepare(image: viewModel.pickedImageArr[indexPath.item])
        
        return cell
    }
    
}


// MARK: - Alert Delegate

extension AddCourseThirdViewController: DRCustomAlertDelegate {
    
    func exit() {
        addCourseThirdView.addThirdDoneBtn.isEnabled = true
        goBackOriginVCForAddCourse()
    }
    
    @objc
    private func didTapAddCourseBtn() {
        addCourseThirdView.addThirdDoneBtn.isEnabled = false
        viewModel.postAddCourse()
    }
    
}
