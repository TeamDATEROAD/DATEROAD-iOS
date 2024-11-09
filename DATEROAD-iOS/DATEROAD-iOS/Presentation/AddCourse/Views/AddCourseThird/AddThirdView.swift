//
//  AddThirdView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class AddThirdView: BaseView {
    
    // MARK: - UI Properties
    
    private let container: UIView = UIView()
    
    private let contentTitleLabel: UILabel = UILabel()
    
    let contentTextView: UITextView = UITextView()
    
    let contentTextCountLabel: UILabel = UILabel()
    
    private let priceTitleLabel: UILabel = UILabel()
    
    var priceTextField: UITextField = UITextField()
    
    private let addThirdDoneBtnContainer: UIView = UIView()
    
    
    // MARK: - Properties
    
    let textViewPlaceHolder = StringLiterals.AddCourseOrSchedule.AddThirdView.contentTextFieldPlaceHolder
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        addSubviews(container)
        
        container.addSubviews(
            contentTitleLabel,
            contentTextView,
            contentTextCountLabel,
            priceTitleLabel,
            priceTextField,
            addThirdDoneBtnContainer
        )
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(244)
        }
        
        contentTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        priceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextCountLabel.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview()
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(priceTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        addThirdDoneBtnContainer.snp.makeConstraints {
            $0.top.equalTo(priceTextField.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        contentTitleLabel.do {
            $0.setLabel(
                text: StringLiterals.AddCourseOrSchedule.AddThirdView.contentTitleLabel,
                alignment: .left,
                textColor: UIColor(resource: .drBlack),
                font: .suit(.body_bold_17)
            )
        }
        
        [contentTextView, priceTextField].forEach {
            $0.layer.borderWidth = 0
            $0.layer.cornerRadius = 14
            $0.backgroundColor = UIColor(resource: .gray100)
        }
        
        contentTextView.do {
            $0.text = textViewPlaceHolder
            $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            $0.textColor = UIColor(resource: .gray300)
            $0.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
            $0.isScrollEnabled = true
            $0.textAlignment = .left
            $0.showsVerticalScrollIndicator = false
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
        }
        
        priceTextField.do {
            $0.setLeftPadding(amount: 16)
            $0.setRightPadding(amount: 16)
            $0.keyboardType = .numberPad
            $0.font = .suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
        }
        
        priceTextField.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrSchedule.AddThirdView.priceTextFieldPlaceHolder,
            fontColor: UIColor(resource: .gray300),
            font: .suit(.body_med_13)
        )
        
        contentTextCountLabel.do {
            $0.setLabel(
                alignment: .right,
                textColor: UIColor(resource: .gray300),
                font: .suit(.body_med_13)
            )
            $0.text = StringLiterals.AddCourseOrSchedule.AddThirdView.contentTextCountLabel
        }
        
        priceTitleLabel.do {
            $0.setLabel(
                alignment: .left,
                textColor: UIColor(resource: .drBlack),
                font: .suit(.body_bold_17)
            )
            $0.text = StringLiterals.AddCourseOrSchedule.AddThirdView.priceTitleLabel
        }
    }
    
}

extension AddThirdView {
    
    func updateContentTextCount(textCnt: Int) {
        contentTextCountLabel.text = "\(textCnt)자 / 200자 이상"
    }
    
    func updatePriceText(price: Int) {
        priceTextField.text = String(price.formattedWithSeparator)
    }
    
    func updateContentTextView(_ textView: UITextView, withText text: String, placeholder: String) {
        let isTextEmpty = text.isEmpty
        let textToDisplay = isTextEmpty ? placeholder : text
        let textColor = isTextEmpty ? UIColor(resource: .gray300) : UIColor(resource: .drBlack)
        
        textView.text = textToDisplay
        textView.setFontAndLineLetterSpacing(textView.text,
            font:UIFont.systemFont(ofSize: 13, weight: .semibold))
        textView.textColor = textColor
    }
    
}
