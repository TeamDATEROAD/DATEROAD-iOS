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
    
    let dimmedView: DRDimmedView = DRDimmedView()
    
    var addSheetView = AddScheduleBottomSheetView(isCustomPicker: true)
    
    
    // MARK: - Properties
    
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
        view.addSubviews(dimmedView, addSheetView)
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(304)
        }
    }
    
    override func setStyle() {        
        addSheetView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
}

private extension AddScheduleBottomSheetViewController {
    
    func setCustomPicker() {
        customPickerValues = Array(stride(from: 0.5, to: 6.5, by: 0.5))
        addSheetView.customPickerView.dataSource = self
        addSheetView.customPickerView.delegate = self
        addSheetView.customPickerView.reloadAllComponents()
        addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
    }
    
    @objc
    func didTapDoneBtn() {
        let selectedRow = addSheetView.customPickerView.selectedRow(inComponent: 0)
        let selectedValue = customPickerValues[selectedRow]
        viewModel?.inputUpdateTimeRequire.value = String(selectedValue)
//        viewModel?.updateTimeRequireTextField(text: String(selectedValue))
        self.dismissBottomSheet(addSheetView, dimmedView)
    }
    
}


// MARK: - UIPickerViewDataSource, UIPickerViewDelegate Methods


extension AddScheduleBottomSheetViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(customPickerValues[row])
    }
    
}

extension AddScheduleBottomSheetViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return customPickerValues.count
    }
    
}
