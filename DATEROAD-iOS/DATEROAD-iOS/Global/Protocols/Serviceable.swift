//
//  Serviceable.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/9/24.
//

import Foundation

protocol Serviceable: AnyObject {
    func patchReissue() -> Bool
}

extension Serviceable {
    func patchReissue() -> Bool {
        var isSuccess: Bool = false
        let access = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let token = UserDefaults.standard.string(forKey: "refreshToken") ?? ""

        NetworkService.shared.authService.patchReissue() { response in
            switch response {
            case .success(let data):
                UserDefaults.standard.setValue(data.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(data.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.setValue(data.userID, forKey: "userID")
                isSuccess = true

            default:
                print("Failed to fetch patch reissue")
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                isSuccess = false
            }
        }
        return isSuccess
    }
}
