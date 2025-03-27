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
    
    private let dateNameErrorLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNameErrorLabel,
        textLabelType: .clear(.reg11_alertRed),
        alignment: .left,
        numberOfLines: 1,
        hidden: true
    )
    
    private let visitDateErrorLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateErrorLabel,
        textLabelType: .clear(.reg11_alertRed),
        alignment: .left,
        numberOfLines: 1,
        hidden: true
    )
    
    
    // MARK: - Properties
    
    private let warningType: DRErrorType = Warning()
    
    override func setHierarchy() {
        self.addSubviews(
            inAddScheduleFirstView,
            dateNameErrorLabel,
            visitDateErrorLabel
        )
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
            $0.top.equalTo(inAddScheduleFirstView.visitDateTextField.snp.bottom).offset(2)
            $0.leading.equalTo(inAddScheduleFirstView.visitDateTextField.snp.leading).offset(9)
        }
    }
    
}


// MARK: - Extension Methods

extension AddScheduleFirstView {
    
    func updateDateNameTextField(isPassValid: Bool) {
        dateNameErrorLabel.isHidden = isPassValid
        inAddScheduleFirstView.dateNameTextField.layer.borderWidth = isPassValid ? 0 : 1
    }
    
    func updateVisitDateTextField(isPassValid: Bool) {
        visitDateErrorLabel.isHidden = isPassValid
        inAddScheduleFirstView.visitDateTextField.layer.borderWidth = isPassValid ? 0 : 1
    }
    
}
