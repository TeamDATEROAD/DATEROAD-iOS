//
//  PostSignUpRequest.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/17/24.
//

import UIKit

struct PostSignUpRequest {
    let userSignUpReq: UserSignUpReq
    let image: UIImage?
    let tag: [String]
}

struct UserSignUpReq: Codable {
    let name, platform: String
}
