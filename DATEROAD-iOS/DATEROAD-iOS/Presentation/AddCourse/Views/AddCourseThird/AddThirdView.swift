//
//  AddThirdView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class AddThirdView: BaseView {
   
   // MARK: - UI Properties
   
   private let container: UIView = UIView()
   
   private let contentTitleLabel: UILabel = UILabel()
   
   let contentTextView: UITextView = UITextView()
   
   let contentTextCountLabel: UILabel = UILabel()
   
   private let priceTitleLabel: UILabel = UILabel()
   
   var priceTextField: UITextField = UITextField()
   
   let addThirdDoneBtn: UIButton = UIButton()
   
   
   // MARK: - Properties
   
   let textViewPlaceHolder = StringLiterals.AddCourseOrSchedul.AddThirdView.contentTextFieldPlaceHolder
   
   private let enabledButtonType: DRButtonType = EnabledButton()
   
   private let disabledButtonType: DRButtonType = DisabledButton()
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      addSubviews (
         container
      )
      container.addSubviews(
         contentTitleLabel,
         contentTextView,
         contentTextCountLabel,
         priceTitleLabel,
         priceTextField,
         addThirdDoneBtn
      )
   }
   
   override func setLayout() {
      container.snp.makeConstraints {
         $0.top.bottom.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
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
      
      addThirdDoneBtn.snp.makeConstraints {
         $0.top.equalTo(priceTextField.snp.bottom).offset(50)
         $0.bottom.equalToSuperview().inset(4)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(54)
      }
   }
   
   override func setStyle() {
      contentTitleLabel.do {
         $0.setLabel(
            alignment: .left,
            textColor: UIColor(resource: .drBlack),
            font: .suit(.body_bold_17)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddThirdView.contentTitleLabel
      }
      
      [contentTextView, priceTextField].forEach {
         $0.layer.borderWidth = 0
         $0.layer.cornerRadius = 14
         $0.backgroundColor = UIColor(resource: .gray100)
      }
      
      contentTextView.do {
         $0.text = textViewPlaceHolder
         $0.font = .suit(.body_med_13)
         $0.textColor = UIColor(resource: .gray300)
         $0.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
         $0.isScrollEnabled = true
         $0.textAlignment = .left
         $0.showsVerticalScrollIndicator = false
      }
      
      priceTextField.do {
         $0.setLeftPadding(amount: 16)
         $0.setRightPadding(amount: 16)
         $0.keyboardType = .numberPad
         $0.font = .suit(.body_med_13)
         $0.textColor = UIColor(resource: .drBlack)
      }
      
      priceTextField.setPlaceholder(placeholder: StringLiterals.AddCourseOrSchedul.AddThirdView.priceTextFieldPlaceHolder, fontColor: UIColor(resource: .gray300), font: .suit(.body_med_13))
      
      contentTextCountLabel.do {
         $0.setLabel(
            alignment: .right,
            textColor: UIColor(resource: .gray300),
            font: .suit(.body_med_13)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddThirdView.contentTextCountLabel
      }
      
      priceTitleLabel.do {
         $0.setLabel(
            alignment: .left,
            textColor: UIColor(resource: .drBlack),
            font: .suit(.body_bold_17)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddThirdView.priceTitleLabel
      }
      
      addThirdDoneBtn.do {
         $0.setButtonStatus(buttonType: disabledButtonType)
         $0.layer.borderWidth = 0
         $0.setTitle(StringLiterals.AddCourseOrSchedul.AddThirdView.addThirdDoneBtn, for: .normal)
         $0.titleLabel?.font = .suit(.body_bold_15)
         $0.layer.cornerRadius = 14
      }
   }
   
}


extension AddThirdView {
   
   func updateContentTextCount(textCnt: Int) {
      contentTextCountLabel.text = "\(textCnt)자 / 200자 이상"
   }
   
   func updateAddThirdDoneBtn(isValid: Bool) {
      print("현재 updateAddThirdDoneBtn \(isValid)")
      let state = isValid ? enabledButtonType : disabledButtonType
      addThirdDoneBtn.setButtonStatus(buttonType: state)
   }
   
   func updatePriceText(price: Int) {
      if price == 0 {
      } else {
         priceTextField.text = String(price.formattedWithSeparator)
      }
   }
   
}
