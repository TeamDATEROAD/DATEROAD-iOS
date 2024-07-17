//
//  AddScheduleFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleFirstView: BaseView {
   
   // MARK: - UI Properties
   
   let addScheduleInFirstView = AddScheduleInFirstView()
   
   let dateNameErrorLabel = UILabel()
   
   let visitDateErrorLabel = UILabel()
   
   private let warningType: DRErrorType = Warning()
   
   override func setHierarchy() {
      self.addSubviews(
         addScheduleInFirstView,
         dateNameErrorLabel,
         visitDateErrorLabel
      )
   }
   
   override func setLayout() {
      addScheduleInFirstView.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
      
      dateNameErrorLabel.snp.makeConstraints {
         $0.top.equalTo(addScheduleInFirstView.dateNameTextField.snp.bottom).offset(2)
         $0.leading.equalTo(addScheduleInFirstView.dateNameTextField).offset(9)
      }
      
      visitDateErrorLabel.snp.makeConstraints {
         $0.top.equalTo(addScheduleInFirstView.visitDateContainer.snp.bottom).offset(2)
         $0.leading.equalTo(addScheduleInFirstView.visitDateContainer.snp.leading).offset(9)
      }
   }
   
   override func setStyle() {
//      scrollView.do {
//         $0.showsVerticalScrollIndicator = false
//         $0.contentInsetAdjustmentBehavior = .always
//      }
//      
//      collectionView.do {
//         let layout = UICollectionViewFlowLayout()
//         layout.scrollDirection = .horizontal
//         layout.minimumInteritemSpacing = 12.0
//         $0.collectionViewLayout =  layout
//         $0.showsHorizontalScrollIndicator = false
//         $0.showsVerticalScrollIndicator = false
//         $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
//         $0.clipsToBounds = true
//         $0.isUserInteractionEnabled = true
//      }
//      
//      cameraBtn.do {
//         $0.setImage(.camera, for: .normal)
//         $0.backgroundColor = .gray200
//         $0.layer.cornerRadius = 32 / 2
//         $0.isUserInteractionEnabled = true
//      }
//      
//      imageCountLabelContainer.do {
//         $0.backgroundColor = .gray400
//         $0.layer.cornerRadius = 10
//      }
//      
//      imageCountLabel.do {
//         $0.setLabel(textColor: UIColor(resource: .drWhite), font: .suit(.body_med_10))
//         $0.text = "1/10"
//      }
      
      for i in [dateNameErrorLabel,visitDateErrorLabel] {
         i.do {
            if i == dateNameErrorLabel {
               $0.setErrorLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNameErrorLabel, errorType: warningType)
            } else {
               $0.setErrorLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateErrorLabel, errorType: warningType)
            }
            $0.isHidden = true
         }
      }
   }
   
}

extension AddScheduleFirstView {
   
   // MARK: - Methods
   
   func updateDateNameTextField(isPassValid: Bool) {
      dateNameErrorLabel.isHidden = isPassValid
      addScheduleInFirstView.dateNameTextField.do {
         $0.layer.borderWidth = isPassValid ? 0 : 1
      }
   }
   
   func updateVisitDateTextField(isPassValid: Bool) {
      visitDateErrorLabel.isHidden = isPassValid
      addScheduleInFirstView.visitDateContainer.do {
         $0.layer.borderWidth = isPassValid ? 0 : 1
      }
   }
   
//   func updateImageCellUI(isEmpty: Bool, ImageDataCount: Int) {
//      cameraBtn.isHidden = isEmpty
//      imageCountLabel.text = "\(ImageDataCount)/10"
//   }
   
}
