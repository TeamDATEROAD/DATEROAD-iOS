//
//  AppDelegate.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/24/24.
//

import UIKit

import AmplitudeSwift
import KakaoSDKCommon
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 네이티브 앱 키를 사용해 iOS SDK를 초기화하는 과정
        let kakaoNativeAppKey = Config.kakaoNativeAppKey
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
        
        // Amplitude 초기화
        AmplitudeManager.shared.initialize()
        
        // 구글 애즈 초기화
        MobileAds.shared.start(completionHandler: nil)
                
        // 초기화 후 광고 미리 로드
        GoogleAdsManager.shared.loadRewardedAd()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

