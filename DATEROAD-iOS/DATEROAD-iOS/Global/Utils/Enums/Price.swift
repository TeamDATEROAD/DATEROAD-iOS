//
//  Price.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import Foundation

enum Price: Int, CaseIterable {
    case under300K
    case under500K
    case under100K
    case over100K
    
    var priceTitle: String {
        switch self {
        case .under300K:
            return "3만원 이하"
        case .under500K:
            return "5만원 이하"
        case .under100K:
            return "10만원 이하"
        case .over100K:
            return "10만원 초과"
            
        }
    }
}
