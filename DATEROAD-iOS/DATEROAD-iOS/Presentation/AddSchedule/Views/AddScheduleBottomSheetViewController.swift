//
//  AddScheduleBottomSheetViewController.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleBottomSheetViewController: BaseViewController {
   
   // MARK: - UI Properties
   
   var addSheetView = AddScheduleBottomSheetView(isCustomPicker: true)
   
   var viewModel: AddScheduleViewModel?
   
   var customPickerValues: [Double] = []
   
   
   // MARK: - Initializer
   
   init(viewModel: AddScheduleViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK: - Life Cycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setCustomPicker()
   }
   
   
   // MARK: - Methods
   
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

// MARK: - ViewController Methods

private extension AddScheduleBottomSheetViewController {
   
   private func setCustomPicker() {
      customPickerValues = Array(stride(from: 0.5, to: 6.5, by: 0.5))
      addSheetView.customPickerView.dataSource = self
      addSheetView.customPickerView.delegate = self
      addSheetView.customPickerView.reloadAllComponents()
      addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
   }
   
   // MARK: - @objc Methods
   
   @objc
   private func didTapDoneBtn() {
      let selectedRow = addSheetView.customPickerView.selectedRow(inComponent: 0)
      let selectedValue = customPickerValues[selectedRow]
      viewModel?.updateTimeRequireTextField(text: String(selectedValue))
      dismiss(animated: true)
   }
}


// MARK: - UIPickerViewDataSource, UIPickerViewDelegate Methods

extension AddScheduleBottomSheetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return customPickerValues.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return String(customPickerValues[row])
   }
   
}
