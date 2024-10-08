//
//  TendencyTag.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

enum TendencyTag: Int, CaseIterable {
    
    case drive
    
    case shopping
    
    case inside
    
    case healing
    
    case alcohol
    
    case epicurism
    
    case atelier
    
    case nature
    
    case activity
    
    case show
    
    case popUp
    
    var tag: ProfileTagModel {
        switch self {
        case .drive:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagCar), tagTitle: "드라이브", english: "DRIVE")
        case .shopping:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagShopping), tagTitle: "쇼핑", english: "SHOPPING")
        case .inside:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagDoor), tagTitle: "실내", english: "INDOORS")
        case .healing:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagTea), tagTitle: "힐링", english: "HEALING")
        case .alcohol:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagAlcohol), tagTitle: "알콜", english: "ALCOHOL")
        case .epicurism:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagRamen), tagTitle: "식도락", english: "FOOD")
        case .atelier:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagRing), tagTitle: "공방", english: "WORKSHOP")
        case .nature:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagMountain), tagTitle: "자연", english: "NATURE")
        case .activity:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagSkate), tagTitle: "액티비티", english: "ACTIVITY")
        case .show:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagMasks), tagTitle: "공연·음악", english: "PERFORMANCE_MUSIC")
        case .popUp:
            return ProfileTagModel(tagIcon: UIImage(resource: .tagPaint), tagTitle: "전시·팝업", english: "EXHIBITION_POPUP")
        }
    }
    
    static func getTag(byEnglish english: String) -> TendencyTag? {
        return TendencyTag.allCases.first { $0.tag.english == english }
    }
    
}
