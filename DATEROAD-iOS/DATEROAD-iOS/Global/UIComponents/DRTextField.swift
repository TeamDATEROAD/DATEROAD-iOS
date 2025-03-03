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
        }
    }
}

final class DRTextField: UITextField {
    
    enum DRTextFieldStyle {
        case basic(placeholder: String, cornerRadius: CGFloat, alignment: NSTextAlignment = .left)
        case rightButton(placeholder: String, cornerRadius: CGFloat)
        case rightIcon(iconStyle: RightIconStyle, placeholder: String, cornerRadius: CGFloat)
        
        var placeholderText: String {
            switch self {
            case .basic(let placeholder, _, _):
                return placeholder
            case .rightButton(let placeholder, _):
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
            case .rightButton: 16
            case .rightIcon: 18
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .basic(_, let cornerRadius, _):
                return cornerRadius
            case .rightButton(_, let cornerRadius):
                return cornerRadius
            case .rightIcon(_, _, let cornerRadius):
                return cornerRadius
            }
        }
        
        var rightSomeThingWidth: CGFloat {
            switch self {
            case .basic, .rightButton:
                return 0
            case .rightIcon(let iconStyle, _, _):
                return iconStyle.iconWidth
            }
        }
        
        var rightIconStyle: RightIconStyle {
            switch self {
            case .basic, .rightButton:
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
    private let leftPadding: CGFloat
    private let rightPadding: CGFloat
    
    init(type: DRTextFieldType) {
        self.isNumberPad = type == DRTextFieldType.AddCourseSchedule(.totalPrice) ? true : false
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
    
    private func setupRightView() {
        guard let icon = type.rightIconStyle.image else {return}
        let iconView = UIImageView(image: icon)
        iconView.tintColor = UIColor.gray200
        iconView.contentMode = .scaleAspectFit
        
        rightView = iconView
        rightViewMode = .always
    }
    
    private func calculateRightPadding() -> CGFloat {
        return type.rightIconStyle == .none ? rightPadding : rightPadding + type.rightSomeThingWidth
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: calculateRightPadding()))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: calculateRightPadding()))
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: .zero, size: CGSize(width: leftPadding, height: bounds.height))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let size = CGSize(width: type.rightSomeThingWidth, height: type.rightSomeThingWidth)
        return CGRect(
            origin: CGPoint(x: bounds.width - size.width - rightPadding, y: (bounds.height - size.height) / 2),
            size: size
        )
    }
    
}
