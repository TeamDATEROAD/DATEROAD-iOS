//
//  MyPageModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

struct MyPageUserInfoModel {
    let nickname: String
    let tagList: [String]
    let point: Int
    let imageURL: String?
    
    init(nickname: String, tagList: [String], point: Int, imageURL: String?) {
        self.nickname = nickname
        self.tagList = tagList
        self.point = point
        self.imageURL = imageURL
    }
    
    static var emptyModel: MyPageUserInfoModel {
        return MyPageUserInfoModel(nickname: "", tagList: [], point: 0, imageURL: "")
    }

}
