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
        
        let editImageButtonGesture = UITapGestureRecognizer(target: self, action: #selector(presentEditBottomSheet))
        self.profileView.editImageButton.addGestureRecognizer(editImageButtonGesture)
        
        self.profileView.doubleCheckButton.addTarget(self, action: #selector(doubleCheckNickname), for: .touchUpInside)
        
        self.profileView.nicknameTextfield.addTarget(self, action: #selector(didChangeTextfield), for: .editingChanged)
    }
    
    func bindViewModel() {
        self.profileViewModel.isValidNickname.bind { [weak self] isValid in
            guard let isValid else { return }
            self?.profileView.nicknameErrMessageLabel.isHidden = isValid ? false : true
            self?.profileView.updateNicknameErrLabel(isValid: isValid)
            self?.profileView.updateDoubleCheckButton(isValid: isValid)
            self?.profileViewModel.checkValidRegistration()
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
    }
    
    @objc
    func presentEditBottomSheet(sender: UITapGestureRecognizer) {
        // TODO: - 프로필 편집 바텀 시트 띄우기
    }
    
    @objc
    func doubleCheckNickname(sender: UITapGestureRecognizer) {
        // TODO: - 중복 확인 서버 통신
        print("double check")
    }
    
    @objc
    func didTapTagButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? self.profileView.updateTag(button: sender, buttonType: SelectedButton())
        : self.profileView.updateTag(button: sender, buttonType: UnselectedButton())
        self.profileViewModel.countSelectedTag(isSelected: sender.isSelected)
    }
    
    @objc
    func didChangeTextfield() {
        let text = self.profileView.nicknameTextfield.text ?? ""
        self.profileViewModel.nickname.value = text
    }
    
}

// MARK: - Delegates

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = self.profileViewModel.tagData[indexPath.item]
        let font = UIFont.suit(.body_med_13)
        let textWidth = tagTitle.width(withConstrainedHeight: 30, font: font)
        let padding: CGFloat = 28
                
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
        cell.updateButtonTitle(title: self.profileViewModel.tagData[indexPath.item])
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

