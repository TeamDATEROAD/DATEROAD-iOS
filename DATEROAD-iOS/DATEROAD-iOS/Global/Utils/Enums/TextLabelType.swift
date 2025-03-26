//
//  TextLabelType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/18/25.
//

import UIKit

enum TextLabelType {
    
    case clear(TextStyle)
    
    case background(TextStyle, BackgroundStyle)
 
    var textStyle: TextStyle {
        switch self {
        case .clear(let textStyle), .background(let textStyle, _):
            return textStyle
        }
    }
}

enum TextStyle {
    
    case extra24_black, extra24_white, extra20_black, extra20_gray300
    
    case systemBold24_black, systemBold20_black, systemBold20_white, bold20_black, bold20_white, bold18_black, bold18_white, bold18_gray300,
         bold18_gray500, systemBold17_black, bold17_black, systemBold15_black, bold15_black, bold15_gray500, bold13_white, bold11_white, bold11_gray300
    
    case semi15_black, semi15_deepPurple, semi15_gray400, semi13_black, semi13_white, semi13_gray500, semi13_gray400
    
    case med15_purple400, med15_gray500, med15_gray300, med13_black, med13_gray500,
         systemMed13_gray400, med13_gray400, med13_gray300, systemMed13_white,
         systemMed13_black, med13_white, med10_white
    
    case reg11_gray400, reg11_gray300, reg11_alertRed, reg11_purple600
    
    var font: UIFont {
        switch self {
        case .extra24_black, .extra24_white:
            return UIFont.suit(.title_extra_24)
        
        case .extra20_black, .extra20_gray300:
            return UIFont.suit(.title_extra_20)
            
        case .systemBold24_black:
            return UIFont.systemFont(ofSize: 24, weight: .bold)
            
        case .systemBold20_black, .systemBold20_white:
            return UIFont.systemFont(ofSize: 20,weight: .bold)
            
        case .bold20_black, .bold20_white:
            return UIFont.suit(.title_bold_20)
            
        case .bold18_black, .bold18_white, .bold18_gray300, .bold18_gray500:
            return UIFont.suit(.title_bold_18)

        case .systemBold17_black:
            return UIFont.systemFont(ofSize: 17, weight: .bold)

        case .bold17_black:
            return UIFont.suit(.body_bold_17)

        case .bold15_black, .bold15_gray500:
            return UIFont.suit(.body_bold_15)
            
        case .systemBold15_black:
            return UIFont.systemFont(ofSize: 15, weight: .bold)

        case .bold13_white:
            return UIFont.suit(.body_bold_13)

        case .bold11_white, .bold11_gray300:
            return UIFont.suit(.cap_bold_11)

        case .semi15_black, .semi15_deepPurple, .semi15_gray400:
            return UIFont.suit(.body_semi_15)
            
        case .systemMed13_black, .systemMed13_gray400, .systemMed13_white:
            return UIFont.systemFont(ofSize: 13, weight: .medium)
            
        case .semi13_black, .semi13_white, .semi13_gray500, .semi13_gray400:
            return UIFont.suit(.body_semi_13)

        case .med15_purple400, .med15_gray500, .med15_gray300:
            return UIFont.suit(.body_med_15)

        case .med13_black, .med13_gray500, .med13_gray400, .med13_gray300, .med13_white:
            return UIFont.suit(.body_med_13)

        case .med10_white:
            return UIFont.suit(.body_med_10)
            
        case .reg11_gray400, .reg11_gray300, .reg11_alertRed, .reg11_purple600:
            return UIFont.suit(.cap_reg_11)

        }
    }
    
    var textColor: UIColor {
        switch self {
        case .extra24_black, .systemBold24_black, .extra20_black, .systemBold20_black,
                .bold20_black, .bold18_black, .systemBold17_black, .bold17_black,
                .systemBold15_black, .bold15_black, .semi15_black, .semi13_black,
                .systemMed13_black, .med13_black:
            return UIColor(.drBlack)

        case .extra24_white, .systemBold20_white, .bold20_white, .bold18_white, .bold13_white, .bold11_white, .semi13_white, .systemMed13_white, .med13_white, .med10_white:
            return UIColor(.drWhite)

        case .bold15_gray500, .bold18_gray500, .semi13_gray500, .med15_gray500, .med13_gray500:
            return UIColor(.gray500)
            
        case .semi15_gray400, .semi13_gray400, .systemMed13_gray400, .med13_gray400, .reg11_gray400:
            return UIColor(.gray400)

        case .extra20_gray300, .bold18_gray300, .bold11_gray300, .med15_gray300, .med13_gray300, .reg11_gray300:
            return UIColor(.gray300)
            
        case .semi15_deepPurple, .reg11_purple600:
            return UIColor(.deepPurple)
            
        case .med15_purple400:
            return UIColor(.lightPurple)

        case .reg11_alertRed:
            return UIColor(.alertRed)
        }
    }
}

enum BackgroundStyle {
    
    case deepPurple_12, deepPurple_10
    
    case mediumPurple_14, mediumPurple_10
    
    case gray400_20, gray400_11
        
    var cornerMask: CACornerMask {
        switch self {
        case .deepPurple_10, .gray400_20, .gray400_11, .mediumPurple_10:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
        case .deepPurple_12:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        case .mediumPurple_14:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .gray400_20:
            return 20
            
        case .mediumPurple_14:
            return 14
            
        case .deepPurple_12:
            return 12
            
        case .gray400_11:
            return 11
            
        case .deepPurple_10, .mediumPurple_10:
            return 10
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .deepPurple_12, .deepPurple_10:
            return UIColor(.deepPurple)
            
        case .mediumPurple_14, .mediumPurple_10:
            return UIColor(.mediumPurple)
            
        case .gray400_20, .gray400_11:
            return UIColor(.gray400)

        }
    }
}
