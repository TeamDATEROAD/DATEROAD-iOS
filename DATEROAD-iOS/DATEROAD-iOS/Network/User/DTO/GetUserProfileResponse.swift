//
//  GetUserProfileResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

struct GetUserProfileResponse: Codable {
    let name: String
    let tags: [String]
    let point: Int
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name, tags, point
        case imageURL = "imageUrl"
    }
}
