//
//  AddThirdView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class AddThirdView: BaseView {
   
   // MARK: - UI Properties
   
   private let container: UIView = UIView()
   
   
   // MARK: - Properties
   
   private let enabledButtonType: DRButtonType = EnabledButton()
   
   private let disabledButtonType: DRButtonType = DisabledButton()
   
   
   // MARK: - Methods
   
   override func setHierarchy() {
      addSubviews (
         container
      )
   }
   
   override func setLayout() {
      container.snp.makeConstraints {
         $0.top.bottom.equalToSuperview()
         $0.horizontalEdges.equalToSuperview()
         $0.height.equalTo(800)
      }
      
      container.do {
         $0.layer.borderWidth = 1
         $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
      }
   }
   
   override func setStyle() {
      
   }
   
}
