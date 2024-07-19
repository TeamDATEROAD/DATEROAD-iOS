//
//  BannerDetailModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import Foundation

struct BannerDetailModel: Codable {
    let images: [Image]
    let title, createAt, description, adTagType: String
}

struct BannerHeaderModel {
    var tag: String
    var createAt: String
}
