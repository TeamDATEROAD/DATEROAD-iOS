//
//  EditProfileViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 9/3/24.
//

import UIKit

final class EditProfileViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let profileView = ProfileView()
    
    private var profileImageSettingView: ProfileImageSettingView = ProfileImageSettingView()
    
    private let imagePickerViewController = CustomImagePicker(isProfilePicker: true)
    
    lazy var alertVC = DRBottomSheetViewController(contentView: profileImageSettingView,
                                                   height: 288,
                                                   buttonType: DisabledButton(),
                                                   buttonTitle: StringLiterals.Common.cancel)
    
    
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
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.Profile.editProfile, alignment: .center)
        setProfile()
        registerCell()
        setDelegate()
        setAddGesture()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initial = true
        self.profileViewModel.isValidRegistration.value = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.initial = false
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

private extension EditProfileViewController {
    
    func setProfile() {
        guard let profileImage = profileViewModel.profileData.value?.profileImage
        else {
            self.profileView.profileImageView.image = UIImage(resource: .emptyProfileImg)
            return
        }
        
        self.profileView.profileImageView.image = profileImage
        self.profileViewModel.profileImage.value = profileImage
        self.profileView.registerButton.setTitle(StringLiterals.Profile.saveProfile, for: .normal)
        self.profileView.nicknameTextfield.text = profileViewModel.profileData.value?.nickname
    }
    
    func registerCell() {
        self.profileView.tendencyTagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.profileView.tendencyTagCollectionView.dataSource = self
        self.profileView.tendencyTagCollectionView.delegate = self
        self.profileView.nicknameTextfield.delegate = self
        self.imagePickerViewController .delegate = self
    }
    
    func setAddGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.profileView.editImageButton.addTarget(self, action: #selector(presentEditBottomSheet), for: .touchUpInside)
        
        self.profileView.doubleCheckButton.addTarget(self, action: #selector(doubleCheckNickname), for: .touchUpInside)
        
        self.profileView.nicknameTextfield.addTarget(self, action: #selector(didChangeTextfield), for: .editingChanged)
        
        self.profileView.registerButton.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deletePhoto))
        self.profileImageSettingView.deleteLabel.addGestureRecognizer(deleteGesture)
        
        let registerGesture = UITapGestureRecognizer(target: self, action: #selector(registerPhoto))
        self.profileImageSettingView.registerLabel.addGestureRecognizer(registerGesture)
    }
    
    func bindViewModel() {
        self.profileViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess, let type = self?.profileViewModel.type.value else { return }
            if onSuccess {
                switch type {
                case .getDoubleCheck:
                    self?.profileViewModel.getDoubleCheck()
                case .postSignUp:
                    self?.profileViewModel.patchEditProfile()
                default:
                    self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
                }
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.profileViewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.profileViewModel.onFailNetwork.value = false
                    self?.profileViewModel.onEditProfileLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.profileViewModel.profileImage.bind { [weak self] image in
            guard let initial = self?.initial else { return }
            if initial {
                self?.profileViewModel.checkValidNicknameCount()
            }
        }
        
        self.profileViewModel.is5orLess.bind { [weak self] isValid in
            guard let isValid, let isExisted = self?.profileViewModel.isExistedNickname.value
            else { return }
            isExisted
            ? self?.profileView.updateDoubleCheckButton(isValid: !isExisted)
            :self?.profileView.updateDoubleCheckButton(isValid: isValid)
            if isExisted {
                self?.profileViewModel.isValidNickname.value = true
            }
            self?.profileViewModel.checkValidRegistration()
        }
        
        // 중복 확인 결과 변수
        self.profileViewModel.isValidNickname.bind { [weak self] isValid in
            guard let isValid,
                  let initial = self?.initial,
                  let isExistedNickname = self?.profileViewModel.isExistedNickname.value,
                  let nicknameCount = self?.profileViewModel.nickname.value?.count
            else { return }
            if initial {
                self?.profileView.nicknameErrMessageLabel.isHidden = nicknameCount > 5 || isExistedNickname
                isValid
                ? self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isValid)
                : self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValid)
                self?.profileViewModel.checkValidRegistration()
            }
        }
        
        self.profileViewModel.isValidNicknameCount.bind { [weak self] isValidCount in
            guard let isValidCount,
                  let initial = self?.initial,
                  let isValidNickname = self?.profileViewModel.isValidNickname.value
            else { return }
            if initial {
                if isValidNickname {
                    self?.profileView.nicknameErrMessageLabel.isHidden = false
                } else {
                    self?.profileView.nicknameErrMessageLabel.isHidden = isValidCount
                    self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValidCount)
                }
            }
        }
        
        self.profileViewModel.isValidTag.bind { [weak self] isValid in
            guard let isValid, let initial = self?.initial else { return }
            if initial {
                self?.profileView.updateTagErrLabel(isValid: isValid)
                self?.profileViewModel.checkValidRegistration()
            }
        }
        
        self.profileViewModel.nickname.bind { [weak self] nickname in
            guard let nickname else { return }
            self?.profileViewModel.isValidNickname.value = false
            self?.profileViewModel.compareExistingNickname()
            self?.profileView.updateNicknameCount(count: nickname.count)
        }
        
