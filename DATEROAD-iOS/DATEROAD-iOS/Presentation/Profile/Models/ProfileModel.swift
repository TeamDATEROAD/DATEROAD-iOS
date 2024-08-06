//
//  ProfileModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/15/24.
//

import UIKit

struct ProfileModel {
    let profileImage: String?
    let nickname: String
    let tags: [String]
}

struct ProfileTagModel {
    let tagIcon: UIImage
    let tagTitle: String
    let english: String
}
