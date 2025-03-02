//
//  DRCommonButton.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 3/2/25.
//

import UIKit

final class DRCommonButton: UIButton {
    enum DRCommonBtnTitleType {
        case text(title: String, suitFontStyle: FontName)
        case image(image: UIImage)
    }
    enum DRCommonBtnHandleType {
        case noneHandle(backgroundFixColor: UIColor, foregroundFixColor: UIColor)
        case handle(enabledTitleColor: UIColor,
                    disabledTitleColor: UIColor,
                    enabledBackgroundColor: UIColor,
                    disabledBackgroundColor: UIColor)
    }
    
    private let titleType: DRCommonBtnTitleType
    private let handleType: DRCommonBtnHandleType

    init(
        titleType: DRCommonBtnTitleType,
        handleType: DRCommonBtnHandleType,
        cornerRadius: CGFloat
    ) {
        self.titleType = titleType
        self.handleType = handleType
        
        super.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.configurationUpdateHandler = { button in
            var config = button.configuration ?? UIButton.Configuration.filled()

            switch titleType {
            case .text(title: let title, suitFontStyle: let fontStyle):
                var titleAttr = AttributedString(title)
                titleAttr.font = UIFont.suit(fontStyle)
                config.attributedTitle = titleAttr
            case .image(image: let image):
                config.image = image
                //이미지 크기 설정 추가해야함
            }
            
            switch handleType {
            case .noneHandle(let baseBackgroundColor, let foregroundColor):
                config.baseBackgroundColor = baseBackgroundColor
                config.baseForegroundColor = foregroundColor
                self.isEnabled = true //noneHandle에 따른 enable true default
            case .handle(let enabledTitleColor,
                         let disabledTitleColor,
                         let enabledBackgroundColor,
                         let disabledBackgroundColor):
                
                config.baseBackgroundColor = button.isEnabled ? enabledBackgroundColor : disabledBackgroundColor
                config.baseForegroundColor = button.isEnabled ? enabledTitleColor : disabledTitleColor
                self.isEnabled = false
            }
            button.configuration = config
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
