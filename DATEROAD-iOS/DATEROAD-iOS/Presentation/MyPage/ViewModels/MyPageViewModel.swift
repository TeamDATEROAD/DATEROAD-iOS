//
//  MyPageViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

final class MyPageViewModel: Serviceable {
    
    var isAppleLogin: Bool = false
    
    var userInfoData: ObservablePattern<MyPageUserInfoModel> = ObservablePattern(nil)
   
   var tagData: [String] = []
        
    var onSuccessLogout: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onSuccessWithdrawal: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onSuccessGetUserProfile: ObservablePattern<Bool> = ObservablePattern(nil)

    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)

}

extension MyPageViewModel {
    
    func checkSocialLogin() {
        let socialType = UserDefaults.standard.bool(forKey: "SocialType")
        isAppleLogin = socialType ? false : true
    }

    func deleteLogout() {
        NetworkService.shared.authService.deleteLogout() { response in
            switch response {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                self.onSuccessLogout.value = true
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
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
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            default:
                print("Failed to fetch delete withdrawal")
                self.onSuccessWithdrawal.value = false
                return
            }
        }
    }
    
    func getUserProfile() {
        self.onSuccessGetUserProfile.value = false
        self.setLoading()
        
        NetworkService.shared.userService.getUserProfile( ) { response in
            switch response {
            case .success(let data):
                self.userInfoData.value = MyPageUserInfoModel(nickname: data.name,
                                                              tagList: data.tags,
                                                              point: data.point,
                                                              imageURL: data.imageURL)
               self.tagData = data.tags
               self.onSuccessGetUserProfile.value = true
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            default:
                print("Failed to fetch getUserProfile")
                self.onSuccessGetUserProfile.value = false
                return
            }
        }
    }
    
    func setLoading() {
        guard let isSuccessGetUserInfo = self.onSuccessGetUserProfile.value else { return }
        self.onLoading.value = isSuccessGetUserInfo ? false : true
    }
}
