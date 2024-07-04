//
//  PointModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

struct PointModel {
    let pointAmount: Int?
    let pointDescription: String?
    let pointDate: String?
    
    init(pointAmount: Int?, pointDescription: String?, pointDate: String?) {
        self.pointAmount = pointAmount
        self.pointDescription = pointDescription
        self.pointDate = pointDate
    }
}
