//
//  LoginView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

final class LoginView: BaseView {
    
    // MARK: - UI Properties
        
    private let logoImageView: UIImageView = UIImageView()
        
    let kakaoLoginButton: UIButton = UIButton()
    
    let appleLoginButton: UIButton = UIButton()
    
    let privacyPolicyButton: UIButton = UIButton()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(logoImageView, 
                         kakaoLoginButton,
                         appleLoginButton,
                         privacyPolicyButton)
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
        self.backgroundColor = UIColor(resource: .deepPurple)
        
        logoImageView.do {
            $0.image = UIImage(resource: .logo)
            $0.contentMode = .scaleAspectFit
        }
        
        kakaoLoginButton.do {
            $0.setButtonStatus(buttonType: KakaoLoginButton())
            $0.setImage(UIImage(resource: .kakaoLogo), for: .normal)
            $0.setTitle(StringLiterals.Login.kakaoLoginLabel, for: .normal)
            $0.contentHorizontalAlignment = .leading

            var config = UIButton.Configuration.plain()
            config.imagePadding = ScreenUtils.width / 375 * 86
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)
            $0.configuration = config
        }
        
        appleLoginButton.do {
            $0.setButtonStatus(buttonType: AppleLoginButton())
            $0.setTitle(StringLiterals.Login.appleLoginLabel, for: .normal)
        }
        
        privacyPolicyButton.do {
            $0.setTitle(StringLiterals.Login.privacyPolicyLabel, for: .normal)
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_15)
            $0.setUnderline()
        }
    }

}
