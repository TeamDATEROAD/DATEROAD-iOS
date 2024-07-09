//
//  AddSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class AddSecondView: BaseView {
   
   private let container: UIView = UIView()
   
   private let contentTitleLabel: UILabel = UILabel()
   
   private let contentSubTitleLabel: UILabel = UILabel()
   
   override func setHierarchy() {
      addSubviews (
         container,
         contentTitleLabel,
         contentSubTitleLabel
      )
      container.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
      container.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
      }
   }
   
   override func setLayout() {
      contentTitleLabel.snp.makeConstraints {
         $0.top.horizontalEdges.equalToSuperview()
      }
      contentSubTitleLabel.snp.makeConstraints {
         $0.top.equalTo(contentTitleLabel.snp.bottom).offset(2)
         $0.horizontalEdges.equalToSuperview()
      }
   }
   
   override func setStyle() {
      contentTitleLabel.do {
         $0.setLabel(
            alignment: .left,
            textColor: UIColor(resource: .drBlack),
            font: .suit(.body_bold_17)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddSecondView.contentTitleLabelOfCourse
      }
      
      contentSubTitleLabel.do {
         $0.setLabel(
            alignment: .left,
            textColor: UIColor(resource: .gray400),
            font: .suit(.body_med_13)
         )
         $0.text = StringLiterals.AddCourseOrSchedul.AddSecondView.subTitleLabel
      }
   }
}
