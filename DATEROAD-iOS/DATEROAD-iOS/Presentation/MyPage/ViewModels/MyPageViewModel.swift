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
    
    init() {
        fetchData()
    }
    
}

extension MyPageViewModel {
    
    func fetchData() {
        dummyData.value = UserInfoModel.dummyData
        dummyTagData.value = UserInfoModel.dummyData.tagList
    }
    
}
