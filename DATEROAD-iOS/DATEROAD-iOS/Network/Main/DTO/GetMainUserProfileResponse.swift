//
//  GetUserProfileResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

struct GetMainUserProfileResponse: Codable {
    let name: String
    let point: Int
    let image: String?
}
