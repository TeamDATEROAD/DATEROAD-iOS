//
//  PreviewViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/7/24.
//

import UIKit

import SnapKit
import Then

class PreviewView: BaseView {
    
    // MARK: - UI Properties
    
    private let gradientView = UIView()
    
    private let mainTitleLabel = UILabel()
    
    private let subTitleLabel = UILabel()
    
    private let readCourseButton = UIButton()
    
    private let gradient = CAGradientLayer()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.addSubviews(
            gradientView,
            mainTitleLabel,
            subTitleLabel,
            readCourseButton
        )
    }
    
    override func setLayout() {
        super.setLayout()
        
        gradientView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(233)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-4)
            $0.centerX.equalTo(gradientView)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(readCourseButton.snp.top).offset(-25)
            $0.centerX.equalToSuperview()
        }
        
        readCourseButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        gradientView.backgroundColor = .red
        
        mainTitleLabel.do {
            $0.text = "코스 정보가 궁금하신가요?"
            $0.textColor = UIColor(resource: .drBlack)
            $0.font = UIFont.suit(.body_bold_17)
        }
        
        subTitleLabel.do {
            $0.text = "50P로 코스를 확인해보세요!"
            $0.textColor = UIColor(resource: .deepPurple)
            $0.font = UIFont.suit(.body_semi_15)
        }
        
        readCourseButton.do {
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setTitle(StringLiterals.CourseDetail.viewCoursewithPoint, for: .normal)
            $0.setTitleColor(.drWhite, for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
        }
        
    }
    
}

