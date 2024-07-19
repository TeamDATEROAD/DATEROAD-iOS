//
//  MyPageViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

final class MyPageViewModel {
    
    var userInfoData: ObservablePattern<MyPageUserInfoModel> = ObservablePattern(nil)
   
   var tagData: [String] = []
        
    var onSuccessLogout: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onSuccessWithdrawal: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onSuccessGetUserProfile: ObservablePattern<Bool> = ObservablePattern(nil)
    
    init() {
        self.getUserProfile()
    }
}

extension MyPageViewModel {

    func deleteLogout() {
        NetworkService.shared.authService.deleteLogout() { response in
            switch response {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                self.onSuccessLogout.value = true
            default:
                print("Failed to fetch post logout")
                self.onSuccessLogout.value = false
                return
            }
        }
    }
    
    func deleteWithdrawal() {
        let socialType = UserDefaults.standard.bool(forKey: "SocialType")
        var authCode: String?
        if socialType {
            authCode = nil
        } else {
            authCode = UserDefaults.standard.string(forKey: "authCode")
        }
        NetworkService.shared.authService.deleteWithdrawal(requestBody: DeleteWithdrawalRequest(authCode: authCode)) { response in
            switch response {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                self.onSuccessWithdrawal.value = true
            default:
                print("Failed to fetch delete withdrawal")
                self.onSuccessWithdrawal.value = false
                return
            }
        }
    }
    
    func getUserProfile() {
        NetworkService.shared.userService.getUserProfile( ) { response in
            switch response {
            case .success(let data):
                self.userInfoData.value = MyPageUserInfoModel(nickname: data.name,
                                                              tagList: data.tags,
                                                              point: data.point,
                                                              imageURL: data.imageURL)
               self.tagData = data.tags
               self.onSuccessGetUserProfile.value = true
            default:
                print("Failed to fetch getUserProfile")
                self.onSuccessGetUserProfile.value = false
                return
            }
        }
    }
    
}
