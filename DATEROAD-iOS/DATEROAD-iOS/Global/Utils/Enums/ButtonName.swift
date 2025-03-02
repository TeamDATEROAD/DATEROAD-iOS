//
//  ButtonName.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/2/25.
//

import UIKit

enum ButtonName {
    
    case large_enable_14, large_disable_14, large_enable_29
    
    case small_selected_15, small_unselected_15, small_selected_10, small_unselected_10, semi_small_selected_10, semi_small_unselected_10, small_disable_10, small_enable_10, small_text_0
    
    
    var bgColor: UIColor {
        switch self {
        case .large_enable_14, .large_enable_29, .small_selected_15, .small_selected_10, .semi_small_selected_10, .small_enable_10:
            return UIColor(resource: .deepPurple)
            
        case .large_disable_14, .small_disable_10:
            return UIColor(resource: .gray200)
            
        case .small_unselected_15, .small_unselected_10, .semi_small_unselected_10:
            return UIColor(resource: .gray100)
            
        case .small_text_0:
            return UIColor(resource: .drWhite)
            
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .large_enable_14, .large_enable_29, .small_selected_15, .small_selected_10, .semi_small_selected_10, .small_enable_10:
            return UIColor(resource: .drWhite)
            
        case .large_disable_14, .small_unselected_15, .small_unselected_10, .semi_small_unselected_10, .small_disable_10:
            return UIColor(resource: .gray400)
            
        case .small_text_0:
            return UIColor(resource: .mediumPurple)
            
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .large_enable_14, .large_enable_29, .small_selected_15, .small_selected_10, .semi_small_selected_10, .small_enable_10:
            return UIColor(resource: .deepPurple).cgColor
            
        case .large_disable_14, .small_disable_10:
            return UIColor(resource: .gray200).cgColor
         
        case .small_unselected_15, .small_unselected_10, .semi_small_unselected_10:
            return UIColor(resource: .gray100).cgColor
            
        case .small_text_0:
            return UIColor(resource: .drWhite).cgColor
            
        }
    }

    
    var cornerRadius: CGFloat {
        switch self {
        case .large_enable_29:
            return ScreenUtils.height / 812 * 29
            
        case .small_selected_15, .small_unselected_15:
            return 15
            
        case .large_enable_14, .large_disable_14:
            return 14

        case .small_disable_10, .small_enable_10, .small_selected_10, .small_unselected_10, .semi_small_selected_10, .semi_small_unselected_10:
            return 10
         
        case .small_text_0:
            return 0
            
        }
    }
    
    
    var borderWidth: CGFloat {
        switch self {
        case .large_enable_14:
            return 1
            
        case .large_disable_14, .large_enable_29, .small_disable_10, .small_enable_10, .small_text_0, .small_selected_15, .small_unselected_15, .small_selected_10, .small_unselected_10, .semi_small_selected_10, .semi_small_unselected_10:
            return 0

        }
    }
        
    var font: UIFont {
        switch self {
        case .large_enable_29, .large_enable_14, .large_disable_14:
            return UIFont.suit(.body_bold_15)

        case .small_text_0:
            return UIFont.suit(.body_bold_13)
            
        case .semi_small_selected_10, .semi_small_unselected_10:
            return UIFont.suit(.body_semi_15)
            
        case .small_disable_10, .small_enable_10, .small_selected_15, .small_unselected_15, .small_selected_10, .small_unselected_10:
            return UIFont.suit(.body_med_13)
        }
        
    }
        
}
