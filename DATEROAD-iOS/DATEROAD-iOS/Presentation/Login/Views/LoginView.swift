//
//  LoginView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

protocol LoginDelegate: AnyObject {

    func didTapKakaoLoginButton()
    
    func didTapAppleLoginButton()
    
    func didTapPrivacyPolicyButton()
    
}

final class LoginView: BaseView {
    
    // MARK: - UI Properties
    
    private let logoImageView: UIImageView = UIImageView()
    
    let kakaoLoginButton: UIButton = UIButton()
    
    let appleLoginButton: DRTextButton = DRTextButton(title: StringLiterals.Login.appleLoginLabel, buttonName: .bold_black_14)
    
    let privacyPolicyButton: DRTextButton = DRTextButton(title: StringLiterals.Login.privacyPolicyLabel, buttonName: .med_purple_0)
    
    
    // MARK: - Properties
    
    weak var delegate: LoginDelegate?
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            logoImageView,
            kakaoLoginButton,
            appleLoginButton,
            privacyPolicyButton
        )
    }
    
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(ScreenUtils.height / 812 * 210)
            $0.centerX.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-16)
            $0.width.equalToSuperview().inset(38)
            $0.height.equalTo(45)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(38)
            $0.height.equalTo(45)
            $0.bottom.equalTo(privacyPolicyButton.snp.top).offset(-30)
        }
        
        privacyPolicyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(26)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .purple600)
        
        logoImageView.do {
            $0.image = UIImage(resource: .splashLogo)
            $0.contentMode = .scaleAspectFit
        }
        
        kakaoLoginButton.do {
            $0.setButtonStatus(buttonType: KakaoLoginButton())
            $0.setImage(UIImage(resource: .kakaoLogo), for: .normal)
            $0.setTitle(StringLiterals.Login.kakaoLoginLabel, for: .normal)
            $0.setTitleColor(UIColor(resource: .drBlack).withAlphaComponent(0.85), for: .highlighted)
            $0.contentHorizontalAlignment = .leading
            
            var config = UIButton.Configuration.plain()
            config.imagePadding = ScreenUtils.width / 375 * 86
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)
            $0.configuration = config
        }
        
        privacyPolicyButton.setUnderline()
    }
    
}


// MARK: - Methods

extension LoginView {
    
    func setAddTarget() {
        kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        
        appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        
        privacyPolicyButton.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
    }
    
}


// MARK: - @objc Methods

extension LoginView {
    
    @objc
    func didTapKakaoLoginButton() {
        delegate?.didTapKakaoLoginButton()
    }
    
    @objc
    func didTapAppleLoginButton() {
        delegate?.didTapAppleLoginButton()
    }
    
    @objc
    func didTapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicyButton()
    }
    
}
