//
//  MyPageModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

struct UserInfoModel {
    let nickname: String
    let tagList: [String]
    let point: Int
    
    init(nickname: String, tagList: [String], point: Int) {
        self.nickname = nickname
        self.tagList = tagList
        self.point = point
    }
}

extension UserInfoModel {
    static var dummyData: UserInfoModel {
        return UserInfoModel(nickname: "희슬", tagList: ["🚙 드라이브", "🛍️ 쇼핑", "🚪 실내"], point: 200)
    }
}
