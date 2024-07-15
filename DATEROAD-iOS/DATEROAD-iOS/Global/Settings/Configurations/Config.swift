//
//  Config.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import Foundation

enum Config {

    enum Keys {
        enum Plist {
            static let kakaoNativeAppKey = "KAKAO_NATIVE_APP_KEY"
            static let baseURL = "BASE_URL"
            static let kakaoAppStore = "KAKAO_APPSTORE"
        }
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found !!!")
        }
        return dict
    }()
}


extension Config {
    static let kakaoNativeAppKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoNativeAppKey] as? String else {
            fatalError("KAKAO_NATIVE_APP_KEY is not set in plist for this configuration")
        }
        return key
    }()

    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
    static let kakaoAppStore: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoAppStore] as? String else {
            fatalError("KAKAO_APPSTORE is not set in plist for this configuration")
        }
        return key
    }()
}
