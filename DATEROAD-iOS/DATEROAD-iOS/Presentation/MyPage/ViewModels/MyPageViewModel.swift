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
    
    var onSuccessGetUserProfile: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
        
    var onAuthLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var updateData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var currentTags: [String] = []
    
}

extension MyPageViewModel {
    
    func checkSocialLogin() {
        let socialType = UserDefaults.standard.bool(forKey: StringLiterals.Network.socialType)
        isAppleLogin = !socialType
    }
    
    func deleteLogout() {
        self.onAuthLoading.value = true
        self.onFailNetwork.value = false
        NetworkService.shared.authService.deleteLogout() { response in
            switch response {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                self.onSuccessLogout.value = true
                self.onAuthLoading.value = false
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch post logout")
                self.onFailNetwork.value = true
                self.onSuccessLogout.value = false
                return
            }
        }
    }
    
    func deleteWithdrawal() {
        self.onAuthLoading.value = true
        self.onFailNetwork.value = false
        let socialType = UserDefaults.standard.bool(forKey: StringLiterals.Network.socialType)
        var authCode: String?
        if socialType {
            authCode = nil
        } else {
            authCode = UserDefaults.standard.string(forKey: StringLiterals.Network.authCode)
        }
        NetworkService.shared.authService.deleteWithdrawal(requestBody: DeleteWithdrawalRequest(authCode: authCode)) { response in
            switch response {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                self.onSuccessWithdrawal.value = true
                self.onAuthLoading.value = false
            case .reIssueJWT:
                // 토큰 재발급 서버 통신 후 값을 설정
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch delete withdrawal")
                self.onSuccessWithdrawal.value = false
                self.onFailNetwork.value = true
                return
            }
        }
    }
    
    func getUserProfile() {
        self.onSuccessGetUserProfile.value = false
        self.onFailNetwork.value = false
        
        NetworkService.shared.userService.getUserProfile( ) { response in
            switch response {
            case .success(let data):
                if self.userInfoData.value != MyPageUserInfoModel(
                    nickname: data.name,
                    tagList: data.tags,
                    point: data.point,
                    imageURL: data.imageURL
                ) {
                    self.currentTags = self.userInfoData.value?.tagList ?? []
                    self.userInfoData.value = MyPageUserInfoModel(
                        nickname: data.name,
                        tagList: data.tags,
                        point: data.point,
                        imageURL: data.imageURL
                    )
                    self.tagData = data.tags
                    self.updateData.value = true
                }
                self.onSuccessGetUserProfile.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = true
            default:
                print("Failed to fetch getUserProfile")
                self.onSuccessGetUserProfile.value = false
                return
            }
        }
    }
    
}
