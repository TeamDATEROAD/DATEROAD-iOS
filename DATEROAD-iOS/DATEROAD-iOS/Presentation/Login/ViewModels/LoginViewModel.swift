//
//  LoginViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import Foundation

import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class LoginViewModel {
    
    var isKaKaoLogin: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var socialType: ObservablePattern<SocialType> = ObservablePattern(nil)
        
    var socialToken: ObservablePattern<String> = ObservablePattern(nil)
    
    var kakaoUserInfo: ObservablePattern<KakaoUserInfo> = ObservablePattern(nil)
    
    var appleUserInfo: ObservablePattern<AppleUserInfo> = ObservablePattern(nil)
    
    var onLoginSuccess: (() -> Void)?
    
    var onLoginFailure: ((Error) -> Void)?
}

extension LoginViewModel {
    
    // Kakao 로그인
    
    func checkKakaoInstallation(completion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            self.socialType.value = .kakao
            self.isKaKaoLogin.value = true
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func loginWithKakaoApp() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
            self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
        }
    }
    
    func loginWithKakaoWeb() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
        }
    }
    
    func handleKakaoLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error {
            print("로그인 실패: \(error.localizedDescription)")
            self.onLoginFailure?(error)
        } else {
            guard let oauthToken = oauthToken else { return }
            UserApi.shared.me { (user, error) in
                print("로그인 성공 : \(String(describing: user?.kakaoAccount?.profile?.nickname))")
                let userInfo = KakaoUserInfo(user: user)
                self.kakaoUserInfo.value = userInfo
            }
            setToken(token: oauthToken.accessToken)
        }
    }
    
    // Apple 로그인
    
    func loginWithApple(userInfo: ASAuthorizationAppleIDCredential) {
        guard let userIdentifier = userInfo.identityToken,
                   let token = String(data: userIdentifier, encoding: .utf8)
        else { return }
        
        self.isKaKaoLogin.value = false
        self.socialType.value = .apple
        self.setToken(token: token)
        self.setUserInfo(userInfo: userInfo)
    }
    
    // 유저 정보 세팅
    
    func setToken(token: String) {
        guard let key = self.socialType.value?.rawValue else { return }
        guard let value = self.isKaKaoLogin.value else { return }
        UserDefaults.standard.setValue(value, forKey: key)
        self.socialToken.value = token
        self.onLoginSuccess?()
    }
    
    func setUserInfo(userInfo: ASAuthorizationAppleIDCredential) {
        print("user identifier : \(String(describing: userInfo.fullName)), \(String(describing: userInfo.email))")
        
        let nickname = String(describing: userInfo.fullName?.givenName) + String(describing: userInfo.fullName?.familyName)
        let email = userInfo.email
        
        self.appleUserInfo.value = AppleUserInfo(identifier: userInfo.user, nickname: nickname, email: email)
    }
    
}
