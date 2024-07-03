//
//  OnboardingModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

struct OnboardingModel {
    
    let bgIMG: UIImage?
    
    let mainInfo: String
    
    let subInfo: String
    
    let pointText: [String]
    
    let buttonText: String
    
    let buttonType: DRButton
    
    init(bgIMG: UIImage?, mainInfo: String, subInfo: String, pointText: [String], buttonText: String, buttonType: DRButton) {
        self.bgIMG = bgIMG
        self.mainInfo = mainInfo
        self.subInfo = subInfo
        self.pointText = pointText
        self.buttonText = buttonText
        self.buttonType = buttonType
    }
    
}
