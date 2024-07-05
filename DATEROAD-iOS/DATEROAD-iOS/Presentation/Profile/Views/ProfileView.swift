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
    
    let editImageButton: UIImageView = UIImageView()
    
    private let nicknameLabel: UILabel = UILabel()
    
    private let nicknameTextfield: UITextField = UITextField()
    
    private let doubleCheckButton: UIButton = UIButton()
    
    private let errorMessageLabel: UILabel = UILabel()
    
    private let countLabel: UILabel = UILabel()
    
    private let datingTendencyLabel: UILabel = UILabel()
    
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let registerButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButton = EnabledButton()
    
    private let disabledButtonType: DRButton = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(profileImageView,
                         nicknameLabel,
                         nicknameTextfield,
                         errorMessageLabel,
                         countLabel,
                         datingTendencyLabel,
                         tendencyTagCollectionView,
                         registerButton)
        
        profileImageView.addSubview(editImageButton)
        nicknameTextfield.addSubview(doubleCheckButton)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(121)
        }
        
        editImageButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
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
        
        errorMessageLabel.snp.makeConstraints {
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
            $0.image = UIImage(resource: .icProfileplus)
        }
        
        nicknameLabel.do {
            $0.setLabel(text: StringLiterals.Profile.nickname,
                        alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.body_bold_15))
        }
        
        nicknameTextfield.do {
            $0.textColor = UIColor(resource: .drBlack)
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
            $0.placeholder = StringLiterals.Profile.nicknamePlaceholder
            $0.setPlaceholder(placeholder: StringLiterals.Profile.nicknamePlaceholder, fontColor: UIColor(resource: .gray300), font: UIFont.suit(.body_semi_15))
        }
        
        doubleCheckButton.do {
            $0.setButtonStatus(buttonType: disabledButtonType)
        }
        
        errorMessageLabel.do {
            $0.isHidden = true
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .alertRed), font: UIFont.suit(.cap_reg_11))
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
        }
    }
}

extension ProfileView {
    
}
