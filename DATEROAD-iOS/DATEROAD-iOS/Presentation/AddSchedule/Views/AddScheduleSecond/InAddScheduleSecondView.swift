//
//  InAddScheduleSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class InAddScheduleSecondView: BaseView {
   
   // MARK: - UI Properties
      
   private let contentTitleLabel: UILabel = UILabel()
   
   private let contentSubTitleLabel: UILabel = UILabel()
   
   private let placeRegistrationContainer: UIView = UIView()
   
   let datePlaceTextField: UITextField = UITextField()
   
   let timeRequireTextField: UITextField = UITextField()
   
   let addPlaceButton: UIButton = UIButton()
   
   let separatorLine: UIView = UIView()
      
   
   // MARK: - Properties
   
   private let enabledButtonType: DRButtonType = EnabledButton()
   
   private let disabledButtonType: DRButtonType = DisabledButton()
   
   private let addCourseDisabledButtonType: DRButtonType = addCoursePlaceDisabledButton()
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      self.addSubviews (
         contentTitleLabel,
         contentSubTitleLabel,
         placeRegistrationContainer,
         separatorLine
      )
      
      placeRegistrationContainer.addSubviews(
         datePlaceTextField,
         timeRequireTextField,
         addPlaceButton
      )
   }
   
   override func setLayout() {
      contentTitleLabel.snp.makeConstraints {
         $0.top.equalToSuperview().inset(27)
         $0.horizontalEdges.equalToSuperview()
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
         $0.verticalEdges.leading.equalToSuperview()
         $0.leading.equalToSuperview()
         $0.width.equalTo(ScreenUtils.width / 375 * 206)
      }
      
      addPlaceButton.snp.makeConstraints {
         $0.trailing.equalToSuperview()
         $0.verticalEdges.equalToSuperview()
         $0.width.equalTo(ScreenUtils.width / 375 * 44)
      }
      
      timeRequireTextField.snp.makeConstraints {
         $0.verticalEdges.equalToSuperview()
         $0.leading.equalTo(datePlaceTextField.snp.trailing).offset(ScreenUtils.width / 375 * 8).priority(.low)
         $0.trailing.equalTo(addPlaceButton.snp.leading).offset(ScreenUtils.width / 375 * -8).priority(.low)
      }
      
      separatorLine.snp.makeConstraints {
         $0.bottom.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(1)
      }
   }
   
   override func setStyle() {
      contentTitleLabel.do {
         $0.setLabel(
            text: StringLiterals.AddCourseOrSchedule.AddSecondView.contentTitleLabelOfCourse,
            alignment: .left,
            textColor: UIColor(resource: .drBlack),
            font: .suit(.body_bold_17)
         )
      }
      
      contentSubTitleLabel.do {
         $0.setLabel(
            text: StringLiterals.AddCourseOrSchedule.AddSecondView.subTitleLabel,
            alignment: .left,
            textColor: UIColor(resource: .gray400),
            font: .suit(.body_med_13)
         )
      }
      
      datePlaceTextField.do {
         $0.setPlaceholder(
            placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.datePlacePlaceHolder,
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
            placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder,
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
         $0.setButtonStatus(buttonType: addCourseDisabledButtonType)
         $0.imageView?.snp.makeConstraints {
            $0.size.equalTo(14)
         }
      }
      
      separatorLine.do {
         $0.backgroundColor = UIColor(resource: .gray200)
      }
   }
   
}


// MARK: - View Methods

extension InAddScheduleSecondView {
   
   func updateDatePlace(text: String) {
      datePlaceTextField.text = text
      datePlaceTextField.font = UIFont.suit(.body_semi_13)
   }
   
   func updatetimeRequire(text: String) {
      timeRequireTextField.text = text
      timeRequireTextField.font = UIFont.suit(.body_semi_13)
   }
   
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
   
//   func changeNextBtnState(flag: Bool) {
//      let state = flag ? enabledButtonType : disabledButtonType
//      nextBtn.setButtonStatus(buttonType: state)
//   }
   
}

