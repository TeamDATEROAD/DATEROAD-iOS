//
//  ProfileModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/15/24.
//

import UIKit

struct ProfileModel: Equatable {
    
    let profileImage: UIImage?
    
    let nickname: String
    
    let tags: [String]
    
}

struct ProfileTagModel: Equatable {
    
    let tagIcon: UIImage
    
    let tagTitle: String
    
    let english: String
    
}
