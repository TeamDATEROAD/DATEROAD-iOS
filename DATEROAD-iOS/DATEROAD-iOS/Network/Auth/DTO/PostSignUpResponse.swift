//
//  PostSignUpResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/17/24.
//

import Foundation

struct PostSignUpResponse: Codable {
    let userID: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case accessToken, refreshToken
    }
}
