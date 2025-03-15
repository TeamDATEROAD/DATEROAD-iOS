//
//  DRTextFieldType.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 3/16/25.
//

import UIKit

enum DRTextFieldType: Equatable {
    
    case addCourseSchedule(AddCourseScheduleType)
    
    case profile
    
    var textFieldStyle: DRTextFieldStyle {
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

enum AddCourseScheduleType {
    
    case dateName
    
    case visitDate
    
    case dateStartAt
    
    case dateLocation
    
    case datePlace
    
    case totalPrice
    
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
