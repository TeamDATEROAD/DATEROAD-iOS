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
      container.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
      container.do {
         $0.backgroundColor = .red
      }
   }
   
   override func setLayout() {
   }
   
   override func setStyle() {
      
   }
   
}
