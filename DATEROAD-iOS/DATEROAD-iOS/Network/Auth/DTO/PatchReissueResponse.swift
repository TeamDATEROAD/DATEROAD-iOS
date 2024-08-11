//
//  PatchReissueResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/9/24.
//

import Foundation

struct PatchReissueResponse: Codable {
    let userID: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case accessToken, refreshToken
    }
}
