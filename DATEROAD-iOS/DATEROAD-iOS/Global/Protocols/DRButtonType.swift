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
    
    var borderColor: CGColor { get }
        
    var borderWidth: CGFloat { get }
        
    var isEnabled: Bool { get }
    
    var font: UIFont { get }
        
    var cornerRadius: CGFloat { get }
}

extension DRButtonType {
        
    var fontColor: UIColor { return UIColor(resource: .drBlack) }
    
    var borderColor: CGColor { return UIColor(resource: .deepPurple).cgColor }
        
    var borderWidth: CGFloat { return 0 }
        
    var isEnabled: Bool { return true }
    
    var font: UIFont  { return UIFont.suit(.body_bold_15) }
        
    var cornerRadius: CGFloat  { return 14 }
}

struct NextButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var cornerRadius: CGFloat = ScreenUtils.height / 812 * 29

}

struct EnabledButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var borderWidth: CGFloat = 1
    
}


struct DisabledButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .gray200)
    
    var borderColor: UIColor = UIColor(resource: .gray200)
    
    var fontColor: UIColor = UIColor(resource: .gray400)
            
    var isEnabled: Bool = false
        
}


struct KakaoLoginButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .kakaoBg)
    
    var fontColor: UIColor = UIColor(resource: .drBlack).withAlphaComponent(0.85)
    
    var font: UIFont = UIFont.systemFont(ofSize: 15, weight: .semibold)

}

struct AppleLoginButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .drBlack)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var font: UIFont = UIFont.suit(.body_bold_15)
        
}

struct UnselectedButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .gray100)

    var font: UIFont = UIFont.suit(.body_med_13)
    
    var fontColor: UIColor = UIColor(resource: .drBlack)
    
    var cornerRadius: CGFloat = 15
    
    var borderWidth: CGFloat = 0
            
}


struct SelectedButton : DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)

    var font: UIFont = UIFont.suit(.body_med_13)
    
    var cornerRadius: CGFloat = 15
        
    var borderWidth: CGFloat = 0

}

struct TendencyTagButton: DRButtonType {
    
    var bgColor: UIColor = UIColor(resource: .drWhite)
    
    var font: UIFont = UIFont.suit(.body_med_13)
    
    var isEnabled: Bool = false
    
    var cornerRadius: CGFloat = 15
        
    var borderWidth: CGFloat = 0
}

struct DateScheduleTagButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .lightPink)
    
    var fontColor: UIColor = UIColor(resource: .drBlack)
    
    var font: UIFont = UIFont.suit(.body_semi_15)
    
    var cornerRadius: CGFloat = 15

}

struct DateDetailTagButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .lightPink)
    
    var fontColor: UIColor = UIColor(resource: .drBlack)
    
    var font: UIFont = UIFont.suit(.body_med_13)
    
    var cornerRadius: CGFloat = 16

}

struct PastDateScheduleTagButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .lightPink)
    
    var fontColor: UIColor = UIColor(resource: .drBlack)
    
    var font: UIFont = UIFont.suit(.body_semi_13)
    
    var cornerRadius: CGFloat = 14
}

struct addCoursePlaceAbledButton: DRButtonType {
    
   var bgColor: UIColor = UIColor(resource: .deepPurple)
   
   var fontColor: UIColor = UIColor(resource: .drWhite)
           
   var isEnabled: Bool = false
   
   var cornerRadius: CGFloat = 14
       
   var borderWidth: CGFloat = 0
}

struct addCoursePlaceDisabledButton: DRButtonType {
    
   var bgColor: UIColor = UIColor(resource: .gray100)
   
   var fontColor: UIColor = UIColor(resource: .gray300)
           
   var isEnabled: Bool = false
   
   var cornerRadius: CGFloat = 14
       
   var borderWidth: CGFloat = 0
}

struct addCourseEditEnableButton: DRButtonType {
   
   var bgColor: UIColor = UIColor(resource: .drWhite)
   
   var fontColor: UIColor = UIColor(resource: .gray400)
       
   var borderWidth: CGFloat = 0
       
   var isEnabled: Bool = true
   
   var font: UIFont = .suit(.body_med_13)
    
}

struct addCourseEditDisableButton: DRButtonType {
   
   var bgColor: UIColor = UIColor(resource: .drWhite)
    
   var fontColor: UIColor = UIColor(resource: .gray400)
       
   var borderWidth: CGFloat = 0
       
   var isEnabled: Bool = false
   
   var font: UIFont = .suit(.body_med_13)
    
}

struct AlertLeftButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .gray100)
    
    var fontColor: UIColor = UIColor(resource: .gray400)
    
    var font: UIFont = UIFont.suit(.body_bold_15)
    
    var cornerRadius: CGFloat = 18

}

struct AlertRightButton: DRButtonType {
    
    var bgColor: UIColor =  UIColor(resource: .deepPurple)
    
    var fontColor: UIColor = UIColor(resource: .drWhite)
    
    var font: UIFont = UIFont.suit(.body_bold_15)
    
    var cornerRadius: CGFloat = 18

}
