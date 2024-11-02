//
//  UIView+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/24/24.
//

import UIKit

extension UIView {
    
    // UIView 여러 개 인자로 받아서 한 번에 addSubview
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    //모서리둥글게
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func setFontAndLineLetterSpacing(_ text: String, font: UIFont) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = font.pointSize * 0.5
        
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: [
                .kern: CGFloat(0),  // 자간
                .paragraphStyle: style,  // 행간
                .font: font  // 폰트
            ]
        )
        
        // UIView가 아래 UILabel, UITextField, UITextView 들의 SuperView라 생각하여 UIView의 extension에 추가함
        if let label = self as? UILabel {
            label.attributedText = attributedString
        } else if let textField = self as? UITextField {
            textField.attributedText = attributedString
        } else if let textView = self as? UITextView {
            textView.attributedText = attributedString
        }
    }
    
    func setSkeletonLabel(bgColor: UIColor = UIColor(resource: .gray100), radius: CGFloat = 8,  corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]) {
        self.do {
            $0.backgroundColor = bgColor
            $0.roundCorners(cornerRadius: radius, maskedCorners: corners)
        }
    }
    
    func setSkeletonImage(bgColor: UIColor = UIColor(resource: .gray100), radius: CGFloat = 14, corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]) {
        self.do {
            $0.backgroundColor = bgColor
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.roundCorners(cornerRadius: radius, maskedCorners: corners)
        }
    }
}
