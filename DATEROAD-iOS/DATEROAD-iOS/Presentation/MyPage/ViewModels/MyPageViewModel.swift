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
    
    init() {
        fetchData()
    }
    
}

extension MyPageViewModel {
    
    func fetchData() {
        dummyData.value = UserInfoModel.dummyData
        dummyTagData.value = UserInfoModel.dummyData.tagList
    }

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
}
