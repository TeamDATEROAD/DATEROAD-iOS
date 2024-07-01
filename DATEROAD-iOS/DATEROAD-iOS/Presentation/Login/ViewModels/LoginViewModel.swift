//
//  LoginViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import Foundation

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class LoginViewModel {
    
    var isKaKaoLogin: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var socialType: ObservablePattern<SocialType> = ObservablePattern(nil)
    
    var socialToken: ObservablePattern<String> = ObservablePattern(nil)
    
    var onLoginSuccess: (() -> Void)?
    
    var onLoginFailure: ((Error) -> Void)?
}

extension LoginViewModel {
    
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
    
    func setToken(token: String) {
        guard let key = self.socialType.value?.rawValue else { return }
        guard let value = self.isKaKaoLogin.value else { return }
        UserDefaults.standard.setValue(value, forKey: key)
        self.socialToken.value = token
        self.onLoginSuccess?()
    }
    
    func handleKakaoLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error {
            print("로그인 실패: \(error.localizedDescription)")
            self.onLoginFailure?(error)
        } else {
            print("로그인 성공: \(String(describing: oauthToken))")
            guard let oauthToken = oauthToken else { return }
            UserApi.shared.me { (user, error) in
                print("user identifier : \(String(describing: user?.kakaoAccount?.profile?.nickname))")
            }
            setToken(token: oauthToken.accessToken)
        }
    }
    
}
