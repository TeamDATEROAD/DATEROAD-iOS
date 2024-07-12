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

    let hintInfo: String?

    let pointText: [String]
    
    let buttonText: String
        
    init(bgIMG: UIImage, mainInfo: String, subInfo: String, hintInfo: String?, pointText: [String], buttonText: String) {
        self.bgIMG = bgIMG
        self.mainInfo = mainInfo
        self.subInfo = subInfo
        self.hintInfo = hintInfo
        self.pointText = pointText
        self.buttonText = buttonText
    }
    
}
