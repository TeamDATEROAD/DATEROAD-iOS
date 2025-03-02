//
//  DRCommonButton.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 3/2/25.
//

import UIKit

enum DRCommonButtonHandleType {
    case noneHandle
    case handle(foregroundColor: UIColor, backgroundColor: UIColor)
}

protocol DRCommonButtonType {
    var handleType: DRCommonButtonHandleType { get }
    var enabledBackgroundColor: UIColor { get }
    var disabledBackgroundColor: UIColor { get }
    var enabledTitleColor: UIColor { get }
    var disabledTitleColor: UIColor { get }
    var cornerRadius: CGFloat { get }
}

final class DRCommonButton: UIButton, DRCommonButtonType {
    enum DRCommonBtnTitleType {
        case text(title: String, titleFont: UIFont)
        case image(image: UIImage)
    }
    
    private let titleType: DRCommonBtnTitleType
    private(set) var handleType: DRCommonButtonHandleType
    private(set) var enabledBackgroundColor: UIColor
    private(set) var disabledBackgroundColor: UIColor
    private(set) var enabledTitleColor: UIColor
    private(set) var disabledTitleColor: UIColor
    private(set) var cornerRadius: CGFloat

    init(
        titleType: DRCommonBtnTitleType,
        handleType: DRCommonButtonHandleType,
        titleColor: UIColor? = nil,
        disabledTitleColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        disabledBackgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil
    ) {
        self.titleType = titleType
        self.handleType = handleType
        self.enabledBackgroundColor = backgroundColor ?? UIColor.deepPurple
        self.disabledBackgroundColor = disabledBackgroundColor ?? UIColor.gray200
        self.enabledTitleColor = titleColor ?? UIColor.drWhite
        self.disabledTitleColor = disabledTitleColor ?? UIColor.gray400
        self.cornerRadius = cornerRadius ?? CGFloat(14)
        
        super.init(frame: .zero)

        self.layer.cornerRadius = self.cornerRadius
        
        self.configurationUpdateHandler = { button in
            var config = button.configuration ?? UIButton.Configuration.filled()

            switch titleType {
                
            case .text(title: let title, titleFont: let titleFont):
                var titleAttr = AttributedString(title)
                titleAttr.font = titleFont
                config.attributedTitle = titleAttr
            case .image(image: let image):
                config.image = image
                //이미지 크기 설정 추가해야함
            }
            
            switch handleType {
            case .noneHandle:
                config.baseBackgroundColor = button.isEnabled ? self.enabledBackgroundColor : self.disabledBackgroundColor
                config.baseForegroundColor = button.isEnabled ? self.enabledTitleColor : self.disabledTitleColor
            case .handle(let foregroundColor, let baseBackgroundColor):
                print("~~")
            }
            
            button.configuration = config
        }
        //button 비활성화 default
        self.isEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
