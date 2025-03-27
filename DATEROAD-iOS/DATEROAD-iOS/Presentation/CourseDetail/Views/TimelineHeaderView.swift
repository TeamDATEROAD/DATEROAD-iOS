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
    
    private let titleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.CourseDetail.timelineInfoLabel,
        textLabelType: .clear(.bold18_black),
        numberOfLines: 1
    )
    
    private let subLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi13_gray400))
    
    
    // MARK: - Properties
    
    static let elementKinds: String = "TimelineHeaderView"
    
    static let identifier: String = "TimelineHeaderView"
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
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
    
}

extension TimelineHeaderView {
    
    func bindSubTitle(subTitle: String?) {
        if let startAt = subTitle {
            self.subLabel.text = "\(startAt) 시작"
        }
    }
    
}
