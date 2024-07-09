//
//  AddSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

class AddSecondView: BaseView {
   
   private let blurView = UIView()
   
   override func setHierarchy() {
      addSubview(blurView)
      blurView.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
      blurView.do {
         $0.backgroundColor = .red
      }
   }
   
   override func setLayout() {
   }
}
