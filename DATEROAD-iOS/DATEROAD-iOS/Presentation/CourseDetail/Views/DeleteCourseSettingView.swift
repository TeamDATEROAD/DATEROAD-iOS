//
//  DeleteCourseView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/14/24.
//

import UIKit

final class DeleteCourseSettingView: BaseView {
    
    // MARK: - UI Properties
    
    private let settingStackView: UIStackView = UIStackView()
    
    let titleLabel: DRTextLabel = DRTextLabel(title: StringLiterals.CourseDetail.settingDateCourse, textLabelType: .clear(.bold18_black))
    
    let optionButton: DRTextButton = DRTextButton(title: "", buttonName: .semi_white_0)
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubview(settingStackView)
        
        settingStackView.addArrangedSubviews(titleLabel, optionButton)
    }
    
    override func setLayout() {
        settingStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        settingStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
    }
    
}

