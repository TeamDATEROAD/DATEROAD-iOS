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
    
    private let imagePickerViewController = CustomImagePicker(isProfilePicker: true)
    
    
    // MARK: - Properties
    
    private var profileViewModel: ProfileViewModel
    
    private var initial: Bool = false
    
    private var editType: EditType
    
    
    // MARK: - Life Cycle
    
    init(profileViewModel: ProfileViewModel, editType: EditType, profile: ProfileModel) {
        self.profileViewModel = profileViewModel
        self.profileViewModel.profileData.value = profile
        self.editType = editType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel(type: self.editType)
        setProfile()
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
    
    func setTitleLabel(type: EditType) {
        if type == EditType.add {
            setTitleLabelStyle(title: StringLiterals.Profile.myProfile, alignment: .center)
        } else {
            setLeftBackButton()
            setTitleLabelStyle(title: StringLiterals.Profile.editProfile, alignment: .center)
            setProfile()
        }
    }
    
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
        
        self.profileView.nicknameTextfield.addTarget(self, action: #selector(didChangeTextfield), for: .allEditingEvents)
        
        self.profileView.registerButton.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deletePhoto))
        self.profileImageSettingView.deleteLabel.addGestureRecognizer(deleteGesture)
        
        let registerGesture = UITapGestureRecognizer(target: self, action: #selector(registerPhoto))
        self.profileImageSettingView.registerLabel.addGestureRecognizer(registerGesture)
        
    }
    
    func bindViewModel() {
        self.profileViewModel.is5orLess.bind { [weak self] isValid in
            guard let isValid = isValid else { return }
            
            if self?.editType == EditType.edit {
                self?.profileViewModel.checkExistingNickname()
                let isExisted = self?.profileViewModel.isExistedNickname.value ?? true
                isExisted
                ? self?.profileView.updateDoubleCheckButton(isValid: !isExisted)
                :self?.profileView.updateDoubleCheckButton(isValid: isValid)
            } else {
                self?.profileView.updateDoubleCheckButton(isValid: isValid)
            }
            self?.profileViewModel.checkValidRegistration()
        }
        
        self.profileViewModel.isValidNickname.bind { [weak self] isValid in
            guard let isValid,  let initial = self?.initial 
            else { return }
            
            if initial {
                self?.profileView.nicknameErrMessageLabel.isHidden = false
                isValid
                ? self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isValid)
                : self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValid)
                
                self?.profileViewModel.checkValidRegistration()
            }
        }
        
        self.profileViewModel.isValidNicknameCount.bind { [weak self] isValidCount in
            guard let isValidCount, let initial = self?.initial else { return }
            if initial {
                self?.profileView.nicknameErrMessageLabel.isHidden = isValidCount ? true : false
                self?.profileView.updateNicknameErrLabel(errorType: ProfileErrorType.isNotValidCount)
                
                if self?.editType == EditType.edit {
                    self?.profileViewModel.checkExistingNickname()
                    let isValid = self?.profileViewModel.isExistedNickname.value ?? true
                    isValid
                    ? self?.profileView.updateDoubleCheckButton(isValid: !isValid)
                    :self?.profileView.updateDoubleCheckButton(isValid: isValidCount)
                } else {
                    self?.profileView.updateDoubleCheckButton(isValid: isValidCount)
                }
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
        
        self.profileViewModel.profileData.bind { [weak self] profileData in
            guard let profileData else { return }
            self?.profileViewModel.nickname.value = profileData.nickname
            self?.profileViewModel.existingNickname.value = profileData.nickname
            self?.profileViewModel.checkExistingNickname()
            self?.profileViewModel.selectedTagData = profileData.tags
            self?.profileViewModel.checkValidRegistration()
        }
        
        self.profileViewModel.isExistedNickname.bind { [weak self] isExisted in
            guard let isExisted else { return }
            self?.profileView.updateDoubleCheckButton(isValid: !isExisted)
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
        
        self.profileViewModel.onSuccessEdit = { [weak self] isSuccess in
            if isSuccess {
                self?.navigationController?.popViewController(animated: false)
            } else {
                // TODO: - 토스트 메세지 추가
                print("fail to edit profile")
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
        self.profileViewModel.getDoubleCheck()
    }
    
    @objc
    func didTapTagButton(_ sender: UIButton) {
        guard let tag = TendencyTag(rawValue: sender.tag)?.tag.english else { return }
        
        let maxTags = 3
        
        // 3이 아닐 때
        if self.profileViewModel.selectedTagData.count != maxTags {
            sender.isSelected.toggle()
            sender.isSelected ? self.profileView.updateTag(button: sender, buttonType: SelectedButton())
            : self.profileView.updateTag(button: sender, buttonType: UnselectedButton())
            self.profileViewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
            self.profileViewModel.isValidTag.value = true
        }
        // 그 외
        else {
            if sender.isSelected {
                sender.isSelected.toggle()
                self.profileView.updateTag(button: sender, buttonType:  UnselectedButton())
                self.profileViewModel.countSelectedTag(isSelected: sender.isSelected, tag: tag)
                self.profileViewModel.isValidTag.value = false
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
        self.dismiss(animated: true)
        profileView.updateProfileImage(image: UIImage(resource: .emptyProfileImg))
    }
    
    @objc
    func registerPhoto() {
        self.dismiss(animated: true)
        imagePickerViewController.presentPicker(from: self)
    }
    
    @objc
    func registerProfile() {
        self.editType == EditType.add
        ? self.profileViewModel.postSignUp(image: self.profileView.profileImageView.image)
        : self.profileViewModel.patchEditProfile()
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
        cell.tendencyTagButton.tag = indexPath.item
        cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
        
        if editType == EditType.edit {
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
        } else {
            cell.updateButtonTitle(tag: self.profileViewModel.tagData[indexPath.item])
        }
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

extension ProfileViewController: ImagePickerDelegate {
    
    func didPickImages(_ images: [UIImage]) {
        let selectedImage = images[0]
        
        /// 앨범에서 고른 사진 프로필뷰 사진에 반영
        profileView.updateProfileImage(image: selectedImage)
        self.profileViewModel.profileImage.value = selectedImage
    }
    
}
