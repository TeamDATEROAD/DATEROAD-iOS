//
//  ProfileImageSettingView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class ProfileImageSettingView: BaseView {
    
    // MARK: - UI Properties
    
    private let settingStackView: UIStackView = UIStackView()
    
    private let titleLabel: UILabel = UILabel()
    
    let registerLabel: UILabel = UILabel()
    
    let deleteLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
        
    let disabledButtonType: DRButtonType = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubview(settingStackView)
        settingStackView.addArrangedSubviews(titleLabel, registerLabel, deleteLabel)
    }
    
    override func setLayout() {
        settingStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        settingStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        
        titleLabel.do {
            $0.setLabel(text: StringLiterals.Profile.settingImage,
                        alignment: .center,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.title_bold_18))
        }
        
        registerLabel.do {
            $0.isUserInteractionEnabled = true
            $0.setLabel(text: StringLiterals.Profile.registerImage,
                        alignment: .center,
                        textColor: UIColor(resource: .deepPurple),
                        font: UIFont.suit(.body_semi_15))
        }
        
        deleteLabel.do {
            $0.isUserInteractionEnabled = true
            $0.setLabel(text: StringLiterals.Profile.deleteImage,
                        alignment: .center,
                        textColor: UIColor(resource: .deepPurple),
                        font: UIFont.suit(.body_semi_15))
        }
        
    }
}
