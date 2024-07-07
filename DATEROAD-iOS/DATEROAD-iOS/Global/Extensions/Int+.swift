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
}
