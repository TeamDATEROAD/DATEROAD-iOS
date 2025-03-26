//
//  ContentMaskView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//


import Then

import UIKit
import SnapKit

final class ContentMaskView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let gradientView = UIView()
    
    private let mainTitleLabel: DRTextLabel = DRTextLabel(title: "코스 정보가 궁금하신가요?", textLabelType: .clear(.bold17_black))
    
    private let pointImageView = UIImageView(image: .imgPreview)
    
    private let subTitleLabel: DRTextLabel = DRTextLabel(title: "50P로 코스를 확인해보세요!", textLabelType: .clear(.semi15_black))
    
    let readCourseButton = DRTextButton(title: StringLiterals.CourseDetail.viewCoursewithPoint, buttonName: .bold_purple_14)
    
    private let gradient = CAGradientLayer()
    
    
    // MARK: - Properties
        
    static let elementKinds: String = StringLiterals.Elementkinds.contentMaskView
    
    static let identifier: String = StringLiterals.Elementkinds.contentMaskView
    
    
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
        gradient.locations = [0, 1]
        gradient.frame = gradientView.bounds
        gradient.colors = [
            UIColor(resource: .drWhite).withAlphaComponent(0.3).cgColor,
            UIColor(resource: .drWhite).withAlphaComponent(0.7).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.03)
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
}

extension ContentMaskView {
    
    func updateReadCourseButton(haveFree: Bool, count: Int) {
        readCourseButton.setTitle(haveFree ? "무료 열람 기회 쓰기(\(count)/3)" : StringLiterals.CourseDetail.viewCoursewithPoint, for: .normal)
    }
    
}
