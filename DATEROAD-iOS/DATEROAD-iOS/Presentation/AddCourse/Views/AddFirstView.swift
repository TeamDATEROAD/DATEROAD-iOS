//
//  AddFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

///AddFirstView load 시 각 inset 값들 top: 14, horizontalEdges: 16, bottom: 4[safelayoutguide 기준] )
class AddFirstView: BaseView {
   
   private let textFieldStackView = UIStackView()
   
   let dateNmaeTextField = UITextField()
   
   let visitDateTextField = UITextField()
   
   let dateStartTimeTextField = UITextField()
   
   private let tagContainer = UIView()
   
   private let tagTitleLabel = UILabel()
   
   private let tagStackView = UIStackView()
   
   let datePlaceContainer = UIView()
   
   private let datePlaceLabel = UILabel()
   
   private let datePlaceImage = UIImageView()
   
   let nextBtn = UIButton() //추후 Captin 버튼으로 수정 예정
   
   override func setHierarchy() {
      self.addSubviews(
         textFieldStackView,
         tagContainer,
         datePlaceContainer,
         nextBtn
      )
      
      textFieldStackView.addArrangedSubviews(
         dateNmaeTextField,
         visitDateTextField,
         dateStartTimeTextField
      )
      
      tagContainer.addSubviews(tagTitleLabel, tagStackView)
      
      datePlaceContainer.addSubviews(datePlaceLabel, datePlaceImage)
   }
   
   override func setLayout() {
      textFieldStackView.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview()
         $0.height.equalTo(184)
      }
      
      tagContainer.snp.makeConstraints {
         $0.top.equalTo(textFieldStackView.snp.bottom).offset(24)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(140)
      }
      
      datePlaceContainer.snp.makeConstraints {
         $0.top.equalTo(tagContainer.snp.bottom).offset(28)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(48)
      }
      
      nextBtn.snp.makeConstraints {
         $0.bottom.horizontalEdges.equalToSuperview()
         $0.height.equalTo(54)
      }
   }
   
   override func setStyle() {
      textFieldStackView.do {
         $0.axis = .vertical
         $0.spacing = 20
         $0.distribution = .fillEqually
      }
      
      [dateNmaeTextField, visitDateTextField, dateStartTimeTextField].forEach { textField in
         textField.do {
            $0.font = UIFont.suit(.body_semi_13)
            $0.textColor = .drBlack
            $0.backgroundColor = .gray100
            $0.setLeftPadding(amount: 16)
            $0.layer.cornerRadius = 13
         }
      }
      
      dateNmaeTextField.placeholder = StringLiterals.AddCourseOrScheduleFirst.dateNmaePlaceHolder
      
      visitDateTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrScheduleFirst.visitDatePlaceHolder,
            fontColor: .gray300,
            font: .suit(.body_semi_13)
         )
         let view = UIView()
         let imageView = UIImageView(image: .calendar)
         $0.rightView = view
         $0.rightViewMode = .always
         view.addSubview(imageView)
         imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(15)
            $0.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(19)
         }
      }
      
      dateStartTimeTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrScheduleFirst.dateStartTimePlaceHolder,
            fontColor: .gray300,
            font: .suit(.body_semi_13)
         )
         let view = UIView()
         let imageView = UIImageView(image: .time)
         $0.rightView = view
         $0.rightViewMode = .always
         view.addSubview(imageView)
         imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(17)
            $0.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(18)
         }
      }
      
      tagContainer.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor.red.cgColor
      }
      
      datePlaceContainer.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor.blue.cgColor
      }
      
      nextBtn.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor.brown.cgColor
      }
   }
   
}
