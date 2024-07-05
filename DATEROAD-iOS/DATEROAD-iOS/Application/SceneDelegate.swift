//
//  SceneDelegate.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/24/24.
//

import UIKit

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 2.
        self.window = UIWindow(windowScene: windowScene)
        // 3.
        let navigationController = UINavigationController(rootViewController: ViewedCourseViewController())
        self.window?.rootViewController = navigationController
        // 4.
        self.window?.makeKeyAndVisible()
    }

    // 카카오톡으로 로그인 기능을 구현하기 위한 필수 설정
    // 서비스 앱에서 카카오톡으로 이동한 후, 사용자가 [동의하고 계속하기] 버튼 또는 로그인 취소 버튼을 누르면 다시 카카오톡에서 서비스 앱으로 이동하는 과정을 거침
    // 카카오톡에서 서비스 앱으로 돌아왔을 때 카카오 로그인 처리를 정상적으로 완료하기 위해 handleOpenUrl()을 추가
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }


}

