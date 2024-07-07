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
   
   // MARK: - UI Properties
   
   let addSheetView = AddSheetView()
   
   var viewModel: AddCourseViewModel?
   
   var addCourseFirstView: AddCourseFirstView?
   
   // MARK: - Initializer
   
   init(viewModel: AddCourseViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Life Cycle
   
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
         $0.backgroundColor = UIColor.drBlack.withAlphaComponent(0.65)
      }
   }
   
}

extension AddSheetViewController {
   
   // MARK: - Methods
   
   private func setAddTarget() {
      addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
   }
   
   // MARK: - @objc Methods
   
   @objc
   private func didTapDoneBtn() {
      if addSheetView.datePicker.datePickerMode == .date {
         let selectedDate = addSheetView.datePicker.date
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy. MM. dd."
         let formattedDate = dateFormatter.string(from: selectedDate)
         viewModel?.visitDate.value = formattedDate
         dismiss(animated: true, completion: nil)
         viewModel?.isFutureDate()
      } else if addSheetView.datePicker.datePickerMode == .time {
         let dateformatter = DateFormatter()
         dateformatter.dateStyle = .none
         dateformatter.timeStyle = .short
         let formattedDate = dateformatter.string(from: addSheetView.datePicker.date)
         viewModel?.dateStartTime.value = formattedDate
         dismiss(animated: true, completion: nil)
      }
   }
   
}
