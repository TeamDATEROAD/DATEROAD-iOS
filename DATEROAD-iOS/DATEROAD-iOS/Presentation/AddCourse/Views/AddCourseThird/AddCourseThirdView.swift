//
//  AddCourseThirdView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseThirdView: BaseView {
   
   // MARK: - UI Properties
   
   private let scrollView: UIScrollView = UIScrollView()
   
   private let scrollContentView: UIView = UIView()
   
   var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addThirdView = AddThirdView()
   
   // MARK: - Methods
   
   override func setHierarchy() {
      self.addSubview(scrollView)
      scrollView.addSubview(scrollContentView)
      scrollContentView.addSubviews(collectionView, addThirdView)
   }
   
   override func setLayout() {
      scrollView.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
      
      scrollContentView.snp.makeConstraints {
         $0.edges.equalToSuperview()
         $0.width.equalToSuperview()
         $0.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.low)
      }
      
      collectionView.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview()
         $0.height.equalTo(146)
      }
      
      addThirdView.snp.makeConstraints {
         $0.top.equalTo(collectionView.snp.bottom).offset(7)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalToSuperview()
      }
      
   }
   
   override func setStyle() {
      scrollView.do {
         $0.isScrollEnabled = true
         $0.showsVerticalScrollIndicator = false
      }
      
      
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


// MARK: - View Methods

extension AddCourseThirdView {
   
}
