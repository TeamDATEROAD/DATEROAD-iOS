//
//  UIFont+.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/1/24.
//

import UIKit

extension UIFont {
    static func suit(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SUIT"

        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bold"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .heavy:
            weightString = "ExtraBold"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)-\(fontSize)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
