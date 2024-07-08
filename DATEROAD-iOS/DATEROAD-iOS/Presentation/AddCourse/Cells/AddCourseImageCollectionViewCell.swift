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
   
   private let imageView = UIImageView()
   
   private let emptyView = UIView()
   
   private let emptyCameraImage = UIImageView()
   
   private let emptyLabel = UILabel()
   
   // MARK: - Properties
   
   var emptyType = true
   
   
   
   // MARK: - Initializer
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      setHierarchy()
      setLayout()
      setStyle()
      updateImageCellUI(isImageEmpty: emptyType)
   }
   
   @available(*, unavailable)
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      
      self.prepare(image: nil)
//      self.cellType = .EmptyType
   }
   
   func prepare(image: UIImage?) {
      self.imageView.image = image
   }
   
   override func setHierarchy() {
      contentView.addSubview(imageView)
      contentView.addSubview(emptyView)
      emptyView.addSubviews(emptyCameraImage, emptyLabel)
   }
   
   override func setLayout() {
      imageView.snp.makeConstraints {
         $0.edges.equalToSuperview()
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
         $0.text = StringLiterals.AddCourseOrScheduleFirst.emptyImage
      }
      
      imageView.do {
         $0.contentMode = .scaleAspectFill
         $0.clipsToBounds = true
         $0.layer.cornerRadius = 14
         $0.isHidden = true
      }
   }
   
}

extension AddCourseImageCollectionViewCell {
   func updateImageCellUI(isImageEmpty: Bool) {
      if isImageEmpty {
         emptyView.isHidden = !isImageEmpty
         imageView.isHidden = isImageEmpty
      } else {
         emptyView.isHidden = !isImageEmpty
         imageView.isHidden = isImageEmpty
      }
   }
}
