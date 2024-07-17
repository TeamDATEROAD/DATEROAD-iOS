//
//  GetPointDetailResponse.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

struct GetPointDetailResponse: Codable {
    let gained: [PointDetail]
    let used: [PointDetail]

}

struct PointDetail: Codable {
    let point: Int
    let description: String
    let createAt: String

}
