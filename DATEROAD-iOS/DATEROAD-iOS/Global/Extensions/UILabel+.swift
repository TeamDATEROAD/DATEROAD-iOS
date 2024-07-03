//
//  UILabel+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/25/24.
//

import UIKit

extension UILabel {
    
    // 모서리둥글게
    func roundedLabel(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    // 특정 텍스트의 색상을 변경해주고, 문단 간격 설정해주는 메소드
    func setAttributedText(fullText: String, pointText: String, pointColor: UIColor, lineHeight: CGFloat) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: pointText)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        attributedString.addAttributes([.foregroundColor: pointColor, .paragraphStyle: paragraphStyle], range: range)
        attributedText = attributedString
    }
}

