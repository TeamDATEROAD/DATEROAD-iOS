//
//  DRImageButton.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/4/25.
//

import UIKit

import Then

final class DRImageButton: UIButton {
    
    init(
        image: UIImage,
        buttonName: ImageButtonType,
        isEnabled: Bool = true,
        isHidden: Bool = false
    ) {
        super.init(frame: .zero)
        
        setProperties(
            image,
            buttonName,
            isEnabled,
            isHidden
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DRImageButton {
    
    func setProperties(
        _ image: UIImage,
        _ buttonName: ImageButtonType,
        _ isEnabled: Bool,
        _ isHidden: Bool
    ) {
        var config = UIButton.Configuration.filled()
        config.imageColorTransformer = nil
        
        self.do {
            $0.configuration = config
            $0.clipsToBounds = true
            $0.layer.borderWidth = buttonName.borderWidth
            $0.imageView?.contentMode = .scaleAspectFit
            $0.tintAdjustmentMode = .normal
        }
        setButtonStyle(
            image,
            buttonName,
            isEnabled: isEnabled
        )
    }
    
    func setButtonStyle(
        _ image: UIImage,
        _ buttonName: ImageButtonType,
        isEnabled: Bool = true
    ) {
        self.do {
            $0.configuration?.background.backgroundColor = buttonName.bgColor
            $0.configuration?.image = image.withRenderingMode(.alwaysOriginal)
            $0.isEnabled = isEnabled
            $0.layer.cornerRadius = buttonName.cornerRadius
        }
    }
    
    func setButtonHidden(_ isHidden: Bool) {
        self.isHidden = isHidden
    }
    
}
