//
//  DRButton.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

protocol DRButton {

    var bgColor: UIColor { get }
    
    var fontColor: UIColor { get }
        
    var borderWidth: CGFloat { get }
        
    var isEnabled: Bool { get }
        
}

struct NextButton: DRButton {
    
    var bgColor: UIColor =  UIColor(resource: .drWhite)
    
    var fontColor: UIColor = UIColor(resource: .deepPurple)
    
    var borderWidth: CGFloat = 1

    var isEnabled: Bool = true

}

struct EnabledButton: DRButton {
    
    var bgColor: UIColor = UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var borderWidth: CGFloat = 0

    var isEnabled: Bool = true
                    
}

struct DisabledButton: DRButton {
    
    var bgColor: UIColor = UIColor(resource: .gray200)
    
    var fontColor: UIColor = UIColor(resource: .gray400)
    
    var borderWidth: CGFloat = 0
        
    var isEnabled: Bool = false
        
}

struct KakaoLoginButton: DRButton {
    
    var bgColor: UIColor = UIColor(resource: .drWhite)
    
    var fontColor: UIColor = UIColor(resource: .drBlack)
    
    var borderWidth: CGFloat = 0
        
    var isEnabled: Bool = true
        
}

struct AppleLoginButton: DRButton {
    
    var bgColor: UIColor = UIColor(resource: .drBlack)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var borderWidth: CGFloat = 0
        
    var isEnabled: Bool = true
        
}

