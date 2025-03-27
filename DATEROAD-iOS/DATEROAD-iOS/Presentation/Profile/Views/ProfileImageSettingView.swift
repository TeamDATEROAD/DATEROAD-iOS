//
//  ProfileImageSettingView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

protocol ProfileImageSettingDelegate: AnyObject {
    
    func didTapDeleteImageButton()
    
    func didTapRegisterImageButton()
    
}

final class ProfileImageSettingView: BaseView {
    
    // MARK: - UI Properties
    
    private let settingStackView: UIStackView = UIStackView()
    
    private let titleLabel: DRTextLabel = DRTextLabel(title: StringLiterals.Profile.settingImage, textLabelType: .clear(.bold18_black))
    
    let registerButton: DRTextButton = DRTextButton(title: StringLiterals.Profile.registerImage, buttonName: .semi_white_0)
    
    let deleteButton: DRTextButton = DRTextButton(title: StringLiterals.Profile.deleteImage, buttonName: .semi_white_0)
    
    
    // MARK: - Properties
    
    weak var delegate: ProfileImageSettingDelegate?
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
    
}


// MARK: - Methods

extension ProfileImageSettingView {
    
    func setAddTarget() {
        deleteButton.addTarget(self, action: #selector(didTapDeleteImageButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterImageButton), for: .touchUpInside)
    }
    
}


// MARK: - @objc Methods

extension ProfileImageSettingView {
    
    @objc
    func didTapDeleteImageButton() {
        delegate?.didTapDeleteImageButton()
    }
    
    @objc
    func didTapRegisterImageButton() {
        delegate?.didTapRegisterImageButton()
    }
    
}
