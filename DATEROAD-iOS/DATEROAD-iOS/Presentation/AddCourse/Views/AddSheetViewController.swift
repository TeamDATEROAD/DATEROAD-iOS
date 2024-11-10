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
    
    private let backgroundView: UIView = UIView()
    
    var addSheetView = AddSheetView(isCustomPicker: true)
    
    
    // MARK: - Properties
    
    var viewModel: AddCourseViewModel?
    
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
        
        setCustomPicker()
    }
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        view.addSubviews(backgroundView, addSheetView)
    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSheetView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(304)
        }
    }
    
    override func setStyle() {
        backgroundView.do {
            $0.backgroundColor = UIColor.drBlack.withAlphaComponent(0.4)
            $0.alpha = 0
        }
        
        addSheetView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
}


// MARK: - ViewController Methods

extension AddSheetViewController {
    
    func presentBottomSheet(in viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false) {
            self.animateBottomSheetPresentation(animated: animated, completion: completion)
        }
    }
    
    func dismissBottomSheet(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.addSheetView.transform = CGAffineTransform(translationX: 0, y: self.addSheetView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: false, completion: completion)
            })
        } else {
            self.backgroundView.alpha = 0
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    private func animateBottomSheetPresentation(animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            self.addSheetView.transform = CGAffineTransform(translationX: 0, y: self.addSheetView.frame.height)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backgroundView.alpha = 1
                self.addSheetView.transform = .identity
            }, completion: { _ in
                completion?()
            })
        } else {
            self.backgroundView.alpha = 1
            completion?()
        }
    }
    
}

private extension AddSheetViewController {
    
    func setCustomPicker() {
        customPickerValues = Array(stride(from: 0.5, to: 6.5, by: 0.5))
        addSheetView.customPickerView.dataSource = self
        addSheetView.customPickerView.delegate = self
        addSheetView.customPickerView.reloadAllComponents()
        addSheetView.doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
    }
    
    
    // MARK: - @objc Methods
    
    @objc
    func didTapDoneBtn() {
        let selectedRow = addSheetView.customPickerView.selectedRow(inComponent: 0)
        let selectedValue = customPickerValues[selectedRow]
        viewModel?.updateTimeRequireTextField(text: String(selectedValue))
        self.dismissBottomSheet()
    }
    
}


// MARK: - UIPickerViewDataSource, UIPickerViewDelegate Methods

extension AddSheetViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(customPickerValues[row])
    }
    
}

extension AddSheetViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return customPickerValues.count
    }
    
}
