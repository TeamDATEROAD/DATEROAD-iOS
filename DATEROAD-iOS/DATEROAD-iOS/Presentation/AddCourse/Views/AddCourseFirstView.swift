//
//  AddCourseFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseFirstView: BaseView {
   
   // MARK: - UI Properties
   
   lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addFirstView = AddFirstView()
   
   private let imageAccessoryView = UIView()
   
   let cameraBtn = UIButton()
   
   private let imageCountLabelContainer = UIView()
   
   let imageCountLabel = UILabel()
   
   let dateNameErrorLabel = UILabel()
   
   let visitDateErrorLabel = UILabel()
   
   override func setHierarchy() {
      self.addSubviews(
         collectionView,
         imageAccessoryView,
         addFirstView,
         dateNameErrorLabel,
         visitDateErrorLabel
      )
      imageAccessoryView.addSubviews(cameraBtn, imageCountLabelContainer)
      imageCountLabelContainer.addSubview(imageCountLabel)
   }
   
   override func setLayout() {
      collectionView.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(146)
      }
      
      imageAccessoryView.snp.makeConstraints {
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalTo(collectionView)
         $0.height.equalTo(32)
      }
      
      cameraBtn.snp.makeConstraints {
         $0.top.bottom.leading.equalToSuperview()
         $0.size.equalTo(32)
      }
      
      imageCountLabelContainer.snp.makeConstraints {
         $0.centerY.equalTo(cameraBtn)
         $0.trailing.equalToSuperview()
         $0.width.equalTo(40)
         $0.height.equalTo(20)
      }
      
      imageCountLabel.snp.makeConstraints {
         $0.center.equalToSuperview()
      }
      
      addFirstView.snp.makeConstraints {
         $0.top.equalTo(collectionView.snp.bottom).offset(14)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalToSuperview()
      }
      
      dateNameErrorLabel.snp.makeConstraints {
         $0.top.equalTo(addFirstView.dateNameTextField.snp.bottom).offset(2)
         $0.leading.equalTo(addFirstView.dateNameTextField).offset(9)
      }
      
      visitDateErrorLabel.snp.makeConstraints {
         $0.top.equalTo(addFirstView.visitDateTextField.snp.bottom).offset(2)
         $0.leading.equalTo(addFirstView.visitDateTextField.snp.leading).offset(9)
      }
   }
   
   override func setStyle() {
      collectionView.do {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumInteritemSpacing = 12.0
         layout.itemSize = CGSize(width: 130, height: 130)
         $0.collectionViewLayout =  layout
         $0.isScrollEnabled = true
         $0.showsHorizontalScrollIndicator = false
         $0.showsVerticalScrollIndicator = false
         $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
         $0.clipsToBounds = true
      }
      
      cameraBtn.do {
         $0.setImage(.camera, for: .normal)
         $0.backgroundColor = .gray200
         $0.layer.cornerRadius = 32 / 2
         $0.isUserInteractionEnabled = true
      }
      
      imageCountLabelContainer.do {
         $0.backgroundColor = .gray400
         $0.layer.cornerRadius = 10
      }
      
      imageCountLabel.do {
         $0.text = "1/10"
         $0.font = .suit(.body_med_10)
         $0.textColor = .drWhite
      }
      
      for i in [dateNameErrorLabel,visitDateErrorLabel] {
         i.do {
            if i == dateNameErrorLabel {
               $0.text = StringLiterals.AddCourseOrScheduleFirst.dateNameErrorLabel
            } else {
               $0.text = StringLiterals.AddCourseOrScheduleFirst.visitDateErrorLabel
            }
            $0.font = .suit(.cap_reg_11)
            $0.textColor = .alertRed
            $0.isHidden = true
         }
      }
   }
   
}

extension AddCourseFirstView {
   
   // MARK: - Methods
   
   func updateVisitDateTextField(isPassValid: Bool) {
      if isPassValid {
         visitDateErrorLabel.isHidden = true
         addFirstView.visitDateTextField.do {
            $0.layer.borderWidth = 0
         }
      } else {
         visitDateErrorLabel.isHidden = false
         addFirstView.visitDateTextField.do {
            $0.layer.borderWidth = 1
         }
      }
   }
   
   func updateDateNameTextField(isPassValid: Bool) {
      if isPassValid {
         dateNameErrorLabel.isHidden = true
         addFirstView.dateNameTextField.do {
            $0.layer.borderWidth = 0
         }
      } else {
         dateNameErrorLabel.isHidden = false
         addFirstView.dateNameTextField.do {
            $0.layer.borderColor = UIColor.alertRed.cgColor
            $0.layer.borderWidth = 1
         }
      }
   }
   
}
