//
//  AddSheetView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/6/24.
//

import UIKit

import SnapKit
import Then

final class AddSheetView: BaseView {
   
   // MARK: - UI Properties
   
   private let blurView = UIView()
   
   private let bottomSheetView = UIView()
   
   let datePicker = UIDatePicker()
   
   let customPickerView = UIPickerView()
   
   let doneBtn = UIButton()
   
   private let doneBtnTitleLabel = UILabel()
   
   
   // MARK: - Properties
   
   var isCustomPicker: Bool
   
   
   // MARK: - Initializer
   
   init(isCustomPicker: Bool) {
      self.isCustomPicker = isCustomPicker
      
      super.init(frame: .zero)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      switch isCustomPicker {
         
      case true:
         addSubviews(bottomSheetView)
         bottomSheetView.addSubviews(doneBtn, customPickerView)
         doneBtn.addSubview(doneBtnTitleLabel)
      case false:
         self.addSubviews(datePicker)
         
      }
      
   }
   
   override func setLayout() {
      switch isCustomPicker {
         
      case true:
         bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(304)
         }
         
         customPickerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(14)
            $0.height.equalTo(180)
         }
         
         doneBtn.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(54)
         }
         
         doneBtnTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
         }
         
      case false:
         datePicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
         }
         
      }
   }
   
   override func setStyle() {
      switch isCustomPicker {
         
      case true:
         bottomSheetView.do {
            $0.backgroundColor = .drWhite
            $0.layer.cornerRadius = 14
         }
         doneBtn.do {
            $0.backgroundColor = .deepPurple
            $0.layer.cornerRadius = 14
         }
         doneBtnTitleLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: .suit(.body_bold_15))
            $0.text = "선택하기"
         }
         
      case false:
         datePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.locale = Locale(identifier: "ko-KR")
            $0.isHidden = isCustomPicker  // 초기 설정에 따라 숨김
         }
      }
      
   }
   
}


// MARK: - View Methods

extension AddSheetView {
   
   func isCustomPicker(flag: Bool) {
      datePicker.isHidden = flag
      customPickerView.isHidden = !flag
   }
   
   func datePickerMode(isDatePicker: Bool) {
      if isDatePicker {
         datePicker.datePickerMode = .date
      } else {
         datePicker.datePickerMode = .time
      }
   }
   
}
