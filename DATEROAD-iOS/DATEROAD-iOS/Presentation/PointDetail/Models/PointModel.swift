//
//  PointModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

struct PointUserModel {
    let userName: String?
    let totalPoint: Int?
    
    init(userName: String?, totalPoint: Int?) {
        self.userName = userName
        self.totalPoint = totalPoint
    }
} // 메인페이지 & 마이페이지에서 넘겨줘야 함

struct PointModel {
    let gained: [PointDetailModel]
    let used: [PointDetailModel]
    
    init(gained: [PointDetailModel], used: [PointDetailModel]) {
        self.gained = gained
        self.used = used
    }
}

struct PointDetailModel {
    let sign: String
    let point: Int
    let description: String
    let createdAt: String
    
    init(sign: String, point: Int, description: String, createdAt: String) {
        self.sign = sign
        self.point = point
        self.description = description
        self.createdAt = createdAt
    }
}
