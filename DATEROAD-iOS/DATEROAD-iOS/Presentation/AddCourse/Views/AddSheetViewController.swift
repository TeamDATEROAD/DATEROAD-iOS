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
   
   let addSheetView = AddSheetView()
   
   var viewModel: AddCourseViewModel?
   
   var addCourseFirstView: AddCourseFirstView?
   
   init(viewModel: AddCourseViewModel) {
      
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      bindViewModel()
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
   private func bindViewModel() {
      viewModel?.isNonError = { [weak self] in
         self?.addCourseFirstView?.updateVisitDateTextField(isPassValid: true)
         self?.dismiss(animated: true, completion: nil)
      }
      
      viewModel?.isError = { [weak self] in
         self?.addCourseFirstView?.updateVisitDateTextField(isPassValid: false)
         self?.dismiss(animated: true, completion: nil)
      }
   }
   
   private func setAddTarget() {
      addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
   }
   
   @objc
   private func didTapDoneBtn() {
      if addSheetView.datePicker.datePickerMode == .date {
         let selectedDate = addSheetView.datePicker.date
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy. MM. dd."
         let formattedDate = dateFormatter.string(from: selectedDate)
         viewModel?.visitDate.value = formattedDate
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
