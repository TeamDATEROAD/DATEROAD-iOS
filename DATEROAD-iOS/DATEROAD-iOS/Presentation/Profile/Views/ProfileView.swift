//
//  ProfileView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class ProfileView: BaseView {
    
    // MARK: - UI Properties
    
    private let profileImageView: UIImageView = UIImageView()
    
    let editImageButton: UIButton = UIButton()
    
    private let nicknameLabel: UILabel = UILabel()
    
    let nicknameTextfield: UITextField = UITextField()
    
    private let rightViewBox: UIView = UIView()
    
    let doubleCheckButton: UIButton = UIButton()
    
    let nicknameErrMessageLabel: UILabel = UILabel()
    
    private let countLabel: UILabel = UILabel()
    
    private let datingTendencyLabel: UILabel = UILabel()
    
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let tagErrMessageLabel: UILabel = UILabel()

    let registerButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    private let warningType: DRErrorType = Warning()
    
    private let correctType: DRErrorType = Correct()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(profileImageView,
                         editImageButton,
                         nicknameLabel,
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
            $0.horizontalEdges.equalToSuperview()
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
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = $0.frame.size.width / 2
        }
        
        editImageButton.do {
            $0.setImage(UIImage(resource: .icProfileplus), for: .normal)
            $0.isUserInteractionEnabled = true
        }
        
        nicknameLabel.do {
            $0.setLabel(text: StringLiterals.Profile.nickname,
                        alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.body_bold_15))
        }
        
        nicknameTextfield.do {
            rightViewBox.addSubview(doubleCheckButton)
            rightViewBox.snp.makeConstraints {
                $0.width.equalTo(90)
                $0.height.equalTo(30)
            }
            doubleCheckButton.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.verticalEdges.equalToSuperview()
                $0.width.equalTo(74)
            }
            $0.rightView = rightViewBox
            $0.rightViewMode = .always
            
            $0.setLeftPadding(amount: 16)
            $0.textColor = UIColor(resource: .drBlack)
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
            $0.placeholder = StringLiterals.Profile.nicknamePlaceholder
            $0.setPlaceholder(placeholder: StringLiterals.Profile.nicknamePlaceholder, fontColor: UIColor(resource: .gray300), font: UIFont.suit(.body_semi_15))
        }
        
        doubleCheckButton.do {
            $0.setTitle(StringLiterals.Profile.doubleCheck, for: .normal)
            $0.setButtonStatus(buttonType: disabledButtonType)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
        }
        
        nicknameErrMessageLabel.do {
            $0.isHidden = true
            $0.setErrorLabel(text: StringLiterals.Profile.disabledNickname, errorType: warningType)
        }
        
        countLabel.do {
            $0.setLabel(text: StringLiterals.Profile.countPlaceholder, 
                        alignment: .right ,
                        textColor: UIColor(resource: .gray300),
                        font: UIFont.suit(.cap_reg_11))
        }
        
        datingTendencyLabel.do {
            $0.setLabel(text: StringLiterals.Profile.dateTendency,
                        alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.body_bold_15))
        }
     
        registerButton.do {
            $0.setTitle(StringLiterals.Profile.registerProfile, for: .normal)
            $0.setButtonStatus(buttonType: disabledButtonType)
        }
        
        tendencyTagCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
            let layout = CollectionViewLeftAlignFlowLayout()
            layout.cellSpacing = 8
            $0.collectionViewLayout = layout

        }
        
        tagErrMessageLabel.do {
            $0.isHidden = true
            $0.setErrorLabel(text: StringLiterals.Profile.selectTag, errorType: warningType)
        }
        
    }
}

extension ProfileView {
    
    func updateNicknameErrLabel(isValid: Bool) {
        isValid ? nicknameErrMessageLabel.setErrorLabel(text: StringLiterals.Profile.enabledNickname, errorType: self.correctType)
        : nicknameErrMessageLabel.setErrorLabel(text: StringLiterals.Profile.disabledNickname, errorType: self.warningType)
    }
    
    func updateTagErrLabel(isValid: Bool) {
        tagErrMessageLabel.isHidden =  isValid ? true : false
    }
    
    func updateNicknameCount(count: Int) {
        countLabel.do {
            $0.textColor = UIColor(resource: .drBlack)
            $0.text = "\(count)/5"
        }
    }
    
    func updateDoubleCheckButton(isValid: Bool) {
       isValid ? doubleCheckButton.setButtonStatus(buttonType: enabledButtonType)
        : doubleCheckButton.setButtonStatus(buttonType: disabledButtonType)
        doubleCheckButton.titleLabel?.font = UIFont.suit(.body_med_13)
    }
    
    func updateTagCount(count: Int) {
        datingTendencyLabel.text = "나의 데이트 성향 (\(count)/3)"
    }

    func updateTag(button: UIButton, buttonType: DRButtonType) {
        button.setButtonStatus(buttonType: buttonType)
    }
    
    func updateRegisterButton(isValid: Bool) {
       isValid ? registerButton.setButtonStatus(buttonType: enabledButtonType)
        : registerButton.setButtonStatus(buttonType: disabledButtonType)
        registerButton.titleLabel?.font = UIFont.suit(.body_bold_15)
    }
    
}
