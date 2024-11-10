//
//  LoginModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import Foundation

import KakaoSDKUser

struct KakaoUserInfo: Equatable {
    
    let nickname: String?
    
    let email: String?
    
    let gender: String?
    
    let ageRange: String?
    
    init(user: KakaoSDKUser.User?) {
        self.nickname = user?.kakaoAccount?.profile?.nickname
        self.email = user?.kakaoAccount?.email
        self.gender = user?.kakaoAccount?.gender?.rawValue
        self.ageRange = user?.kakaoAccount?.ageRange?.rawValue
    }
    
}

struct AppleUserInfo: Equatable {
    
    let identifier: String?
    
    let nickname: String?
    
    let email: String?
    
    init(identifier: String?, nickname: String?, email: String?) {
        self.identifier = identifier
        self.nickname = nickname
        self.email = email
    }
    
}
