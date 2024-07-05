//
//  AddCourseImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/4/24.
//

import UIKit

import SnapKit
import Then

class AddCourseImageCollectionViewCell: UICollectionViewCell {
   
   static let id: String = "AddCourseImageCollectionViewCell"
   
   // MARK: - UI Properties
   
   private let imageView = UIImageView()
   
   // MARK: Initializer
   
   @available(*, unavailable)
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setHierarchy()
      setLayout()
      setStyle()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      self.prepare(image: nil)
   }
   
   func prepare(image: UIImage?) {
      self.imageView.image = image
   }
   
   func setHierarchy() {
       contentView.addSubview(imageView)
   }
   
   func setLayout() {
      imageView.snp.makeConstraints {
         $0.top.equalTo(contentView)
         $0.horizontalEdges.bottom.equalToSuperview()
      }
   }
   
   func setStyle() {
      imageView.do {
         $0.contentMode = .scaleAspectFill
         $0.backgroundColor = .drBlack
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor.red.cgColor
      }
   }
   
}
