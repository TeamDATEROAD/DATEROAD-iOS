//
//  AddFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class AddFirstView: BaseView {
   
   // MARK: - UI Properties
   
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
   
   private let nextBtnTitleLabel = UILabel()
   
   lazy var dateAccessoryView = UIView()
   
   // MARK: - Properties
   
   private let tagStringArr = [
      ["🚙 드라이브", "🛍️ 쇼핑", "🚪 실내", "🍵 힐링"],
      ["🥂 알콜", "🍜 식도락", "💍 공방", "🌊 자연"],
      ["🛼️ 액티비티", "🎭 공연·음악", "🎨 전시·팝업"]
   ]
   
   var tagBtns: [UIButton] = []
   
   // MARK: - Life Cycle
   
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
      
      nextBtn.addSubview(nextBtnTitleLabel)
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
      
      nextBtnTitleLabel.snp.makeConstraints {
         $0.center.equalToSuperview()
      }
      
      dateAccessoryView.snp.makeConstraints {
         $0.width.equalTo(375)
         $0.height.equalTo(304)
      }
      
   }
   
   override func setStyle() {
      dateAccessoryView.do {
         $0.backgroundColor = .drWhite
         $0.layer.cornerRadius = 30
         $0.clipsToBounds = true
      }
      
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
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
         }
      }
      
      dateNameTextField.setPlaceholder(placeholder: StringLiterals.AddCourseOrScheduleFirst.dateNmaePlaceHolder, fontColor: .gray300, font: .suit(.body_semi_13))
      
      visitDateTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrScheduleFirst.visitDateLabel,
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
         $0.inputView = dateAccessoryView
         
      }
      
      dateStartTimeTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrScheduleFirst.dateStartTimeLabel,
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
         $0.layer.cornerRadius = 14
      }
      
      datePlaceLabel.do {
         $0.font = .suit(.body_semi_13)
         $0.text = StringLiterals.AddCourseOrScheduleFirst.datePlaceLabel
         $0.textColor = .gray300
      }
      
      datePlaceImage.do {
         $0.image = UIImage(resource: .downArrow)
      }
      
      nextBtn.do {
         $0.backgroundColor = .gray200
         $0.layer.cornerRadius = 14
      }
      
      nextBtnTitleLabel.do {
         $0.font = .suit(.body_bold_15)
         $0.text = "다음 (1/3)"
         $0.textColor = .gray400
      }
   }
   
}

extension AddFirstView {
   
   // MARK: - Methods
   
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
         tagBtns.append(button)
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
      titleAttr.font = .suit(.body_med_13)
      
      config.attributedTitle = titleAttr
      config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
      config.baseBackgroundColor = .gray100
      config.baseForegroundColor = .drBlack
      
      let btn = UIButton(configuration: config)
      btn.roundedButton(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
      return btn
   }
   
   func updateTagButtonStyle(btn: UIButton) {
      btn.do {
         $0.configuration?.baseBackgroundColor = .deepPurple
         $0.configuration?.baseForegroundColor = .drWhite
      }
   }
   
}
