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
   
   private let tagStringArr = [
      ["🚙 드라이브", "🛍️ 쇼핑", "🚪 실내", "🍵 힐링"],
      ["🥂 알콜", "🍜 식도락", "💍 공방", "🌊 자연"],
      ["🛼️ 액티비티", "🎭 공연·음악", "🎨 전시·팝업"]
   ]
   
   private let textFieldStackView = UIStackView()
   
   let dateNameTextField = UITextField()
   
   let visitDateTextField = UITextField()
   
   let dateStartTimeTextField = UITextField()
   
   private let tagContainer = UIView()
   
   private let tagTitleLabel = UILabel()
   
   private let tagVStackView = UIStackView()
   
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
         dateNameTextField,
         visitDateTextField,
         dateStartTimeTextField
      )
      
      tagContainer.addSubviews(tagTitleLabel, tagVStackView)
      
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
      
      tagTitleLabel.snp.makeConstraints {
         $0.top.leading.trailing.equalToSuperview()
      }
      
      tagVStackView.snp.makeConstraints {
         $0.top.equalTo(tagTitleLabel.snp.bottom).offset(12)
         $0.horizontalEdges.bottom.equalToSuperview()
      }
      
      datePlaceContainer.snp.makeConstraints {
         $0.top.equalTo(tagContainer.snp.bottom).offset(28)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(48)
      }
      
      datePlaceLabel.snp.makeConstraints {
         $0.leading.trailing.equalToSuperview().inset(16)
         $0.centerY.equalToSuperview()
      }
      
      datePlaceImage.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.trailing.equalToSuperview().inset(18)
         $0.width.equalTo(10)
         $0.height.equalTo(5)
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
      
      [dateNameTextField, visitDateTextField, dateStartTimeTextField].forEach { textField in
         textField.do {
            $0.textColor = .drBlack
            $0.backgroundColor = .gray100
            $0.setLeftPadding(amount: 16)
            $0.layer.cornerRadius = 13
         }
      }
      
      dateNameTextField.setPlaceholder(placeholder: StringLiterals.AddCourseOrScheduleFirst.dateNmaePlaceHolder, fontColor: .gray300, font: .suit(.body_semi_13))
      
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
      
      tagTitleLabel.do {
         $0.font = .suit(.body_semi_15)
         $0.text = StringLiterals.AddCourseOrScheduleFirst.tagTitle
      }
      
      tagVStackView.do {
         $0.axis = .vertical
         $0.spacing = 8
         $0.distribution = .fillEqually
      }
      
      for i in 0..<3 {
         let hStackView = createHorizontalStackView(i)
         tagVStackView.addArrangedSubview(hStackView)
      }
      
      datePlaceContainer.do {
         $0.backgroundColor = .gray100
         $0.layer.cornerRadius = 13
      }
      
      datePlaceLabel.do {
         $0.font = .suit(.body_semi_13)
         $0.text = StringLiterals.AddCourseOrScheduleFirst.dateLocationPlaceHolder
         $0.textColor = .gray300
      }
      
      datePlaceImage.do {
         $0.image = UIImage(resource: .downArrow)
      }
      
      nextBtn.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor.brown.cgColor
      }
   }
   
}

extension AddFirstView {
   /// HStackView 생성 함수
   func createHorizontalStackView(_ cnt: Int) -> UIStackView {
      let hStackView = UIStackView().then {
         $0.axis = .horizontal
         $0.spacing = 7
         $0.alignment = .leading
         $0.distribution = .fillProportionally
      }
      
      for i in 0..<tagStringArr[cnt].count {
         let button = createOvalButton(title: tagStringArr[cnt][i])
         hStackView.addArrangedSubview(button)
      }
      
      // 각 버튼 열에 맞는 PaddingView 추가
      if cnt == 0 {
         let paddingView = UIView()
         paddingView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(0)
         }
         hStackView.addArrangedSubview(paddingView)
      } else if cnt == 1 {
         let paddingView = UIView()
         paddingView.snp.makeConstraints {
            $0.width.equalTo(35)
            $0.height.equalTo(0)
         }
         hStackView.addArrangedSubview(paddingView)
      } else {
         let paddingView = UIView()
         paddingView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(0)
         }
         hStackView.addArrangedSubview(paddingView)
      }
      
      return hStackView
   }
   
   /// HStackView에 들어갈 버튼 생성 함수
   func createOvalButton(title: String) -> UIButton {
      var config = UIButton.Configuration.gray()
      var titleAttr = AttributedString.init(title)
      titleAttr.font = .suit(.cap_reg_11)
      titleAttr.foregroundColor = .drBlack
      config.attributedTitle = titleAttr
      config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
      config.baseBackgroundColor = .gray100
      
      let btn = UIButton(configuration: config)
      btn.roundedButton(cornerRadius: 12, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
      
      return btn
   }
}
