//
//  BannerDetailModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import Foundation

struct BannerDetailModel: Equatable {
    
    var images: [ThumbnailModel]
    
    let headerData: BannerHeaderModel
    
    let title: String
    
    let mainContents: MainContentsModel
    
    init(data: GetBannerDetailResponse) {
        self.images = data.images.map { ThumbnailModel(imageUrl: $0.imageURL, sequence: $0.sequence) }
        self.headerData = BannerHeaderModel(tag: AdTagType.getAdTag(byEnglish: data.adTagType)?.tag.title ?? "", createAt: data.createAt)
        self.title = data.title
        self.mainContents = MainContentsModel(description: data.description)
    }
    
    static func == (lhs: BannerDetailModel, rhs: BannerDetailModel) -> Bool {
        return lhs.images == rhs.images &&
               lhs.headerData == rhs.headerData &&
               lhs.title == rhs.title &&
               lhs.mainContents == rhs.mainContents
    }
    
}

struct BannerHeaderModel: Equatable {
    
    var tag: String
    
    var createAt: String
    
}
