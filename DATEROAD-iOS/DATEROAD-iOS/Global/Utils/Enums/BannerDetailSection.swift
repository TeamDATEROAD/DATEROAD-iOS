//
//  BannerDetailSection.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import Foundation

enum BannerDetailSection {
    case imageCarousel
    case titleInfo
    case mainContents
    
    static let dataSource: [BannerDetailSection] = [
        BannerDetailSection.imageCarousel,
        BannerDetailSection.titleInfo,
        BannerDetailSection.mainContents
    ]
}

