//
//  ImageButtonType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/13/25.
//

import UIKit

enum ImageButtonType {
    
    case deepPurple_white_25, deepPurple_white_15, deepPurple_white_14
    
    case gray100_gray300_14
    
    case white_gray600_0, white_gray400_0, white_gray300_0
    
    case clear_mediumPurple_0, clear_black_0, clear_gray400_0, clear_clear_16, clear_clear_8, clear_clear_0
    
    
    var bgColor: UIColor {
        switch self {
        case .deepPurple_white_25, .deepPurple_white_15, .deepPurple_white_14:
            return UIColor(resource: .deepPurple)
            
        case .gray100_gray300_14:
            return UIColor(resource: .gray100)
            
        case .white_gray600_0, .white_gray400_0, .white_gray300_0:
            return UIColor(resource: .drWhite)
            
        case .clear_mediumPurple_0,
                .clear_black_0,
                .clear_gray400_0,
                .clear_clear_16, .clear_clear_8, .clear_clear_0:
            return UIColor.clear
            
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .clear_black_0:
            return UIColor(resource: .drBlack)
            
        case .deepPurple_white_25, .deepPurple_white_15, .deepPurple_white_14:
            return UIColor(resource: .drWhite)
            
        case .white_gray600_0:
            return UIColor(resource: .gray600)
            
        case .white_gray400_0, .clear_gray400_0:
            return UIColor(resource: .gray400)
            
        case .gray100_gray300_14, .white_gray300_0:
            return UIColor(resource: .gray300)
            
        case .clear_clear_16, .clear_clear_8, .clear_clear_0:
            return UIColor.clear
            
        case .clear_mediumPurple_0:
            return UIColor(resource: .mediumPurple)
            
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .deepPurple_white_25:
            return 25
            
        case .clear_clear_16:
            return 16
            
        case .deepPurple_white_15:
            return 15
            
        case .deepPurple_white_14, .gray100_gray300_14:
            return 14
         
        case .clear_clear_8:
            return 8
            
        case .white_gray600_0, .white_gray400_0, .white_gray300_0,
                .clear_mediumPurple_0, .clear_black_0, .clear_gray400_0, .clear_clear_0:
            return 0
            
        }
    }
    
    var borderWidth: CGFloat {
        return 0
    }
        
}
