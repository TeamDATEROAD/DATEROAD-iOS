//
//  DRTextButton.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 2/28/25.
//

import UIKit

import Then

final class DRTextButton: UIButton {
    
    init(
        title: String,
        buttonName: ButtonName,
        isEnabled: Bool = true
    ) {
        super.init(frame: .zero)
        
        setProperties(
            title,
            buttonName,
            isEnabled
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DRTextButton {
    
    func setProperties(
        _ title: String,
        _ buttonName: ButtonName,
        _ isEnabled: Bool
    ) {
        self.do {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.cornerRadius = buttonName.cornerRadius
            $0.clipsToBounds = true
            $0.titleLabel?.font = buttonName.font
            $0.titleLabel?.numberOfLines = 1
            $0.clipsToBounds = true
        }
        setButtonStyle(buttonName, isEnabled: isEnabled)
    }
    
    func setButtonStyle(_ buttonName: ButtonName, isEnabled: Bool = true, isSelected: Bool = false) {
        self.do {
            $0.backgroundColor = buttonName.bgColor
            $0.setTitleColor(buttonName.fontColor, for: .normal)
            $0.layer.borderWidth = buttonName.borderWidth
            $0.isEnabled = isEnabled
            $0.isSelected = isSelected
            $0.layer.cornerRadius = buttonName.cornerRadius
        }
    }
    
}
