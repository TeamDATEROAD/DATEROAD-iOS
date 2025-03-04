//
//  ButtonName.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/2/25.
//

import UIKit

enum ButtonName {
    
    case bold_purple_25, bold_purple_14, bold_gray200_14, bold_gray100_14, bold_purple_29, bold_purple_10, bold_gray100_10, bold_white_0, bold_black_14
    
    case semi_white_0, semi_purple_10, semi_gray100_14, semi_gray100_14_black, semi_gray100_10
    
    case med_purple_15, med_gray100_15, med_purple_10, med_gray100_10, med_gray200_10, med_white_0, med_purple_0, med_white_0_purple
    
    
    var bgColor: UIColor {
        switch self {
        case .bold_purple_25, .bold_purple_14, .bold_purple_29, .bold_purple_10, .med_purple_15, .med_purple_10, .semi_purple_10, .med_purple_0:
            return UIColor(resource: .deepPurple)
            
        case .bold_gray200_14, .med_gray200_10:
            return UIColor(resource: .gray200)
            
        case .bold_gray100_10, .med_gray100_15, .med_gray100_10, .semi_gray100_10, .bold_gray100_14, .semi_gray100_14, .semi_gray100_14_black:
            return UIColor(resource: .gray100)
            
        case .semi_white_0, .bold_white_0, .med_white_0, .med_white_0_purple:
            return UIColor(resource: .drWhite)
            
        case .bold_black_14:
            return UIColor(resource: .drBlack)
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .bold_gray100_14, .semi_gray100_14_black:
            return UIColor(resource: .drBlack)
            
        case .bold_purple_25, .bold_purple_14, .bold_purple_29, .bold_purple_10, .med_purple_15, .med_purple_10, .semi_purple_10, .bold_black_14:
            return UIColor(resource: .drWhite)
            
        case .bold_gray100_10, .bold_gray200_14, .med_gray100_15, .med_gray100_10, .semi_gray100_10, .med_gray200_10, .med_white_0:
            return UIColor(resource: .gray400)
            
        case .semi_gray100_14:
            return UIColor(resource: .gray300)
            
        case .med_purple_0:
            return UIColor(resource: .gray200)
            
        case .semi_white_0, .med_white_0_purple:
            return UIColor(resource: .deepPurple)
            
        case .bold_white_0:
            return UIColor(resource: .mediumPurple)
            
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .bold_purple_29:
            return ScreenUtils.height / 812 * 29
            
        case .bold_purple_25:
            return 25
            
        case .med_purple_15, .med_gray100_15:
            return 15
            
        case .semi_white_0, .bold_purple_14, .bold_gray200_14, .bold_gray100_14, .semi_gray100_14, .bold_black_14, .semi_gray100_14_black:
            return 14

        case .bold_purple_10, .bold_gray100_10, .med_gray200_10, .med_purple_10, .med_gray100_10, .semi_purple_10, .semi_gray100_10:
            return 10
         
        case .bold_white_0, .med_white_0, .med_purple_0, .med_white_0_purple:
            return 0
            
        }
    }
    
    
    var borderWidth: CGFloat {
        return 0
    }
        
    var font: UIFont {
        switch self {
        case .bold_purple_25, .bold_purple_29, .bold_purple_14, .bold_gray200_14, .bold_purple_10, .bold_gray100_10, .bold_gray100_14, .bold_black_14:
            return UIFont.suit(.body_bold_15)

        case .bold_white_0:
            return UIFont.suit(.body_bold_13)
            
        case .semi_white_0, .semi_purple_10, .semi_gray100_10:
            return UIFont.suit(.body_semi_15)
            
        case .semi_gray100_14, .semi_gray100_14_black:
            return UIFont.suit(.body_semi_13)
            
        case .med_purple_0:
            return UIFont.suit(.body_med_15)
            
        case .med_gray200_10, .med_purple_15, .med_gray100_15, .med_purple_10, .med_gray100_10, .med_white_0, .med_white_0_purple:
            return UIFont.suit(.body_med_13)
        }
        
    }
        
}
