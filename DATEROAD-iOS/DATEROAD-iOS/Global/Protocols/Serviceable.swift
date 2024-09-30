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
                UserDefaults.standard.setValue(data.accessToken, forKey: StringLiterals.Network.accessToken)
                UserDefaults.standard.setValue(data.refreshToken, forKey: StringLiterals.Network.refreshToken)
                UserDefaults.standard.setValue(data.userID, forKey: StringLiterals.Network.userID)
                completion(true)
                
            default:
                print("Failed to fetch patch reissue")
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                completion(false)
            }
        }
    }
    
}
