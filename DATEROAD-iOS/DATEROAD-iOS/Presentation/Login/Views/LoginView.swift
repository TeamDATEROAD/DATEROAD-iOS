//
//  LoginView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

final class LoginView: BaseView {
    
    // MARK: - UI Properties
    
    private let logoContainer: UIView = UIView()
    
    private let logoLabel: UILabel = UILabel()
    
    private let buttonStackView: UIStackView = UIStackView()
    
    let kakaoLoginButton: UIButton = UIButton()
    
    let appleLoginButton: UIButton = UIButton()
    
    let privacyPolicyButton: UIButton = UIButton()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(logoContainer, buttonStackView)
        logoContainer.addSubview(logoLabel)
        buttonStackView.addArrangedSubviews(kakaoLoginButton, appleLoginButton, privacyPolicyButton)
    }
    
    override func setLayout() {
        logoContainer.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height / 4 * 3)
        }
        
        logoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.bottom)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }

        kakaoLoginButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    override func setStyle() {
        logoLabel.do {
            $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            $0.textColor = .black
            $0.text = StringLiterals.Login.splash
        }
        
        buttonStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }
        
        kakaoLoginButton.do {
            $0.backgroundColor = .yellow
            $0.setTitle(StringLiterals.Login.kakaoLoginLabel, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            $0.setTitleColor(.black, for: .normal)
        }
        
        appleLoginButton.do {
            $0.backgroundColor = .lightGray
            $0.setTitle(StringLiterals.Login.appleLoginLabel, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            $0.setTitleColor(.black, for: .normal)
        }
        
        privacyPolicyButton.do {
            $0.setTitle(StringLiterals.Login.privacyPolicyLabel, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            $0.setUnderline()
        }
    }

}
