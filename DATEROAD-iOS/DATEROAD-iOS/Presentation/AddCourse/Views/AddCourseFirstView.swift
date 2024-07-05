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
   
   var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addFirstView = AddFirstView()
   
   // MARK: - Methods
   
   override func setHierarchy() {

      super.setHierarchy()
      self.addSubviews(collectionView, addFirstView)
      
   }
   
   override func setLayout() {
      
      super.setLayout()
      collectionView.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(146)
      }
      
      addFirstView.snp.makeConstraints {
         $0.top.equalTo(collectionView.snp.bottom).offset(14)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalToSuperview()
      }
   }
   
   override func setStyle() {
      
      super.setStyle()
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
   }

}
