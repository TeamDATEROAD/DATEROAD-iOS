//
//  Int+.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/6/24.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func priceRangeTag() -> String {
        switch self {
        case ..<30000:
            return StringLiterals.Course.priceLabelUnder30K
        case 30000..<50000:
            return StringLiterals.Course.priceLabelUnder50K
        case 50000..<100000:
            return StringLiterals.Course.priceLabelUnder100K
        default:
            return StringLiterals.Course.priceLabelOver100K
        }
    }
    
}
