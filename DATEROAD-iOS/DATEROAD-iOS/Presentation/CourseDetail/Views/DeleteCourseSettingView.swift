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
    
    let titleLabel: UILabel = UILabel()
    
    let deleteLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubview(settingStackView)
        
        settingStackView.addArrangedSubviews(titleLabel, deleteLabel)
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
        
        titleLabel.setLabel(text: StringLiterals.CourseDetail.settingDateCourse,
                            alignment: .center,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.suit(.title_bold_18))
        
        deleteLabel.do {
            $0.isUserInteractionEnabled = true
            $0.setLabel(text: StringLiterals.CourseDetail.deleteCourse,
                        alignment: .center,
                        textColor: UIColor(resource: .deepPurple),
                        font: UIFont.suit(.body_semi_15))
        }
    }
    
}

