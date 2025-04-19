//
//  SplashViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/9/24.
//

import Foundation

final class SplashViewModel: Serviceable {
    
    var isLoginned: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
}

extension SplashViewModel {
    
    func checkIsLoginned() {
        if UserDefaultsManager.shared.accessToken.isEmpty {
            isLoginned.value = false
            return
        }
        isLoginned.value = !UserDefaultsManager.shared.accessToken.isEmpty
    }
    
}
