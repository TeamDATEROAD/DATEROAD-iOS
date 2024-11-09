//
//  AddScheduleFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleFirstView: BaseView {
    
    // MARK: - UI Properties
    
    let inAddScheduleFirstView = InAddScheduleFirstView()
    
    let dateNameErrorLabel = UILabel()
    
    let visitDateErrorLabel = UILabel()
    
    
    // MARK: - Properties
    
    private let warningType: DRErrorType = Warning()
    
    override func setHierarchy() {
        self.addSubviews(inAddScheduleFirstView,
                         dateNameErrorLabel,
                         visitDateErrorLabel)
    }
    
    override func setLayout() {
        inAddScheduleFirstView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateNameErrorLabel.snp.makeConstraints {
            $0.top.equalTo(inAddScheduleFirstView.dateNameTextField.snp.bottom).offset(2)
            $0.leading.equalTo(inAddScheduleFirstView.dateNameTextField).offset(9)
        }
        
        visitDateErrorLabel.snp.makeConstraints {
            $0.top.equalTo(inAddScheduleFirstView.visitDateContainer.snp.bottom).offset(2)
            $0.leading.equalTo(inAddScheduleFirstView.visitDateContainer.snp.leading).offset(9)
        }
    }
    
    override func setStyle() {
        for i in [dateNameErrorLabel,visitDateErrorLabel] {
            i.do {
                if i == dateNameErrorLabel {
                    $0.setErrorLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNameErrorLabel, errorType: warningType)
                } else {
                    $0.setErrorLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateErrorLabel, errorType: warningType)
                }
                $0.isHidden = true
            }
        }
    }
    
}


// MARK: - Extension Methods

extension AddScheduleFirstView {
    
    func updateDateNameTextField(isPassValid: Bool) {
        dateNameErrorLabel.isHidden = isPassValid
        inAddScheduleFirstView.dateNameTextField.do {
            $0.layer.borderWidth = isPassValid ? 0 : 1
        }
    }
    
    func updateVisitDateTextField(isPassValid: Bool) {
        visitDateErrorLabel.isHidden = isPassValid
        inAddScheduleFirstView.visitDateContainer.do {
            $0.layer.borderWidth = isPassValid ? 0 : 1
        }
    }
    
}
