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
   
   let doneBtn = UIButton() // 추후 Captin 버튼으로 수정 예정
   
   private let doneBtnTitleLabel = UILabel()
   
   
   // MARK: - Properties
   
   var isCustomPicker: Bool = false
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      addSubviews(bottomSheetView)
      bottomSheetView.addSubviews(datePicker, doneBtn, customPickerView)
      doneBtn.addSubview(doneBtnTitleLabel)
   }
   
   override func setLayout() {
      bottomSheetView.snp.makeConstraints {
         $0.horizontalEdges.bottom.equalToSuperview()
         $0.height.equalTo(304)
      }
      
      datePicker.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview().inset(14)
         $0.height.equalTo(180)
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
   }
   
   override func setStyle() {
      bottomSheetView.do {
         $0.backgroundColor = .drWhite
         $0.layer.cornerRadius = 14
      }
      
      datePicker.do {
         $0.datePickerMode = .date
         $0.preferredDatePickerStyle = .wheels
         $0.locale = Locale(identifier: "ko-KR")
      }
      
      doneBtn.do {
         $0.backgroundColor = .deepPurple
         $0.layer.cornerRadius = 14
      }
      
      doneBtnTitleLabel.do {
         $0.setLabel(textColor: UIColor(resource: .drWhite), font: .suit(.body_bold_15))
         $0.text = "선택하기"
      }
   }
   
}


// MARK: - View Methods

extension AddSheetView {
   func isCustomPicker(flag: Bool) {
      datePicker.isHidden = flag
      customPickerView.isHidden = !flag
   }
}
