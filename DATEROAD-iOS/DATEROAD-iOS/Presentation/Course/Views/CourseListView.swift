//
//  CourseListView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/11/24.
//

import UIKit

import SnapKit
import Then

class CourseListView: BaseView {
    
    // MARK: - UI Properties
    
    private let courseEmptyImageView = UIImageView(image: .imgCourseEmpty)
    
    private let courseEmptyLabel = UILabel()

    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(courseEmptyImageView, courseEmptyLabel)
    }
    
    override func setLayout() {
        
        courseEmptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        courseEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(courseEmptyImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    override func setStyle() {
        courseEmptyLabel.do {
            $0.text = StringLiterals.Course.isCourseEmpty
            $0.textColor = UIColor(resource: .gray500)
            $0.font = UIFont.suit(.title_bold_18)
        }
    }
    
}



