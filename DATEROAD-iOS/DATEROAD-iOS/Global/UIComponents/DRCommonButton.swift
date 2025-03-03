//
//  DRCommonButton.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 3/2/25.
//

import UIKit

enum DRCommonButtonType {
    case nextValidType
    
    var titleStyle: DRCommonButton.DRCommonBtnTitleStyle {
        switch self {
        case .nextValidType:
            return .text(title: StringLiterals.AddCourseOrSchedule.AddFirstView.addFirstNextBtnOfCourse, suitFontStyle: .body_bold_15)
        }
    }
    var handleStyle: DRCommonButton.DRCommonBtnHandleStyle {
        switch self {
        case .nextValidType:
            return .handle(enabledTitleColor: UIColor(resource: .drWhite),
                           disabledTitleColor: UIColor(resource: .gray400),
                           enabledBackgroundColor: UIColor(resource: .deepPurple),
                           disabledBackgroundColor: UIColor(resource: .gray200))
        }
    }
    var cornerRadius: CGFloat {
        switch self {
        case .nextValidType: 14
        }
    }
}

final class DRCommonButton: UIButton {
    enum DRCommonBtnTitleStyle {
        case text(title: String, suitFontStyle: FontName)
        case image(image: UIImage)
    }
    enum DRCommonBtnHandleStyle {
        case noneHandle(backgroundFixColor: UIColor, foregroundFixColor: UIColor)
        case handle(enabledTitleColor: UIColor,
                    disabledTitleColor: UIColor,
                    enabledBackgroundColor: UIColor,
                    disabledBackgroundColor: UIColor)
    }
    
    private let titleType: DRCommonBtnTitleStyle
    private let handleType: DRCommonBtnHandleStyle
    private let cornerRadius: CGFloat

    init(
        titleType: DRCommonBtnTitleStyle,
        handleType: DRCommonBtnHandleStyle,
        cornerRadius: CGFloat
    ) {
        self.titleType = titleType
        self.handleType = handleType
        self.cornerRadius = cornerRadius
        
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.plain()
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
        case .handle(let enabledTitleColor,
                     let disabledTitleColor,
                     let enabledBackgroundColor,
                     let disabledBackgroundColor):
            let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
                switch button.state {
                case .disabled:
                    print("!!!현재 disabled!!!")
                    button.configuration?.background.backgroundColor = disabledBackgroundColor
                    self.updateTitleColor(to: disabledTitleColor)
                case .normal:
                    print("!!!현재 abled!!!")
                    button.configuration?.background.backgroundColor = enabledBackgroundColor
                    self.updateTitleColor(to: enabledTitleColor)
                default:
                    print("default")
                }
            }
            self.configurationUpdateHandler = buttonStateHandler
        }
        self.configuration = config
        self.alpha = 1.0
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func updateTitleColor(to color: UIColor) {
        guard var config = self.configuration else { return }
        
        if case .text(let title, let fontStyle) = self.titleType {
            var titleAttr = AttributedString(title)
            titleAttr.font = UIFont.suit(fontStyle)
            titleAttr.foregroundColor = color
            config.attributedTitle = titleAttr
            self.configuration = config
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
