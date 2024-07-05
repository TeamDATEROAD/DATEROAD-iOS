//
//  DRButton.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

protocol DRButtonType {

    var bgColor: UIColor { get }
    
    var fontColor: UIColor { get }
        
    var borderWidth: CGFloat { get }
        
    var isEnabled: Bool { get }
    
    var font: UIFont { get }
        
    var cornerRadius: CGFloat { get }
}

extension DRButtonType {
        
    var fontColor: UIColor { return UIColor(resource: .drBlack) }
        
    var borderWidth: CGFloat { return 0 }
        
    var isEnabled: Bool { return true }
    
    var font: UIFont  { return UIFont.suit(.body_bold_15) }
        
    var cornerRadius: CGFloat  { return 14 }
}

struct NextButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .drWhite)
    
    var fontColor: UIColor = UIColor(resource: .deepPurple)
    
    var borderWidth: CGFloat = 1

}

struct EnabledButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var borderWidth: CGFloat = 1
    
}

struct DisabledButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .gray200)
    
    var fontColor: UIColor = UIColor(resource: .gray400)
            
    var isEnabled: Bool = false
        
}

struct KakaoLoginButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .drWhite)
            
}

struct AppleLoginButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .drBlack)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
        
}

struct UnselectedButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .gray100)

    var font: UIFont = UIFont.suit(.body_med_13)
    
    var cornerRadius: CGFloat = 16
        
}

struct SelectedButton : DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .deepPurple)

    var font: UIFont = UIFont.suit(.body_med_13)
    
    var cornerRadius: CGFloat = 16
        
}
