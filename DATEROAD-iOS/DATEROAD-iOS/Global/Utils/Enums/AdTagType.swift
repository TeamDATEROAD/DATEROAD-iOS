//
//  AdTagType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import Foundation

enum AdTagType: Int, CaseIterable {
    
    case editor
    
    case ad
    
    case about
    
    case hot
    
    var tag: AdModel {
        switch self {
        case .editor:
            return AdModel(title: "에디터 픽", english: "EDITOR")
        case .ad:
            return AdModel(title: "AD", english: "AD")
        case .about:
            return AdModel(title: "ABOUT", english: "ABOUT")
        case .hot:
            return AdModel(title: "이달의 HOT", english: "HOT")
        }
    }
    
    static func getAdTag(byEnglish english: String) -> AdTagType? {
        return AdTagType.allCases.first { $0.tag.english == english }
    }
    
}
