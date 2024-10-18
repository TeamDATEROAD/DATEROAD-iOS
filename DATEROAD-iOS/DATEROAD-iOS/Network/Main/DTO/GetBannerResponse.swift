//
//  GetBannerResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

struct GetBannerResponse: Codable {
    
    let advertisementDtoResList: [AdvertisementDtoResList]
    
}

struct AdvertisementDtoResList: Codable {
    
    let advertisementID: Int
    
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        
        case advertisementID = "advertisementId"
        
        case thumbnail
        
    }
    
}
