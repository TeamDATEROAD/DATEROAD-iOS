//
//  AddSheetViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/6/24.
//

import UIKit

import SnapKit
import Then

final class AddSheetViewController: BaseViewController {
   
   private let addSheetView = AddSheetView()
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func setHierarchy() {
      view.addSubview(addSheetView)
   }
   
   override func setLayout() {
      addSheetView.snp.makeConstraints {
         $0.edges.equalToSuperview()
      }
   }
   
   override func setStyle() {
      view.do {
         $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
      }
   }
   
}
