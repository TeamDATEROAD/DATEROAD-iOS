//
//  MyCourseSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/1/24.
//

import UIKit

final class MyCourseItemSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let thumbnailImageView: UIView = UIView()
    
    private let locationLabel: UIView = UIView()
    
    private let primaryTitleLabel: UIView = UIView()
    
    private let secondaryTitleLabel: UIView = UIView()
    
    private let costLabel: UIView = UIView()
    
    private let timeLabel: UIView = UIView()
    
    
    override func setHierarchy() {
        self.addSubviews(thumbnailImageView,
                         locationLabel,
                         primaryTitleLabel,
                         secondaryTitleLabel,
                         costLabel,
                         timeLabel)
    }
    
    override func setLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(120)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.top.equalTo(thumbnailImageView).inset(9)
            $0.width.equalTo(91)
            $0.height.equalTo(18)
        }
        
        primaryTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.width.equalTo(186)
            $0.height.equalTo(18)
        }
        
        secondaryTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.top.equalTo(primaryTitleLabel.snp.bottom).offset(5)
            $0.width.equalTo(144)
            $0.height.equalTo(18)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(10)
            $0.width.equalTo(98)
            $0.height.equalTo(26)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(costLabel.snp.trailing).offset(6)
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(10)
            $0.width.equalTo(72)
            $0.height.equalTo(26)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        thumbnailImageView.setSkeletonImage(radius: 12)
        
        [locationLabel, primaryTitleLabel, secondaryTitleLabel].forEach {
            $0.setSkeletonLabel()
        }
        
        [costLabel, timeLabel].forEach {
            $0.setSkeletonLabel(radius: 12)
        }
    }
    
}
