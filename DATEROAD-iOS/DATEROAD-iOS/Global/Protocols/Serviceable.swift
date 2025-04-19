//
//  Serviceable.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/9/24.
//

import Foundation

protocol Serviceable: AnyObject {
    
    func patchReissue(completion: @escaping (Bool) -> Void)
    
}

extension Serviceable {
    
    func patchReissue(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.authService.patchReissue() { response in
            switch response {
            case .success(let data):
                UserDefaultsManager.shared.updateTokens(
                    data.userID,
                    data.accessToken,
                    data.refreshToken
                )
                completion(true)
                
            default:
                print("Failed to fetch patch reissue")
                UserDefaultsManager.shared.clearAllData()
                completion(false)
            }
        }
    }
    
}
