//
//  ProfileViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class ProfileViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let profileView = ProfileView()
    
    private var profileImageSettingView: ProfileImageSettingView = ProfileImageSettingView()

    
    // MARK: - Properties

    private var profileViewModel: ProfileViewModel
    
    private var initial: Bool = false
    
        
    // MARK: - Life Cycle
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabelStyle(title: StringLiterals.Profile.myProfile, alignment: .center)
        registerCell()
        setDelegate()
        setAddGesture()
        bindViewModel()
        self.initial = true
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(profileView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        profileView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
}

private extension ProfileViewController {
    
    func registerCell() {
        self.profileView.tendencyTagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.profileView.tendencyTagCollectionView.dataSource = self
        self.profileView.tendencyTagCollectionView.delegate = self
        self.profileView.nicknameTextfield.delegate = self
    }
    
    func setAddGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.profileView.editImageButton.addTarget(self, action: #selector(presentEditBottomSheet), for: .touchUpInside)
        
        self.profileView.doubleCheckButton.addTarget(self, action: #selector(doubleCheckNickname), for: .touchUpInside)
        
        self.profileView.nicknameTextfield.addTarget(self, action: #selector(didChangeTextfield), for: .allEditingEvents)
        
        self.profileView.registerButton.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deletePhoto))
        self.profileImageSettingView.deleteLabel.addGestureRecognizer(deleteGesture)
        
        let registerGesture = UITapGestureRecognizer(target: self, action: #selector(registerPhoto))
        self.profileImageSettingView.registerLabel.addGestureRecognizer(registerGesture)
        
        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(cancel))
        self.profileImageSettingView.registerLabel.addGestureRecognizer(cancelGesture)

    }
    
    // TODO: - 추후 중복확인 연결 시 수정 예정
    func bindViewModel() {
        self.profileViewModel.isValidNickname.bind { [weak self] isValid in
            guard let isValid,  let initial = self?.initial else { return }
            if initial {
                self?.profileView.nicknameErrMessageLabel.isHidden = false
                isValid ? self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isValid) : self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValid)

                self?.profileViewModel.checkValidRegistration()
            }
        }
        
        self.profileViewModel.isValidNicknameCount.bind { [weak self] isValidCount in
            guard let isValidCount, let initial = self?.initial else { return }
            if initial {
                self?.profileView.nicknameErrMessageLabel.isHidden = isValidCount ? true : false
                self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValidCount)
                self?.profileView.updateDoubleCheckButton(isValid: isValidCount)
            }
        }
        
        self.profileViewModel.isValidTag.bind { [weak self] isValid in
            guard let isValid, let initial = self?.initial else { return }
            if initial {
                self?.profileView.tagErrMessageLabel.isHidden = isValid ? true : false
                self?.profileView.updateTagErrLabel(isValid: isValid)
            }
            self?.profileViewModel.checkValidRegistration()
        }
        
        self.profileViewModel.nickname.bind { [weak self] nickname in
            guard let nickname else { return }
            self?.profileView.updateNicknameCount(count: nickname.count)
            self?.profileViewModel.checkValidNickname()
        }
        
        self.profileViewModel.tagCount.bind { [weak self] count in
            guard let count else { return }
            self?.profileView.updateTagCount(count: count)
        }
        
        self.profileViewModel.isValidRegistration.bind { [weak self] isValid in
            guard let isValid else { return }
            self?.profileView.updateRegisterButton(isValid: isValid)
        }
        
        self.profileViewModel.onSuccessRegister = { [weak self] isSuccess in
            if isSuccess {
                let mainVC = TabBarController()
                self?.navigationController?.pushViewController(mainVC, animated: false)
            } else {
                let loginVC = LoginViewController()
                self?.navigationController?.pushViewController(loginVC, animated: false)
            }
            
        }
    
    }
    
    @objc
    func presentEditBottomSheet() {
        let alertVC = DRBottomSheetViewController(contentView: profileImageSettingView,
                                                  height: 288,
                                                  buttonType: DisabledButton(),
                                                  buttonTitle: StringLiterals.Common.cancel)
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .overFullScreen
        self.present(alertVC, animated: true)
    }
    
    @objc
    func doubleCheckNickname(sender: UITapGestureRecognizer) {
        // TODO: - 중복 확인 서버 통신
        print("double check")
        self.profileViewModel.getDoubleCheck()
    }
    
    @objc
    func didTapTagButton(_ sender: UIButton) {
        guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }

        // 0 ~ 2개 선택되어 있는 경우
        if self.profileViewModel.tagCount.value != 3 {
            sender.isSelected = !sender.isSelected
            sender.isSelected ? self.profileView.updateTag(button: sender, buttonType: SelectedButton())
            : self.profileView.updateTag(button: sender, buttonType: UnselectedButton())
            self.profileViewModel.countSelectedTag(isSelected: sender.isSelected)
            self.profileViewModel.selectedTagData.append(tag)
        }
        // 3개 선택되어 있는 경우
        else {
            // 취소 하려는 경우
            if sender.isSelected {
                sender.isSelected = !sender.isSelected
                self.profileView.updateTag(button: sender, buttonType: UnselectedButton())
                self.profileViewModel.countSelectedTag(isSelected: sender.isSelected)
                self.profileViewModel.selectedTagData.remove(at: sender.tag)
            }
        }
    }
    
    @objc
    func didChangeTextfield() {
        guard let text = self.profileView.nicknameTextfield.text else { return }
        self.profileViewModel.nickname.value = text
    }
    
    @objc
    func deletePhoto() {
        print("delete")    }
    
    @objc
    func registerPhoto() {
        print("register")
    }
    
    @objc
    func cancel() {
        print("cancel")
    }
    
    @objc
    func registerProfile() {
        self.profileViewModel.postSignUp(image: self.profileView.profileImageView.image)
    }
    
}

// MARK: - Delegates

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = self.profileViewModel.tagData[indexPath.item].tagTitle
        let font = UIFont.suit(.body_med_13)
        let textWidth = tagTitle.width(withConstrainedHeight: 30, font: font)
        let padding: CGFloat = 50
                
       return CGSize(width: textWidth + padding, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profileViewModel.tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
        cell.updateButtonTitle(tag: self.profileViewModel.tagData[indexPath.item])
        cell.tendencyTagButton.tag = indexPath.item
        cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
        return cell
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        return true
    }
    
    /// 엔터 키 누르면 키보드 내리는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileViewController: DRBottomSheetDelegate {
    
    func didTapBottomButton() {
        self.dismiss(animated: true)
    }
    
    func didTapFirstLabel() {
        self.registerPhoto()
    }
    
    func didTapSecondLabel() {
        self.deletePhoto()
    }
}
