//
//  AddSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class AddSecondView: BaseView {
   
   // MARK: - UI Properties
   
   private let container: UIView = UIView()
   
   private let contentTitleLabel: UILabel = UILabel()
   
   private let contentSubTitleLabel: UILabel = UILabel()
   
   private let placeRegistrationContainer: UIView = UIView()
   
   let datePlaceTextField: UITextField = UITextField()
   
   let timeRequireTextField: UITextField = UITextField()
   
   let addPlaceButton: UIButton = UIButton()
   
   let separatorLine: UIView = UIView()
   
   let nextBtn: UIButton = UIButton()
   
   
   // MARK: - Properties
   
   private let enabledButtonType: DRButtonType = EnabledButton()
   
   private let disabledButtonType: DRButtonType = DisabledButton()
   
   private let addCourseDisabledButtonType: DRButtonType = addCoursePlaceDisabledButton()
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      addSubviews (
         container,
         contentTitleLabel,
         contentSubTitleLabel,
         placeRegistrationContainer,
         separatorLine,
         nextBtn
      )
      
      placeRegistrationContainer.addSubviews(
         datePlaceTextField,
         timeRequireTextField,
         addPlaceButton
      )
   }
   
   override func setLayout() {
      contentTitleLabel.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview()
      }
      
      contentSubTitleLabel.snp.makeConstraints {
         $0.top.equalTo(contentTitleLabel.snp.bottom).offset(2)
         $0.horizontalEdges.equalToSuperview()
      }
      
      placeRegistrationContainer.snp.makeConstraints {
         $0.top.equalTo(contentSubTitleLabel.snp.bottom).offset(16)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(44)
      }
      
      datePlaceTextField.snp.makeConstraints {
         $0.top.leading.bottom.equalToSuperview()
         $0.width.equalTo(206)
      }
      
      timeRequireTextField.snp.makeConstraints {
         $0.top.bottom.equalToSuperview()
         $0.leading.equalTo(datePlaceTextField.snp.trailing).offset(8)
         $0.width.equalTo(77)
      }
      
      addPlaceButton.snp.makeConstraints {
         $0.trailing.equalToSuperview()
         $0.centerY.equalToSuperview()
         $0.size.equalTo(44)
      }
      
      separatorLine.snp.makeConstraints {
         $0.top.equalTo(placeRegistrationContainer.snp.bottom).offset(21)
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(1)
      }
      
      nextBtn.snp.makeConstraints {
         $0.bottom.equalToSuperview()
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
         $0.text = StringLiterals.AddCourseOrSchedul.AddSecondView.contentTitleLabelOfCourse
      }
      
      contentSubTitleLabel.do {
         $0.setLabel(
            alignment: .left,
            textColor: UIColor(resource: .gray400),
            font: .suit(.body_med_13)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddSecondView.subTitleLabel
      }
      
      datePlaceTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrSchedul.AddSecondView.datePlacePlaceHolder,
            fontColor: UIColor(resource: .gray300),
            font: .suit(.body_semi_13)
         )
         $0.setLeftPadding(amount: 14)
         $0.textAlignment = .left
         $0.backgroundColor = UIColor(resource: .gray100)
         $0.layer.borderWidth = 0
         $0.layer.cornerRadius = 14
         $0.autocorrectionType = .no
         $0.spellCheckingType = .no
      }
      
      timeRequireTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrSchedul.AddSecondView.timeRequiredPlaceHolder,
            fontColor: UIColor(resource: .gray300),
            font: .suit(.body_semi_13)
         )
         $0.textAlignment = .center
         $0.backgroundColor = UIColor(resource: .gray100)
         $0.layer.borderWidth = 0
         $0.layer.cornerRadius = 14
         $0.autocorrectionType = .no
         $0.spellCheckingType = .no
      }
      
      addPlaceButton.do {
         $0.setImage(UIImage(resource: .icAddcourseWhite), for: .normal)
         $0.setImage(UIImage(resource: .icAddcourseGray), for: .disabled)
         $0.imageView?.snp.makeConstraints {
            $0.size.equalTo(14)
         }
         $0.setButtonStatus(buttonType: addCourseDisabledButtonType)
      }
      
      separatorLine.do {
         $0.backgroundColor = UIColor(resource: .gray200)
      }
      
      nextBtn.do {
         $0.setButtonStatus(buttonType: disabledButtonType)
         $0.setTitle(StringLiterals.AddCourseOrSchedul.AddSecondView.addSecondNextBtnOfCourse, for: .normal)
      }
   }
   
}


// MARK: - View Methods

extension AddSecondView {
   
   func changeAddPlaceButtonState(flag: Bool) {
      let state = flag ? enabledButtonType : addCourseDisabledButtonType
      addPlaceButton.setButtonStatus(buttonType: state)
   }
   
   /// 장소 등록 마치면 실행되는 함수
   func finishAddPlace() {
      // textfield 값 초기화 및 장소 등록 버튼 비활성화
      datePlaceTextField.text = ""
      timeRequireTextField.text = ""
      addPlaceButton.setButtonStatus(buttonType: addCourseDisabledButtonType)
   }
   
   func changeNextBtnState(flag: Bool) {
      let state = flag ? enabledButtonType : disabledButtonType
      nextBtn.setButtonStatus(buttonType: state)
   }
   
}