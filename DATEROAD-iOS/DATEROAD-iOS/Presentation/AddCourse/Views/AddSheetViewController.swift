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
   
   var addSecondView: AddSecondView?
   
   var isCustomPicker: Bool?
   
   var customPickerValues: [Double] = []
   
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
      setupCustomPicker()
      addSheetView.isCustomPicker(flag: isCustomPicker ?? false)
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
   
   private func setupCustomPicker() {
      if isCustomPicker == true {
         customPickerValues = Array(stride(from: 0.5, to: 6.5, by: 0.5))
         addSheetView.customPickerView.dataSource = self
         addSheetView.customPickerView.delegate = self
         addSheetView.customPickerView.reloadAllComponents()
      }
   }
}

extension AddSheetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return customPickerValues.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return String(customPickerValues[row])
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      print("Selected Value: \(customPickerValues[row])")
      // 선택된 값을 ViewModel 또는 필요한 곳에 전달
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
      if isCustomPicker == true {
         let selectedRow = addSheetView.customPickerView.selectedRow(inComponent: 0)
         let selectedValue = customPickerValues[selectedRow]
         viewModel?.updateTimeRequireTextField(text: String(selectedValue))
         dismiss(animated: true, completion: nil)
      } else {
         if addSheetView.datePicker.datePickerMode == .date {
            let selectedDate = addSheetView.datePicker.date
            viewModel?.isFutureDate(date: selectedDate, dateType: "date")
            dismiss(animated: true, completion: nil)
         } else {
            let formattedDate = addSheetView.datePicker.date
            viewModel?.isFutureDate(date: formattedDate, dateType: "time")
            dismiss(animated: true, completion: nil)
         }
      }
   }
}
