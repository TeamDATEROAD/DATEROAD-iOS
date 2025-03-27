//
//  DRTextLabel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/18/25.
//

import SwiftUI

final class DRTextLabel: UILabel {
    
    var padding = UIEdgeInsets.zero
    
    init(
        title: String = "",
        textLabelType: TextLabelType,
        alignment: NSTextAlignment = .center,
        numberOfLines: Int = 0,
        hidden: Bool = false
    ) {
        super.init(frame: .zero)
        
        setProperties(
            title,
            textLabelType,
            alignment,
            numberOfLines,
            hidden
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = padding
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
    
}

extension DRTextLabel {
    
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        setNeedsDisplay()
    }
    
    func setProperties(
        _ title: String,
        _ textLabelType: TextLabelType,
        _ alignment: NSTextAlignment,
        _ numberOfLines: Int,
        _ hidden: Bool = false
    ) {
        self.do {
            $0.textAlignment = alignment
            $0.numberOfLines = numberOfLines
            $0.font = textLabelType.textStyle.font
        }
        
        updateTextColor(title, textLabelType.textStyle.textColor)
        updateLabelHidden(hidden)
        
        switch textLabelType {
        case .clear:
            return
            
        case .background(_, let backgroundStyle):
            self.do {
                $0.clipsToBounds = true
                $0.layer.cornerRadius = backgroundStyle.radius
                $0.layer.maskedCorners = backgroundStyle.cornerMask
                $0.backgroundColor = backgroundStyle.bgColor
            }
        }
    }
    
    func updateTextColor(_ title: String, _ color: UIColor) {
        self.text = title
        self.textColor = color
    }
    
    func updateLabelHidden(_ isHidden: Bool) {
        self.isHidden = isHidden
    }
    
}
