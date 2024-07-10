//
//  CourseNavigationBarView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

import SnapKit
import Then

class CourseNavigationBarView: BaseView {
    
    // MARK: - UI Properties
    
    private let courseLabel = UILabel()
    
    private let addCourseButton = UIButton()
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(courseLabel, addCourseButton)
    }
    
    override func setLayout() {
        
        courseLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        addCourseButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(44)
            $0.height.equalTo(30)
        }
        
    }
    
    override func setStyle() {
        courseLabel.do {
            $0.text = StringLiterals.Course.course
            $0.textColor = UIColor(resource: .drBlack)
            $0.font = UIFont.suit(.title_bold_20)
        }
        
        addCourseButton.do {
            $0.roundedButton(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .deepPurple)
            //수민이꺼 머지하면 이미지 가져다 쓰기
            //$0.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        }
    }
    
}

