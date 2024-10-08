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

final class LoginViewModel: Serviceable {
    
    var isKaKaoLogin: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var socialType: ObservablePattern<SocialType> = ObservablePattern(nil)
    
    var socialToken: ObservablePattern<String> = ObservablePattern(nil)
    
    var kakaoUserInfo: ObservablePattern<KakaoUserInfo> = ObservablePattern(nil)
    
    var appleUserInfo: ObservablePattern<AppleUserInfo> = ObservablePattern(nil)
    
    var isSignIn: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoginSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onAuthLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
}

extension LoginViewModel {
    
    // Kakao 로그인
    
    func checkKakaoInstallation(completion: @escaping (Bool) -> Void) {
        self.socialType.value = .KAKAO
        self.isKaKaoLogin.value = true
        if UserApi.isKakaoTalkLoginAvailable() {
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
            self.onLoginSuccess.value = false
        } else {
            guard let oauthToken = oauthToken else { return }
            UserApi.shared.me { (user, error) in
                let userInfo = KakaoUserInfo(user: user)
                self.kakaoUserInfo.value = userInfo
            }
            setToken(token: oauthToken.accessToken)
        }
    }
    
    func loginWithApple(userInfo: ASAuthorizationAppleIDCredential) {
        guard let userIdentifier = userInfo.identityToken,
              let code = userInfo.authorizationCode,
              let token = String(data: userIdentifier, encoding: .utf8),
              let authCode = String(data: code, encoding: .utf8)
        else { return }
        
        UserDefaults.standard.setValue(authCode, forKey: StringLiterals.Network.authCode)
        self.isKaKaoLogin.value = false
        self.socialType.value = .APPLE
        self.setToken(token: token)
        self.setUserInfo(userInfo: userInfo)
    }
    
    func setToken(token: String) {
        guard let value = self.isKaKaoLogin.value else { return }
        UserDefaults.standard.setValue(value, forKey: StringLiterals.Network.socialType)
        self.socialToken.value = token
        UserDefaults.standard.setValue(token, forKey: StringLiterals.Network.token)
        postSignIn()
    }
    
    func setUserInfo(userInfo: ASAuthorizationAppleIDCredential) {
        let nickname = String(describing: userInfo.fullName?.givenName) + String(describing: userInfo.fullName?.familyName)
        let email = userInfo.email
        self.appleUserInfo.value = AppleUserInfo(identifier: userInfo.user, nickname: nickname, email: email)
    }
    
    func postSignIn() {
        self.onAuthLoading.value = true
        let socialType = UserDefaults.standard.bool(forKey: StringLiterals.Network.socialType)
        let requestBody = PostSignInRequest(platform: socialType ? SocialType.KAKAO.rawValue : SocialType.APPLE.rawValue)
        
        NetworkService.shared.authService.postSignIn(requestBody: requestBody) { response in
            switch response {
            case .success(let data):
                UserDefaults.standard.setValue(data.userID, forKey: StringLiterals.Network.userID)
                UserDefaults.standard.setValue(data.accessToken, forKey: StringLiterals.Network.accessToken)
                UserDefaults.standard.setValue(data.refreshToken, forKey: StringLiterals.Network.refreshToken)
                self.onLoginSuccess.value = true
                self.onAuthLoading.value = false
                self.isSignIn.value = true
            case .requestErr:
                self.onAuthLoading.value = false
                self.isSignIn.value = false
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch post signin")
                self.onAuthLoading.value = false
                self.onLoginSuccess.value = false
                return
            }
        }
    }
    
}
