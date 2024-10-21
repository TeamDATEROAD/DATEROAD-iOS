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
            return StringLiterals.Course.priceLabelUnder30K
        case .under500K:
            return StringLiterals.Course.priceLabelUnder50K
        case .under100K:
            return StringLiterals.Course.priceLabelUnder100K
        case .over100K:
            return StringLiterals.Course.priceLabelOver100K
            
        }
    }
    
}