        self.profileViewModel.tagCount.bind { [weak self] count in
            guard let count else { return }
            self?.profileView.updateTagCount(count: count)
        }
        
        self.profileViewModel.isValidRegistration.bind { [weak self] isValid in
            guard let isValid else { return }
            self?.profileView.updateRegisterButton(isValid: isValid)
        }
        
        self.profileViewModel.existingNickname.bind { [weak self] _ in
            self?.profileViewModel.compareExistingNickname()
        }
        
        self.profileViewModel.isExistedNickname.bind { [weak self] isExisted in
            guard let isExisted, let initial = self?.initial else { return }
            self?.profileView.updateDoubleCheckButton(isValid: !isExisted)
            if initial {
                if isExisted {
                    self?.profileViewModel.isValidNickname.value = true
                }
                self?.profileViewModel.checkValidNicknameCount()
            }
        }
        
        self.profileViewModel.onSuccessEdit = { [weak self] isSuccess in
            if isSuccess {
                self?.navigationController?.popViewController(animated: false)
            } else {
                self?.profileView.registerButton.isEnabled = true
                print("fail to edit profile")
            }
        }
        
        self.profileViewModel.onEditProfileLoading.bind { [weak self] onLoading in
            guard let onLoading else { return }
            onLoading ? self?.showLoadingView(type: StringLiterals.TabBar.myPage) : self?.hideLoadingView()
        }
    }
    
    @objc
    func presentEditBottomSheet() {
        alertVC.delegate = self
        DispatchQueue.main.async {
            self.alertVC.presentBottomSheet(in: self)
        }
    }
    
    @objc
    func doubleCheckNickname(sender: UITapGestureRecognizer) {
        self.profileViewModel.getDoubleCheck()
    }
    
    @objc
    func didTapTagButton(_ sender: UIButton) {
        guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
        
        let maxTags = 3
        
        // 3이 아닐 때
        if self.profileViewModel.selectedTagData.count != maxTags {
            sender.isSelected.toggle()
            sender.isSelected
            ? self.profileView.updateTag(button: sender, buttonType: SelectedButton())
            : self.profileView.updateTag(button: sender, buttonType: UnselectedButton())
            self.profileViewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
        }
        // 3일 때 & 눌려있는 상태인 경우
        else {
            if sender.isSelected {
                sender.isSelected.toggle()
                self.profileView.updateTag(button: sender, buttonType:  UnselectedButton())
                self.profileViewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
            }
        }
        self.profileViewModel.checkValidNicknameCount()
    }
    
    @objc
    func didChangeTextfield() {
        guard let text = self.profileView.nicknameTextfield.text else { return }
        self.profileViewModel.nickname.value = text
    }
    
    @objc
    func deletePhoto() {
        alertVC.dismissBottomSheet()
        profileView.updateProfileImage(image: UIImage(resource: .emptyProfileImg))
        profileViewModel.profileImage.value = UIImage(resource: .emptyProfileImg)
    }
    
    @objc
    func registerPhoto() {
        alertVC.dismissBottomSheet()
        imagePickerViewController.presentPicker(from: self)
    }
    
    @objc
    func registerProfile() {
        self.profileView.registerButton.isEnabled = false
        self.profileViewModel.patchEditProfile()
    }
    
}


// MARK: - Delegates

extension EditProfileViewController: UICollectionViewDelegateFlowLayout {
    
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

extension EditProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profileViewModel.tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell
        else { return UICollectionViewCell() }
        cell.tendencyTagButton.tag = indexPath.item
        cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
        cell.updateButtonTitle(title: self.profileViewModel.tagData[indexPath.item].english)
        
        self.profileView.updateTag(button: cell.tendencyTagButton, buttonType: UnselectedButton())
        
        let tagData = profileViewModel.profileData.value?.tags ?? []
        for tags in tagData {
            let tagTitle = self.profileViewModel.tagData[indexPath.item].english
            if tagTitle  == tags {
                self.profileView.updateTag(button: cell.tendencyTagButton, buttonType: SelectedButton())
                cell.tendencyTagButton.isSelected.toggle()
                self.profileViewModel.countSelectedTag(isSelected: cell.tendencyTagButton.isSelected, tag: tagTitle)
            }
        }
        return cell
    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if string.hasCharacters() || isBackSpace == -92 {
                return true
            }
        }
        return false
    }
    
    /// 엔터 키 누르면 키보드 내리는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension EditProfileViewController: DRBottomSheetDelegate {
    
    func didTapBottomButton() {
        alertVC.dismissBottomSheet()
    }
    
    func didTapFirstLabel() {
        self.registerPhoto()
    }
    
    func didTapSecondLabel() {
        self.deletePhoto()
    }
    
}

extension EditProfileViewController: ImagePickerDelegate {
    
    func didPickImages(_ images: [UIImage]) {
        let selectedImage = images[0]
        profileView.updateProfileImage(image: selectedImage)
        self.profileViewModel.profileImage.value = selectedImage
    }
    
}

