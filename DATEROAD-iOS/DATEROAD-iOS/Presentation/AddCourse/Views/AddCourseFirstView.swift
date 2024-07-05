//
//  AddCourseFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

class AddCourseFirstView: BaseView {
   
   // MARK: - UI Properties
   
   lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addFirstView = AddFirstView()
   
   private let ImageAccessoryView = UIView()
   
   let cameraBtn = UIButton()
   
   private let imageCountLabelContainer = UIView()
   
   let imageCountLabel = UILabel()
   
   // MARK: - Methods
   
   override func setHierarchy() {
      self.addSubviews(collectionView, ImageAccessoryView, addFirstView)
      ImageAccessoryView.addSubviews(cameraBtn, imageCountLabelContainer)
      imageCountLabelContainer.addSubview(imageCountLabel)
   }
   
   override func setLayout() {
      collectionView.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(146)
      }
      
      ImageAccessoryView.snp.makeConstraints {
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
   }
   
}
