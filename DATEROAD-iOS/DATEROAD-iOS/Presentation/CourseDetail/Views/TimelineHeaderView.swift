//
//  TimelineHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 8/16/24.
//

import UIKit

import SnapKit
import Then

final class TimelineHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = UILabel()
    
    private let subLabel: UILabel = UILabel()
    
    // MARK: - Properties
    
    static let elementKinds: String = "TimelineHeaderView"
    
    static let identifier: String = "TimelineHeaderView"
    
    
    // MARK: - Life Cycles
    
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
        self.addSubviews(titleLabel, subLabel)
        
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(subLabel.snp.top).offset(-7)
            $0.leading.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    func setStyle() {
        titleLabel.do {
            $0.setLabel(text: StringLiterals.CourseDetail.timelineInfoLabel, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_bold_18))
            $0.numberOfLines = 1
        }
        
        subLabel.do {
            $0.setLabel(
                text:"12:00 PM 시작",
                textColor: UIColor(
                    resource: .gray400
                ),
                font: UIFont.suit(
                    .body_semi_15
                )
            )
        }
    }
    
}

extension TimelineHeaderView {
    
    func bindSubTitle(subTitle: String?) {
        if let startAt = subTitle {
            self.subLabel.text = "\(startAt) 시작"
        }
    }
    
}
