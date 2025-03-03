//
//  ButtonName.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/2/25.
//

import UIKit

enum ButtonName {
    
    case bold_purple_14, bold_gray200_14, bold_purple_29, semi_white_0, bold_purple_10, bold_gray100_10
    
    case med_purple_15, med_gray100_15, med_purple_10, med_gray100_10, semi_purple_10, semi_gray100_10, med_gray200_10, bold_white_0
    
    
    var bgColor: UIColor {
        switch self {
        case .bold_purple_14, .bold_purple_29, .bold_purple_10, .med_purple_15, .med_purple_10, .semi_purple_10:
            return UIColor(resource: .deepPurple)
            
        case .bold_gray200_14, .med_gray200_10:
            return UIColor(resource: .gray200)
            
        case .bold_gray100_10, .med_gray100_15, .med_gray100_10, .semi_gray100_10:
            return UIColor(resource: .gray100)
            
        case .semi_white_0, .bold_white_0:
            return UIColor(resource: .drWhite)
            
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .bold_purple_14, .bold_purple_29, .bold_purple_10, .med_purple_15, .med_purple_10, .semi_purple_10:
            return UIColor(resource: .drWhite)
            
        case .bold_gray100_10, .semi_white_0, .bold_gray200_14, .med_gray100_15, .med_gray100_10, .semi_gray100_10, .med_gray200_10:
            return UIColor(resource: .gray400)
            
        case .bold_white_0:
            return UIColor(resource: .mediumPurple)
            
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .bold_purple_14, .bold_purple_29, .bold_purple_10, .med_purple_15, .med_purple_10, .semi_purple_10:
            return UIColor(resource: .deepPurple).cgColor
            
        case .bold_gray200_14, .med_gray200_10:
            return UIColor(resource: .gray200).cgColor
         
        case .bold_gray100_10, .med_gray100_15, .med_gray100_10, .semi_gray100_10:
            return UIColor(resource: .gray100).cgColor
            
        case .semi_white_0, .bold_white_0:
            return UIColor(resource: .drWhite).cgColor
            
        }
    }

    
    var cornerRadius: CGFloat {
        switch self {
        case .bold_purple_29:
            return ScreenUtils.height / 812 * 29
            
        case .med_purple_15, .med_gray100_15:
            return 15
            
        case .semi_white_0, .bold_purple_14, .bold_gray200_14:
            return 14

        case .bold_purple_10, .bold_gray100_10, .med_gray200_10, .med_purple_10, .med_gray100_10, .semi_purple_10, .semi_gray100_10:
            return 10
         
        case .bold_white_0:
            return 0
            
        }
    }
    
    
    var borderWidth: CGFloat {
        switch self {
        case .bold_purple_14:
            return 1
            
        default:
            return 0

        }
    }
        
    var font: UIFont {
        switch self {
        case .bold_purple_29, .bold_purple_14, .bold_gray200_14, .bold_purple_10, .bold_gray100_10:
            return UIFont.suit(.body_bold_15)

        case .bold_white_0:
            return UIFont.suit(.body_bold_13)
            
        case .semi_white_0, .semi_purple_10, .semi_gray100_10:
            return UIFont.suit(.body_semi_15)
            
        case .med_gray200_10, .med_purple_15, .med_gray100_15, .med_purple_10, .med_gray100_10:
            return UIFont.suit(.body_med_13)
        }
        
    }
        
}
