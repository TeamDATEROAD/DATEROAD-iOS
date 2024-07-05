//
//  UILabel+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/25/24.
//

import UIKit

extension UILabel {
    //모서리둥글게
    func roundedLabel(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

