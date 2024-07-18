//
//  AddCourseImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseImageCollectionViewCell: BaseCollectionViewCell {
   
   // MARK: - UI Properties
   
   private let imageView: UIImageView = UIImageView()
   
   let deleteImageBtn: UIButton = UIButton()
   
   private let emptyView: UIView = UIView()
   
   private let emptyCameraImage: UIImageView = UIImageView()
   
   private let emptyLabel: UILabel = UILabel()
   
   
   // MARK: - Prepare Methods
   
   override func prepareForReuse() {
      super.prepareForReuse()
      
      self.prepare(image: nil)
   }
   
   func prepare(image: UIImage?) {
      self.imageView.image = image
   }
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
       contentView.addSubviews(imageView, emptyView, deleteImageBtn)
       emptyView.addSubviews(emptyCameraImage, emptyLabel)
   }

   override func setLayout() {
       imageView.snp.makeConstraints {
           $0.edges.equalToSuperview()
       }

       deleteImageBtn.snp.makeConstraints {
           $0.size.equalTo(16)
           $0.top.trailing.equalToSuperview().inset(6)
       }

       emptyView.snp.makeConstraints {
           $0.edges.equalToSuperview()
       }

       emptyCameraImage.snp.makeConstraints {
           $0.top.equalToSuperview().offset(36)
           $0.centerX.equalToSuperview()
           $0.size.equalTo(32)
       }

       emptyLabel.snp.makeConstraints {
           $0.top.equalTo(emptyCameraImage.snp.bottom).offset(13)
           $0.centerX.equalTo(emptyCameraImage)
       }
   }

   override func setStyle() {
       imageView.do {
           $0.contentMode = .scaleAspectFill
           $0.clipsToBounds = true
           $0.layer.cornerRadius = 14
           $0.isHidden = true
       }

       deleteImageBtn.do {
           $0.clipsToBounds = true
           $0.layer.cornerRadius = 8
           $0.isHidden = true
           $0.setImage(UIImage(resource: .icDeletepic), for: .normal)
           $0.imageView?.contentMode = .scaleAspectFit
           $0.backgroundColor = UIColor(resource: .gray200)
//           $0.addTarget(self, action: #selector(didTapDelBtn), for: .touchUpInside)
       }

       emptyView.do {
           $0.backgroundColor = .gray100
           $0.layer.cornerRadius = 14
           $0.isHidden = false
       }

       emptyCameraImage.do {
           $0.image = .camera
           $0.backgroundColor = .gray200
           $0.layer.cornerRadius = 32 / 2
       }

       emptyLabel.do {
           $0.setLabel(
               numberOfLines: 2,
               textColor: UIColor(resource: .gray300),
               font: .suit(.body_bold_11)
           )
           $0.text = StringLiterals.AddCourseOrSchedule.AddFirstView.emptyImage
       }
   }

   
}


// MARK: - CollectionViewCell Methods

extension AddCourseImageCollectionViewCell {
   
   func configurePickedImage(pickedImage: UIImage) {
      imageView.image = pickedImage
   }
   
   func updateImageCellUI(isImageEmpty: Bool, vcCnt: Int) {
      emptyView.isHidden = !isImageEmpty
      imageView.isHidden = isImageEmpty
      if vcCnt > 1 {
         deleteImageBtn.isHidden = true
      } else {
         deleteImageBtn.isHidden = isImageEmpty
      }
   }
   
//   @objc
//   func didTapDelBtn() {
//      print("~~~~~~~~~~~~")
//   }
   
}
