//
//  DRTextField.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 2/28/25.
//

import UIKit

final class DRTextField: UITextField {
    
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
            iconView.isUserInteractionEnabled = true
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
