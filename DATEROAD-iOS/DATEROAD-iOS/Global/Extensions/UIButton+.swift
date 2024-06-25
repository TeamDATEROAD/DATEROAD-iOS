//
//  UIButton+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/25/24.
//

import UIKit

extension UIButton {
    //모서리둥글게
    func roundedButton(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
