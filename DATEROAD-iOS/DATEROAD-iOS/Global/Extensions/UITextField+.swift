//
//  UITextField+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/24/24.
//

import UIKit

extension UITextField {
    
    func setLeftPadding(amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    //TextField placeholder 커스텀
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: fontColor!, .font: font])
    }
}
