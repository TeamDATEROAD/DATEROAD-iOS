//
//  AddSecondViewTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/10/24.
//

import UIKit

import SnapKit
import Then

class AddSecondViewCollectionViewCell: BaseCollectionViewCell {
   
   private let placeTitleLabel: UILabel = UILabel()
   
   private let timeRequireContainer: UIView = UIView()
   
   private let timeRequireLabel: UILabel = UILabel()
   
   let moveAbleButton: UIButton = UIButton()
   
   private var isEditMode: Bool = false
   
   //   override func layoutSubviews() {
   //      super.layoutSubviews()
   //
   //      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 0))
   //   }
   
   override func setHierarchy() {
      self.addSubview(contentView)
      
      contentView.addSubviews(
         placeTitleLabel,
         timeRequireContainer,
         moveAbleButton
      )
      timeRequireContainer.addSubview(timeRequireLabel)
   }
   
   override func setLayout() {
      placeTitleLabel.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview().offset(17)
         $0.width.equalTo(198)
      }
      
      timeRequireContainer.snp.makeConstraints {
         $0.leading.equalTo(placeTitleLabel.snp.trailing).offset(20)
         $0.verticalEdges.equalToSuperview().inset(13)
         $0.width.equalTo(59)
      }
      
      timeRequireLabel.snp.makeConstraints {
         $0.center.equalToSuperview()
      }
      
      moveAbleButton.snp.makeConstraints {
         $0.trailing.equalToSuperview().inset(3)
         $0.size.equalTo(44)
         $0.centerY.equalToSuperview()
      }
   }
   
   override func setStyle() {
      contentView.do {
         $0.backgroundColor = UIColor(resource: .gray100)
         $0.layer.cornerRadius = 14
      }
      
      placeTitleLabel.do {
         $0.setLabel(alignment: .left, textColor: UIColor(resource: .drBlack), font: .suit(.body_bold_15))
         $0.text = "test"
      }
      
      timeRequireContainer.do {
         $0.backgroundColor = UIColor(resource: .gray200)
         $0.layer.cornerRadius = 10
      }
      
      timeRequireLabel.do {
         $0.text = "test"
         $0.setLabel(textColor: UIColor(resource: .drBlack), font: .suit(.body_med_13))
      }
      
      moveAbleButton.do {
         $0.setImage(UIImage(resource: .icMovecourse), for: .normal)
      }
   }
   
}

extension AddSecondViewCollectionViewCell {
   
   func configure(model: AddCoursePlaceModel) {
      self.placeTitleLabel.text = model.placeTitle
      self.timeRequireLabel.text = model.timeRequire
      updateEditMode(flag: isEditMode)
   }
   
   func isEditMode(flag: Bool) {
//      print("현재 isEditMode의 flag : \(flag)")
      self.isEditMode = flag
      let image = flag ? UIImage(resource: .icDeletecourse) : UIImage(resource: .icMovecourse)
      
      moveAbleButton.setImage(image, for: .normal)
   }
   
   func updateEditMode(flag: Bool) {
//      print("현재 isEditMode의 flag : \(flag)")
      self.isEditMode = flag
      let image = flag ? UIImage(resource: .icDeletecourse) : UIImage(resource: .icMovecourse)
      
      moveAbleButton.setImage(image, for: .normal)
   }
   
}
