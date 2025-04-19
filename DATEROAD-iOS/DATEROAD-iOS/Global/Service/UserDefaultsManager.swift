//
//  UserDefaultsManager.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/16/25.
//

import UIKit

final class UserDefaultsManager: ObservableObject {
    
    static let shared = UserDefaultsManager()
    
    private init() {
        // auth 관련 토큰들
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) ?? ""
        self.accessToken = accessToken
        
        let refreshToken = UserDefaults.standard.string(forKey: UserDefaultKeys.refreshToken.rawValue) ?? ""
        self.refreshToken = refreshToken
        
        let socialToken = UserDefaults.standard.string(forKey: UserDefaultKeys.socialToken.rawValue) ?? ""
        self.socialToken = socialToken
        
        let authCode = UserDefaults.standard.string(forKey: UserDefaultKeys.authCode.rawValue) ?? ""
        self.authCode = authCode
        
        // 유저 정보
        self.userID = UserDefaults.standard.integer(forKey: UserDefaultKeys.userID.rawValue)
        self.platform = UserDefaults.standard.string(forKey: UserDefaultKeys.platform.rawValue) ?? ""
        self.userName = UserDefaults.standard.string(forKey: UserDefaultKeys.userName.rawValue) ?? ""
        self.userPoint = UserDefaults.standard.integer(forKey: UserDefaultKeys.userPoint.rawValue)
    }
    
    var userName: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.userName.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.userName.rawValue) }
    }
    
    var userPoint: Int {
        get { UserDefaults.standard.integer(forKey: UserDefaultKeys.userPoint.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.userPoint.rawValue) }
    }
    
    var accessToken: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.accessToken.rawValue) }
    }
    
    var refreshToken: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.refreshToken.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.refreshToken.rawValue) }
    }
    
    var socialToken: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.socialToken.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.socialToken.rawValue) }
    }
    
    var authCode: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.authCode.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.authCode.rawValue) }
    }
    
    var platform: String {
        get { UserDefaults.standard.string(forKey: UserDefaultKeys.platform.rawValue) ?? "" }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.platform.rawValue) }
    }
    
    var userID: Int {
        get { UserDefaults.standard.integer(forKey: UserDefaultKeys.userID.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.userID.rawValue) }
    }
    
    func updateTokens(
        _ userID: Int,
        _ accessToken: String,
        _ refreshToken: String
    ) {
        UserDefaultsManager.shared.userID = userID
        UserDefaultsManager.shared.accessToken = accessToken
        UserDefaultsManager.shared.refreshToken = refreshToken
    }
    
    func clearAllData() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
}

extension UserDefaultsManager {
    
    enum UserDefaultKeys: String {
        
        case authCode
        
        case socialToken
        
        case accessToken
        
        case refreshToken
        
        case platform
                
        case userPoint
        
        case userName
                
        case userID
        
    }
    
}
