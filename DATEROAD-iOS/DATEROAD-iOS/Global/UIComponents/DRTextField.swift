//
//  DRTextField.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 2/28/25.
//

import UIKit

final class DRTextField: UITextField {
    enum DRTextFieldType: Equatable {
        enum AddCourseScheduleType {
            case dateName
            case visitDate
            case dateStartAt
            case dateLocation
            case datePlace
            case totalPrice
        }
        
        case addCourseSchedule(AddCourseScheduleType)
        case profile
        
        var textFieldStyle: DRTextField.DRTextFieldStyle {
            switch self {
            case .addCourseSchedule(let type):
                switch type {
                case .dateName:
                    return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNmaePlaceHolder,
                        cornerRadius: 14,
                        font: UIFont.systemFont(ofSize: 13, weight: .semibold))
                case .visitDate:
                    return .rightIcon(iconStyle: .calender,
                                      placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateLabel,
                                      cornerRadius: 14,
                                      font: UIFont.suit(.body_semi_13))
                case .dateStartAt:
                    return .rightIcon(iconStyle: .time,
                                      placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.dateStartTimeLabel,
                                      cornerRadius: 14,
                                      font: UIFont.suit(.body_semi_13))
                case .dateLocation:
                    return .rightIcon(iconStyle: .downArrow,
                                      placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.datePlaceLabel,
                                      cornerRadius: 14,
                                      font: UIFont.suit(.body_semi_13))
                case .datePlace:
                    return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.datePlacePlaceHolder,
                                  cornerRadius: 14,
                                  font: UIFont.systemFont(ofSize: 13, weight: .semibold))
                                    //TODO: 추후 장소 api 붙이면 이상한 글자 입력될 일 없으니 suit font 적용하기
                case .totalPrice:
                    return .basic(placeholder: StringLiterals.AddCourseOrSchedule.AddThirdView.priceTextFieldPlaceHolder,
                                  cornerRadius: 14,
                                  font: .suit(.body_med_13))
                }
            case .profile:
                return .rightTextButton(placeholder:    StringLiterals.Profile.nicknamePlaceholder,
                                        cornerRadius: 14,
                                        font: UIFont.systemFont(ofSize: 15, weight: .semibold))
            }
        }
    }
    
    enum DRTextFieldStyle {
        case basic(placeholder: String,
                   cornerRadius: CGFloat,
                   alignment: NSTextAlignment = .left,
                   font: UIFont)
        case rightTextButton(placeholder: String,
                             cornerRadius: CGFloat,
                             font: UIFont)
        case rightIcon(iconStyle: RightIconStyle,
                       placeholder: String,
                       cornerRadius: CGFloat,
                       font: UIFont)
        
        var placeholderText: String {
            switch self {
            case .basic(let placeholder, _, _, _):
                return placeholder
            case .rightTextButton(let placeholder, _, _):
                return placeholder
            case .rightIcon(_, let placeholder, _, _):
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
            case .basic(_, let cornerRadius, _, _):
                return cornerRadius
            case .rightTextButton(_, let cornerRadius, _):
                return cornerRadius
            case .rightIcon(_, _, let cornerRadius, _):
                return cornerRadius
            }
        }
        
        var rightSomeThingWidth: CGFloat {
            switch self {
            case .basic:
                return 0
            case .rightTextButton:
                return 74
            case .rightIcon(let iconStyle, _, _, _):
                return iconStyle.iconWidth
            }
        }
        
        var rightIconStyle: RightIconStyle {
            switch self {
            case .basic, .rightTextButton:
                return .none
            case .rightIcon(let iconStyle, _, _, _):
                return iconStyle
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .basic(_, _, let alignment, _):
                return alignment
            default:
                return .left
            }
        }
        
        var font: UIFont {
            switch self {
            case .basic(_, _, _, let font):
                return font
            case .rightTextButton(_, _, let font):
                return font
            case .rightIcon(_, _, _, let font):
                return font
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
        self.isNumberPad = type == DRTextFieldType.addCourseSchedule(.totalPrice)
        self.isRightButton = type == DRTextFieldType.profile
        
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
        self.do {
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            $0.layer.cornerRadius = type.cornerRadius
            $0.textAlignment = type.alignment
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.textColor = UIColor(resource: .drBlack)
            $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
            $0.keyboardType = self.isNumberPad ? .numberPad : .default
            $0.font = type.font
            let placeholderFont: UIFont = isRightButton ? .suit(.body_semi_15) : .suit(.body_semi_13)
            $0.setPlaceholder(placeholder: type.placeholderText,
                              fontColor: UIColor(resource: .gray300),
                              font: placeholderFont)
        }
    }
    
    //rightView 설정
    private func setupRightView() {
        if isRightButton {
            let button = DRTextButton(title: StringLiterals.Profile.doubleCheck, buttonName: .med_gray400_13)
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
