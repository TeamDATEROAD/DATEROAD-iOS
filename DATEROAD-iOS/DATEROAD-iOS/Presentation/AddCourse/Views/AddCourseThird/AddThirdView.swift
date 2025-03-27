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
    
    private let contentTitleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddThirdView.contentTitleLabel,
        textLabelType: .clear(.bold17_black),
        alignment: .left
    )
    
    let contentTextView: UITextView = UITextView()
    
    let contentTextCountLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddThirdView.contentTextCountLabel,
        textLabelType: .clear(.med13_gray300),
        alignment: .right
    )
    
    private let priceTitleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddThirdView.priceTitleLabel,
        textLabelType: .clear(.bold17_black),
        alignment: .left
    )
    
    let priceTextField: DRTextField = DRTextField(type: .addCourseSchedule(.totalPrice))
    
    private let addThirdDoneBtnContainer: UIView = UIView()
    
    
    // MARK: - Properties
    
    let textViewPlaceHolder = StringLiterals.AddCourseOrSchedule.AddThirdView.contentTextFieldPlaceHolder
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        addSubviews(container)
        
        container.addSubviews(contentTitleLabel,
                              contentTextView,
                              contentTextCountLabel,
                              priceTitleLabel,
                              priceTextField,
                              addThirdDoneBtnContainer)
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
        contentTextView.do {
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
    }
    
}

extension AddThirdView {
    
    func updateContentTextCount(textCnt: Int) {
        contentTextCountLabel.text = "\(textCnt)자 / 200자 이상"
    }
    
    func updatePriceText(price: Int) {
        priceTextField.text = price.formatted()
    }
    
    func updateContentTextView(_ textView: UITextView, withText text: String, placeholder: String) {
        let isTextEmpty = text.isEmpty
        let textToDisplay = isTextEmpty ? placeholder : text
        let textColor = isTextEmpty ? UIColor(resource: .gray300) : UIColor(resource: .drBlack)
        
        textView.text = textToDisplay
        textView.setFontAndLineLetterSpacing(textView.text, font:UIFont.systemFont(ofSize: 13, weight: .semibold))
        textView.textColor = textColor
    }
    
}
