//
//  ErrorType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/6/24.
//

import UIKit

protocol DRErrorType {
    
    var fontColor: UIColor { get }
    
    var font: UIFont { get }
    
}

extension DRErrorType {
    
    var font: UIFont  { return UIFont.suit(.cap_reg_11) }
    
}

struct Warning: DRErrorType {
    
    var fontColor: UIColor = UIColor(resource: .alertRed)
    
}

struct Correct: DRErrorType {
    
    var fontColor: UIColor = UIColor(resource: .deepPurple)
    
}
