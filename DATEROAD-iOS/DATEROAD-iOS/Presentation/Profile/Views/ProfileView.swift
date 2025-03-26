//
//  ProfileView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    
    func didChangeTextfield()
    
    func didTapEditImageButton()
    
    func didTapDoubleCheckButton()
    
    func didTapRegisterButton()
    
}

final class ProfileView: BaseView {
    
    // MARK: - UI Properties
    
    let profileImageView: UIImageView = UIImageView()
    
    private let editImageButton: DRImageButton = DRImageButton(image: UIImage(resource: .icProfileplus), buttonName: .clear_clear_0)
    
    private let nicknameLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.nickname,
        textLabelType: .clear(.bold15_black),
        alignment: .left
    )
    
    private let nicknameInfoLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.nicknameInfo,
        textLabelType: .clear(.med13_gray300),
        alignment: .left
    )
    
    let nicknameTextfield: DRTextField = DRTextField(type: .profile)
    
    let nicknameErrMessageLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.disabledNickname,
        textLabelType: .clear(.reg11_alertRed),
        hidden: true
    )
    
    private let countLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.countPlaceholder,
        textLabelType: .clear(.reg11_gray300),
        alignment: .right
    )
    
    private let datingTendencyLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.dateTendency,
        textLabelType: .clear(.bold15_black),
        alignment: .left
    )
    
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let tagErrMessageLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Profile.selectTag,
        textLabelType: .clear(.reg11_alertRed),
        hidden: true
    )
    
    let registerButton: DRTextButton = DRTextButton(
        title: StringLiterals.Profile.registerProfile,
        buttonName: .bold_gray200_14,
        isEnabled: false
    )
    
    
    // MARK: - Properties
    
    weak var delegate: ProfileDelegate?
    
    private let warningType: DRErrorType = Warning()
    
    private let correctType: DRErrorType = Correct()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    override func setHierarchy() {
        self.addSubviews(profileImageView,
                         editImageButton,
                         nicknameLabel,
                         nicknameInfoLabel,
                         nicknameTextfield,
                         nicknameErrMessageLabel,
                         countLabel,
                         datingTendencyLabel,
                         tendencyTagCollectionView,
                         tagErrMessageLabel,
                         registerButton)
        
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(121)
        }
        
        editImageButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(profileImageView)
            $0.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(43)
            $0.leading.equalToSuperview()
        }
        
        nicknameInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
        }
        
        nicknameTextfield.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        nicknameErrMessageLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextfield.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextfield.snp.bottom).offset(6)
            $0.trailing.equalToSuperview()
        }
        
        datingTendencyLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextfield.snp.bottom).offset(45)
            $0.horizontalEdges.equalToSuperview()
        }
        
        tendencyTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(datingTendencyLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(106)
        }
        
        tagErrMessageLabel.snp.makeConstraints {
            $0.top.equalTo(tendencyTagCollectionView.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        profileImageView.do {
            $0.layer.masksToBounds = true
            $0.backgroundColor = .clear
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        tendencyTagCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
            let layout = CollectionViewLeftAlignFlowLayout()
            layout.cellSpacing = 8
            $0.collectionViewLayout = layout
            
        }
    }
    
}

extension ProfileView {
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        addGestureRecognizer(tapGesture)
        
        nicknameTextfield.addTarget(self, action: #selector(didChangeTextfield), for: .editingChanged)

        editImageButton.addTarget(self, action: #selector(didTapEditImageButton), for: .touchUpInside)
        
        if let button = nicknameTextfield.rightView as? UIButton {
            button.addTarget(self, action: #selector(didTapDoubleCheckButton), for: .touchUpInside)
        }
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    func updateNicknameErrLabel(errorType: ProfileErrorType) {
        switch errorType {
        case .isNotValidCount:
            nicknameErrMessageLabel.updateTextColor(StringLiterals.Profile.minimumNickname, .alertRed)
        
        case .isValid:
            nicknameErrMessageLabel.updateTextColor(StringLiterals.Profile.enabledNickname, .deepPurple)
        
        case .isNotValid:
            nicknameErrMessageLabel.updateTextColor(StringLiterals.Profile.disabledNickname, .alertRed)
        }
    }
    
    func updateTagErrLabel(isValid: Bool) {
        tagErrMessageLabel.isHidden =  isValid
    }
    
    func updateNicknameCount(count: Int) {
        countLabel.do {
            $0.textColor = UIColor(resource: .drBlack)
            $0.text = "\(count)/5"
        }
    }
    
    func updateDoubleCheckButton(isValid: Bool) {
        if let button = nicknameTextfield.rightView as? DRTextButton {
            button.setButtonStyle(isValid ? .med_purple_10 : .med_gray200_10, isEnabled: isValid)
        }
    }
    
    func updateTagCount(count: Int) {
        datingTendencyLabel.text = "나의 데이트 성향 (\(count)/3)"
    }
    
    func updateTag(button: UIButton, buttonType: DRButtonType) {
        button.setButtonStatus(buttonType: buttonType)
    }
    
    func updateRegisterButton(isValid: Bool) {
        registerButton.setButtonStyle(isValid ? .bold_purple_14 : .bold_gray200_14, isEnabled: isValid)
    }
    
    func updateProfileImage(image: UIImage) {
        profileImageView.image = image
    }
    
}


// MARK: - @objc Methods

extension ProfileView {
    
    @objc
    func didChangeTextfield() {
        delegate?.didChangeTextfield()
    }
    
    @objc
    func didTapEditImageButton() {
        delegate?.didTapEditImageButton()
    }
    
    @objc
    func didTapDoubleCheckButton() {
        print("doubleCheckNickname view")
        delegate?.didTapDoubleCheckButton()
    }
    
    @objc
    func didTapRegisterButton() {
        registerButton.isEnabled = false
        delegate?.didTapRegisterButton()
    }
    
}
