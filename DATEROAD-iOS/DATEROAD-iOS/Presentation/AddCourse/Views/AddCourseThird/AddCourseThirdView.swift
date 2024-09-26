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
   
   let scrollView: UIScrollView = UIScrollView()
   
   private let scrollContentView: UIView = UIView()
   
   var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addThirdView: AddThirdView = AddThirdView()
   
   let addThirdDoneBtn: UIButton = UIButton()
   
   private let enabledButtonType: DRButtonType = EnabledButton()
   
   private let disabledButtonType: DRButtonType = addCoursePlaceDisabledButton()
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      self.addSubviews(scrollView, addThirdDoneBtn)
      scrollView.addSubview(scrollContentView)
      scrollContentView.addSubviews(collectionView, addThirdView)
   }
   
   override func setLayout() {
      scrollView.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(addThirdDoneBtn.snp.top).offset(-10)
      }
      
      addThirdDoneBtn.snp.makeConstraints {
         $0.height.equalTo(54)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalTo(safeAreaLayoutGuide).offset(-4)
      }
      
      scrollContentView.snp.makeConstraints {
         $0.width.equalTo(scrollView.frameLayoutGuide)
         $0.edges.equalTo(scrollView.contentLayoutGuide)
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
         $0.showsVerticalScrollIndicator = false
         $0.contentInsetAdjustmentBehavior = .always
      }
      
      collectionView.do {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumInteritemSpacing = 12.0
         layout.itemSize = CGSize(width: 130, height: 130)
         $0.collectionViewLayout = layout
         $0.isScrollEnabled = true
         $0.showsHorizontalScrollIndicator = false
         $0.showsVerticalScrollIndicator = false
         $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
         $0.clipsToBounds = true
      }
      
      addThirdDoneBtn.do {
         $0.setButtonStatus(buttonType: disabledButtonType)
         $0.setTitle(StringLiterals.AddCourseOrSchedule.AddThirdView.addThirdDoneBtn, for: .normal)
         $0.titleLabel?.font = .suit(.body_bold_15)
      }
   }
   
}

extension AddCourseThirdView {
   
   func updateAddThirdDoneBtn(isValid: Bool) {
      print("현재 updateAddThirdDoneBtn \(isValid)")
      let state = isValid ? enabledButtonType : disabledButtonType
      addThirdDoneBtn.setButtonStatus(buttonType: state)
   }
   
}
