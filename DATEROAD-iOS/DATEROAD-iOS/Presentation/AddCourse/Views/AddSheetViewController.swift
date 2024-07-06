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
   
   var viewModel: AddCourseViewModel?
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
      setAddTarget()
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

extension AddSheetViewController {
   private func setAddTarget() {
      addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
   }
   
   @objc
   private func didTapDoneBtn() {
      let selectedDate = addSheetView.datePicker.date
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy. MM. dd."
      let formattedDate = dateFormatter.string(from: selectedDate)
      print("\(formattedDate)")
      viewModel?.visitDate.value = formattedDate
      dismiss(animated: true, completion: nil)
   }
}
