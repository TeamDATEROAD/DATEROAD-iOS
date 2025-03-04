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
    
    let registerButton: DRTextButton = DRTextButton(title: StringLiterals.Profile.settingImage, buttonName: .semi_white_0)
    
    let deleteButton: DRTextButton = DRTextButton(title: StringLiterals.Profile.deleteImage, buttonName: .semi_white_0)
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubview(settingStackView)
        settingStackView.addArrangedSubviews(
            titleLabel,
            registerButton,
            deleteButton
        )
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
        
        titleLabel.setLabel(text: StringLiterals.Profile.settingImage,
                            alignment: .center,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.suit(.title_bold_18))
    }
    
}
