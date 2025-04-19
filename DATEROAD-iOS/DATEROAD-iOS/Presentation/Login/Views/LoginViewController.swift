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
        setDelegate()
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
        self.view.backgroundColor = UIColor(resource: .purple600)
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
    
    func setDelegate() {
        loginView.delegate = self
    }
    
    func pushToNextVC(isSignIn: Bool) {
        if isSignIn {
            AmplitudeManager.shared.setUserId(String(UserDefaultsManager.shared.userID))
            let mainVC = TabBarController()
            self.navigationController?.pushViewController(mainVC, animated: false)
        } else {
            let pointSystemManualVC = OnboardingViewController(onboardingViewModel: OnboardingViewModel())
            self.navigationController?.pushViewController(pointSystemManualVC, animated: false)
        }
    }
    
    func checkKakaoLogin() {
        loginViewModel.checkKakaoInstallation { [weak self] isInstalled in
            if isInstalled {
                self?.loginViewModel.loginWithKakaoApp()
            } else {
                self?.loginViewModel.loginWithKakaoWeb()
            }
            self?.showLoadingView(type: StringLiterals.Login.splash)
        }
    }
    
    func checkAppleLogin() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    func goToPrivacyPolicy() {
        let privacyPolicyVC = DRWebViewController(urlString: StringLiterals.WebView.privacyPolicyLink)
        self.present(privacyPolicyVC, animated: true)
    }
    
}


// MARK: - Apple Authorization Delegate

extension LoginViewController: LoginDelegate {
    
    func didTapKakaoLoginButton() {
        checkKakaoLogin()
    }
    
    func didTapAppleLoginButton() {
        checkAppleLogin()
    }
    
    func didTapPrivacyPolicyButton() {
        goToPrivacyPolicy()
    }
    
}


// MARK: - Apple Authorization Delegate

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
