//
//  DRTextField.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 2/28/25.
//

import UIKit

final class DRTextField: UITextField {
    
    enum RightIconType {
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
    }
    
    private let leftPadding: CGFloat = 16
    private var baseRightPadding: CGFloat = 16.5
    private var rightIconWidth: CGFloat = 17
    private var rightIconType: RightIconType
    
    init(placeholderText: String, rightIconType: RightIconType = .none) {
        self.rightIconType = rightIconType
        super.init(frame: .zero)
        
        self.placeholder = placeholderText
        setupTextField()
        setupRightView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor(resource: .gray100)
        self.textColor = UIColor(resource: .drBlack)
        self.font = .suit(.body_semi_13)
        self.layer.borderColor = UIColor(resource: .alertRed).cgColor
    }
    
    private func setupRightView() {
        guard let icon = rightIconType.image else {
            rightViewMode = .never
            return
        }
        
        if rightIconType == .downArrow {
            baseRightPadding = 18
            rightIconWidth = 11
        }
        let iconView = UIImageView(image: icon)
        iconView.tintColor = UIColor.gray200
        iconView.contentMode = .scaleAspectFit
        
        rightView = iconView
        rightViewMode = .always
    }
    
    private func calculateRightPadding() -> CGFloat {
        return rightIconType == .none ? baseRightPadding : baseRightPadding + rightIconWidth
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
        let size = CGSize(width: rightIconWidth, height: rightIconWidth)
        return CGRect(
            origin: CGPoint(x: bounds.width - size.width - baseRightPadding, y: (bounds.height - size.height) / 2),
            size: size
        )
    }
    
}
