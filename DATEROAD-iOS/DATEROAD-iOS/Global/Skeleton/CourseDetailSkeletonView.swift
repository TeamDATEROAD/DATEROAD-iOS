//
//  CourseDetailSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/2/24.
//

import UIKit

final class CourseDetailSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let carouselImageView: UIImageView = UIImageView()
    
    private let visitDateLabel: UILabel = UILabel()
    
    private let primaryTitleLabel: UILabel = UILabel()
    
    private let secondaryTitleLabel: UILabel = UILabel()
    
    private let costLabel: UILabel = UILabel()
    
    private let timeLabel: UILabel = UILabel()
    
    private let locationLabel: UILabel = UILabel()
    
    private let firstDetailContentView: DetailContentView = DetailContentView()
    
    private let secondDetailContentView: DetailContentView = DetailContentView()

    
    override func setHierarchy() {
        self.addSubviews(carouselImageView,
                         visitDateLabel,
                         primaryTitleLabel,
                         secondaryTitleLabel,
                         costLabel,
                         timeLabel,
                         locationLabel,
                         firstDetailContentView,
                         secondDetailContentView)
    }
    
    override func setLayout() {
        carouselImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(carouselImageView.snp.width)
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.top.equalTo(carouselImageView.snp.bottom).offset(23)
            $0.width.equalTo(144)
            $0.height.equalTo(21)
            $0.leading.equalToSuperview().inset(16)
        }
        
        primaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(visitDateLabel.snp.bottom).offset(14)
            $0.width.equalTo(312)
            $0.height.equalTo(27)
            $0.leading.equalToSuperview().inset(16)
        }
        
        secondaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(primaryTitleLabel.snp.bottom).offset(8)
            $0.width.equalTo(278)
            $0.height.equalTo(27)
            $0.leading.equalToSuperview().inset(16)
        }
        
        costLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(20)
            $0.width.equalTo(102)
            $0.height.equalTo(21)
            $0.leading.equalToSuperview().inset(16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(20)
            $0.width.equalTo(64)
            $0.height.equalTo(21)
            $0.leading.equalTo(costLabel.snp.trailing).offset(16)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(20)
            $0.width.equalTo(127)
            $0.height.equalTo(21)
            $0.leading.equalTo(timeLabel.snp.trailing).offset(24)
        }
        
        firstDetailContentView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.height.equalTo(240)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        secondDetailContentView.snp.makeConstraints {
            $0.top.equalTo(firstDetailContentView.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        carouselImageView.image = UIImage(resource: .placeholder)
        
        [visitDateLabel,
         primaryTitleLabel,
         secondaryTitleLabel,
         costLabel,
         timeLabel,
         locationLabel
        ].forEach {
            $0.setSkeletonLabel()
        }
    }
    
}

