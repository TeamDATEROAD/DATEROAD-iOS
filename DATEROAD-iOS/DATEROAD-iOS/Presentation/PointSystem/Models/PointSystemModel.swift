//
//  PointSystemModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

struct PointSystemModel {
    
    let illustration: UIImage
    
    let mainTitle: String
    
    let subTitle: String
    
    init(illustration: UIImage, mainTitle: String, subTitle: String) {
        self.illustration = illustration
        self.mainTitle = mainTitle
        self.subTitle = subTitle
    }
    
    static var pointSystemData: [PointSystemModel] =  {
        return [PointSystemModel(illustration: UIImage(resource: .imgPoint1),
                                 mainTitle: StringLiterals.PointSystem.firstMainSystem,
                                 subTitle: StringLiterals.PointSystem.firstSubSystem),
                PointSystemModel(illustration: UIImage(resource: .imgPoint2),
                                         mainTitle: StringLiterals.PointSystem.secondMainSystem,
                                         subTitle: StringLiterals.PointSystem.secondSubSystem),
                PointSystemModel(illustration: UIImage(resource: .imgPoint3),
                                         mainTitle: StringLiterals.PointSystem.thirdMainSystem,
                                         subTitle: StringLiterals.PointSystem.thirdSubSystem),
                PointSystemModel(illustration: UIImage(resource: .imgPoint4),
                                         mainTitle: StringLiterals.PointSystem.fourthMainSystem,
                                         subTitle: StringLiterals.PointSystem.fourthSubSystem)]
    }()
}
