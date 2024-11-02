//
//  CourseItemSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 10/30/24.
//

import UIKit

final class CourseItemSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let thumnailImgageView: UIView = UIView()
    
    private let locationLabel: UIView = UIView()
    
    private let primaryTitleLabel: UIView = UIView()
    
    private let secondaryTitleLabel: UIView = UIView()
    
    private let costLabel: UIView = UIView()
    
    private let timeLabel: UIView = UIView()
    
    
    override func setHierarchy() {
        self.addSubviews(thumnailImgageView,
                         locationLabel,
                         primaryTitleLabel,
                         secondaryTitleLabel,
                         costLabel,
                         timeLabel)
    }
    
    override func setLayout() {
        thumnailImgageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(thumnailImgageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(93)
            $0.height.equalTo(13)
        }
        
        primaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(141)
            $0.height.equalTo(17)
        }
        
        secondaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(primaryTitleLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
            $0.width.equalTo(152)
            $0.height.equalTo(17)
        }
        costLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(15)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(costLabel.snp.trailing).offset(12)
            $0.width.equalTo(55)
            $0.height.equalTo(15)
        }
    }
    
    override func setStyle() {
        thumnailImgageView.setSkeletonImage()
        
        [locationLabel,
         primaryTitleLabel,
        secondaryTitleLabel].forEach {
            $0.setSkeletonLabel(radius: 6)
        }
        
        [costLabel, timeLabel].forEach {
            $0.setSkeletonLabel()
        }
    }
    
}

