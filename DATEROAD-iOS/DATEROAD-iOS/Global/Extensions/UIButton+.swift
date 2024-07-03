//
//  UIButton+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/25/24.
//

import UIKit

extension UIButton {
    
    // 모서리둥글게
    func roundedButton(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    // 버튼에 underline 설정
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    
    // 버튼 타입에 따라 속성 설정해주는 메소드
    func setButtonStatus(buttonType: DRButton) {
        self.backgroundColor = buttonType.bgColor
        self.setTitleColor(buttonType.fontColor, for: .normal)
        self.layer.borderWidth = buttonType.borderWidth
        self.layer.borderColor = UIColor(resource: .deepPurple).cgColor
        self.isEnabled = buttonType.isEnabled
        self.layer.cornerRadius = 14
        self.clipsToBounds = true
    }
    
}
