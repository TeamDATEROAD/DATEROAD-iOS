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
    
    override func viewDidDisappear(_ animated: Bool) {
        hideLoadingView()
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
        self.loginViewModel.onAuthLoading.bind { [weak self] onAuthLoading in
            guard let onAuthLoading else { return }
            onAuthLoading ? self?.showLoadingView(type: StringLiterals.Login.splash) : self?.hideLoadingView()
        }
        
        self.loginViewModel.onLoginSuccess.bind { [weak self] onLoginSuccess in
            guard let onLoginSuccess else { return }
            if !onLoginSuccess {
                self?.presentAlertVC(title: StringLiterals.Alert.failToLogin)
            }
        }
        
        self.loginViewModel.isSignIn.bind { [weak self] isSignIn in
            guard let isSignIn else { return }
            self?.pushToNextVC(isSignIn: isSignIn)
        }
        
        self.loginViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.loginViewModel.postSignIn()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
    }
    
    func setAddTarget() {
        self.loginView.kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        self.loginView.appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        self.loginView.privacyPolicyButton.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
    }
    
    func pushToNextVC(isSignIn: Bool) {
        if isSignIn {
            guard let userId = UserDefaults.standard.string(forKey: StringLiterals.Network.userID) else { return }
            AmplitudeManager.shared.setUserId(userId)
            let mainVC = TabBarController()
            self.navigationController?.pushViewController(mainVC, animated: false)
        } else {
            let pointSystemManualVC = OnboardingViewController(onboardingViewModel: OnboardingViewModel())
            self.navigationController?.pushViewController(pointSystemManualVC, animated: false)
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
            self?.showLoadingView(type: StringLiterals.Login.splash)
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
        let privacyPolicyVC = DRWebViewController(urlString: StringLiterals.WebView.privacyPolicyLink)
        self.present(privacyPolicyVC, animated: true)
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return }
        
        self.showLoadingView(type: StringLiterals.Login.splash)
        self.loginViewModel.loginWithApple(userInfo: credential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        self.presentAlertVC(title: StringLiterals.Alert.failToLogin)
    }
    
}
