//
//  ContentMaskView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//


import Then

import UIKit
import SnapKit

protocol ContentMaskViewDelegate: AnyObject {
    func didTapButton()
}

class ContentMaskView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let gradientView = UIView()
    
    private let mainTitleLabel = UILabel()
    
    private let pointImageView = UIImageView(image: .imgPreview)
    
    private let subTitleLabel = UILabel()
    
    private let readCourseButton = UIButton()
    
    private let gradient = CAGradientLayer()
    
    // MARK: - Properties
    
    weak var delegate: ContentMaskViewDelegate?
    
    static let elementKinds: String = "ContentMaskView"
    
    static let identifier: String = "ContentMaskView"
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubviews(
            gradientView,
            pointImageView,
            mainTitleLabel,
            subTitleLabel,
            readCourseButton
        )
    }
    
    func setLayout() {
        
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pointImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(134)
            $0.height.equalTo(100)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pointImageView.snp.bottom).offset(16)
            $0.centerX.equalTo(gradientView)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        readCourseButton.snp.makeConstraints {
            $0.bottom.equalTo(gradientView).inset(32)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(54)
        }
    }
    
    func setStyle() {
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
            $0.addTarget(self, action: #selector(didReadCourseButton), for: .touchUpInside)
        }
        
        gradient.locations = [0, 1]
        gradient.frame = gradientView.bounds
        gradient.colors = [
            UIColor(resource: .drWhite).withAlphaComponent(1).cgColor,
            UIColor(resource: .drWhite).withAlphaComponent(0.7).cgColor,
            UIColor(resource: .drWhite).withAlphaComponent(0.2).cgColor,
            UIColor(resource: .drWhite).withAlphaComponent(0).cgColor
                ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.7)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.09)
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
    @objc
    func didReadCourseButton() {
        delegate?.didTapButton()
        print("내가 죄송해")
    }
    
    func checkFree(haveFree: Bool, count: Int) {
        if haveFree {
            readCourseButton.setTitle("무료 열람 기회 쓰기(\(count)/3)", for: .normal)
        } else {
            readCourseButton.setTitle(StringLiterals.CourseDetail.viewCoursewithPoint, for: .normal)
        }
    }
}
