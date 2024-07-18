//
//  MyPageViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

final class MyPageViewModel {
    
    var dummyData: ObservablePattern<UserInfoModel> = ObservablePattern(nil)
    
    var dummyTagData: ObservablePattern<[String]> = ObservablePattern(nil)
    
    var onSuccessLogout: ObservablePattern<Bool> = ObservablePattern(nil)
    var onSuccessGetUserProfile: ObservablePattern<Bool> = ObservablePattern(nil)
    
//    init() {
//        getUserProfile()
//    }
    
}

extension MyPageViewModel {

    func deleteLogout() {
        NetworkService.shared.authService.deleteLogout() { response in
            switch response {
            case .success(_):
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                UserDefaults.standard.synchronize()
                self.onSuccessLogout.value = true
            default:
                print("Failed to fetch post logout")
                self.onSuccessLogout.value = false
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
                self.onSuccessGetUserProfile.value = true
            default:
                print("Failed to fetch getUserProfile")
                self.onSuccessGetUserProfile.value = false
                return
            }
        }
    }
    
}
