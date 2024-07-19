//
//  LoginViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

import AuthenticationServices

final class LoginViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let loginView = LoginView()

    
    // MARK: - Properties
    
    private let loginViewModel = LoginViewModel()
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setAddTarget()
    }
    
    override func setHierarchy() {
        self.view.addSubview(loginView)
    }
    
    override func setLayout() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = UIColor(resource: .deepPurple)
    }

}

extension LoginViewController {
    
    func bindViewModel() {
        self.loginViewModel.isSignIn.bind { [weak self] isSignIn in
            guard let isSignIn else { return }
            self?.pushToNextVC(isSignIn: isSignIn)
        }
    }
    
    func setAddTarget() {
        self.loginView.kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        self.loginView.appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        self.loginView.privacyPolicyButton.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
    }
        
    func pushToNextVC(isSignIn: Bool) {
        if isSignIn {
            let mainVC = TabBarController()
            self.navigationController?.pushViewController(mainVC, animated: true)
        } else {
            let pointSystemManualVC = OnboardingViewController()
            self.navigationController?.pushViewController(pointSystemManualVC, animated: true)
        }
    }
    
}

extension LoginViewController {
    
    @objc
    func didTapKakaoLoginButton() {
        loginViewModel.checkKakaoInstallation { [weak self] isInstalled in
            if isInstalled {
                self?.loginViewModel.loginWithKakaoApp()
            } else {
                self?.loginViewModel.loginWithKakaoWeb()
            }
        }
    }
    
    @objc
    func didTapAppleLoginButton() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    @objc
    func didTapPrivacyPolicyButton() {
        let privacyPolicyVC = DRWebViewController(urlString: "https://dateroad.notion.site/04da4aa279ca4b599193784091a52859?pvs=4")
        self.present(privacyPolicyVC, animated: true)
    }
   
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return }
        
        self.loginViewModel.loginWithApple(userInfo: credential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        let alert = UIAlertController(title: "로그인 실패", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
    
}
