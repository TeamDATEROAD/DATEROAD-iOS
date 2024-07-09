//
//  AddCourseSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class AddCourseSecondView: BaseView {
   
   // MARK: - UI Properties
   
   lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   
   let addSecondView = AddSecondView()
   
   let editButton: UIButton = UIButton()
   
   private let guideLabel: UILabel = UILabel()
   
   let tableView: UITableView = UITableView()
   
   private let warningType: DRErrorType = Warning()
   
   override func setHierarchy() {
      self.addSubviews (
         collectionView,
         addSecondView
      )
      addSecondView.addSubviews(editButton, guideLabel, tableView)
   }
   
   override func setLayout() {
      collectionView.snp.makeConstraints {
         $0.top.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(146)
      }
      
      addSecondView.snp.makeConstraints {
         $0.top.equalTo(collectionView.snp.bottom).offset(7)
         $0.horizontalEdges.equalToSuperview().inset(16)
         $0.bottom.equalToSuperview()
      }
      
      editButton.snp.makeConstraints {
         $0.top.equalTo(addSecondView.separatorLine.snp.bottom).offset(10)
         $0.trailing.equalToSuperview()
         $0.width.equalTo(59)
         $0.height.equalTo(30)
      }
      
      guideLabel.snp.makeConstraints {
         $0.leading.equalToSuperview()
         $0.centerY.equalTo(editButton)
      }
      
      tableView.snp.makeConstraints {
         $0.top.equalTo(editButton.snp.bottom).offset(14)
         $0.horizontalEdges.equalToSuperview()
         $0.bottom.equalTo(addSecondView.nextBtn.snp.top).offset(-12)
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
      
      editButton.do {
         $0.setTitle(StringLiterals.AddCourseOrSchedul.AddSecondView.edit, for: .normal)
         $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
         $0.titleLabel?.font = .suit(.body_med_13)
      }
      
      guideLabel.do {
         $0.setLabel(alignment: .left, textColor: UIColor(resource: .gray400), font: .suit(.body_med_13))
         $0.text = StringLiterals.AddCourseOrSchedul.AddSecondView.guideLabel
      }
      
      tableView.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor(resource: .deepPurple).cgColor
      }
      
   }
   
}
