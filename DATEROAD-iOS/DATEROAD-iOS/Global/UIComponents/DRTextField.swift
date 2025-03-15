//
//  DRTextField.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 2/28/25.
//

import UIKit

enum DRTextFieldType: Equatable {
    enum AddCourseScheduleType {
        case dateName
        case visitDate
        case dateStartAt
        case dateLocation
        case datePlace
        case timeRequire
        case totalPrice
    }
    
    case AddCourseSchedule(AddCourseScheduleType)
    case profile
    
    var textFieldStyle: DRTextField.DRTextFieldStyle {
        switch self {
        case .AddCourseSchedule(let type):
            switch type {
            case .dateName:
                return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNmaePlaceHolder, cornerRadius: 14)
            case .visitDate:
                return .rightIcon(iconStyle: .calender, placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateLabel, cornerRadius: 14)
            case .dateStartAt:
                return .rightIcon(iconStyle: .time, placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.dateStartTimeLabel, cornerRadius: 14)
            case .dateLocation:
                return .rightIcon(iconStyle: .downArrow, placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.datePlaceLabel, cornerRadius: 14)
            case .datePlace:
                return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.datePlacePlaceHolder, cornerRadius: 14)
            case .timeRequire:
                return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder, cornerRadius: 14, alignment: .center)
            case .totalPrice:
                return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddThirdView.priceTextFieldPlaceHolder, cornerRadius: 14)
            }
        case .profile:
            return .rightTextButton(placeholder: StringLiterals.Profile.nicknamePlaceholder, cornerRadius: 14)
        }
    }
}

final class DRTextField: UITextField {
    
    enum DRTextFieldStyle {
        case basic(placeholder: String, cornerRadius: CGFloat, alignment: NSTextAlignment = .left)
        case rightTextButton(placeholder: String, cornerRadius: CGFloat)
        case rightIcon(iconStyle: RightIconStyle, placeholder: String, cornerRadius: CGFloat)
        
        var placeholderText: String {
            switch self {
            case .basic(let placeholder, _, _):
                return placeholder
            case .rightTextButton(let placeholder, _):
                return placeholder
            case .rightIcon(_, let placeholder, _):
                return placeholder
            }
        }
        
        var leftPadding: CGFloat {
            switch self {
            default:
                return 16
            }
        }
        
        var rightPadding: CGFloat {
            switch self {
            case .basic: 16
            case .rightTextButton: 16
            case .rightIcon: 18
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .basic(_, let cornerRadius, _):
                return cornerRadius
            case .rightTextButton(_, let cornerRadius):
                return cornerRadius
            case .rightIcon(_, _, let cornerRadius):
                return cornerRadius
            }
        }
        
        var rightSomeThingWidth: CGFloat {
            switch self {
            case .basic:
                return 0
            case .rightTextButton:
                return 74
            case .rightIcon(let iconStyle, _, _):
                return iconStyle.iconWidth
            }
        }
        
        var rightIconStyle: RightIconStyle {
            switch self {
            case .basic, .rightTextButton:
                return .none
            case .rightIcon(let iconStyle, _, _):
                return iconStyle
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .basic(_, _, let alignment):
                return alignment
            default:
                return .left
            }
        }
    }
    
    enum RightIconStyle {
        case none
        case calender
        case time
        case downArrow
        
        var image: UIImage? {
            switch self {
            case .none:
                return nil
            case .calender:
                return .calendar
            case .time:
                return .time
            case .downArrow:
                return .downArrow
            }
        }
        
        var iconWidth: CGFloat {
            switch self {
            case .none: return 0
            case .calender, .time: return 17
            case .downArrow: return 11
            }
        }
    }
    
    private let type: DRTextFieldStyle
    private var isNumberPad: Bool = false
    private var isRightButton: Bool = false
    private let leftPadding: CGFloat
    private let rightPadding: CGFloat
    
    init(type: DRTextFieldType) {
        self.isNumberPad = type == DRTextFieldType.AddCourseSchedule(.totalPrice) ? true : false
        self.isRightButton = type == DRTextFieldType.profile ? true : false
        
        self.type = type.textFieldStyle
        self.leftPadding = type.textFieldStyle.leftPadding
        self.rightPadding = type.textFieldStyle.rightPadding
        super.init(frame: .zero)
        
        setupTextField()
        setupRightView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //텍스트필드 속성 설정
    private func setupTextField() {
        setPlaceholder(placeholder: type.placeholderText, fontColor: UIColor(resource: .gray300), font: .suit(.body_semi_13))
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.layer.cornerRadius = type.cornerRadius
        self.textAlignment = type.alignment
        self.backgroundColor = UIColor(resource: .gray100)
        self.textColor = UIColor(resource: .drBlack)
        self.layer.borderColor = UIColor(resource: .alertRed).cgColor
        self.keyboardType = self.isNumberPad ? .numberPad : .default
    }
    
    //rightView 설정
    private func setupRightView() {
        if isRightButton {
            let button = UIButton()
            button.setTitle(StringLiterals.Profile.doubleCheck, for: .normal)
            button.setTitleColor(UIColor(resource: .gray400), for: .normal)
            button.titleLabel?.font = .suit(.body_med_13)
            button.backgroundColor = UIColor(resource: .gray200)
            button.layer.cornerRadius = 10
            
            rightView = button
            rightViewMode = .always
        } else {
            guard let icon = type.rightIconStyle.image else {return}
            let iconView = UIImageView(image: icon)
            iconView.tintColor = UIColor.gray200
            iconView.contentMode = .scaleAspectFit
            
            rightView = iconView
            rightViewMode = .always
        }
    }
    
    //우측 패딩 계산 함수
    private func calculateRightPadding() -> CGFloat {
        return type.rightIconStyle == .none ? rightPadding : rightPadding + type.rightSomeThingWidth
    }
    
    //text가 표시되는 영역(normal)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: calculateRightPadding()))
    }
    
    //text가 표시되는 영역(editing)
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: calculateRightPadding()))
    }
    
    //textField leftView가 위치할 영역 (현재의 경우 여백)
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: .zero, size: CGSize(width: leftPadding, height: bounds.height))
    }
    
    //textField rightView가 위치할 영역 (현재의 경우 아이콘 or 버튼)
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var size = CGSize(width: type.rightSomeThingWidth, height: type.rightSomeThingWidth)
        if isRightButton {
            size = CGSize(width: type.rightSomeThingWidth, height: 30)
        }
        return CGRect(
            origin: CGPoint(x: bounds.width - size.width - rightPadding, y: (bounds.height - size.height) / 2),
            size: size
        )
    }
}
