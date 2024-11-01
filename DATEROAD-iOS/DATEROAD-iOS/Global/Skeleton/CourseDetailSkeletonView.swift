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
    
    private let costLabel: UILabel = UILabel()
    
    private let timeLabel: UILabel = UILabel()
    
    private let locationLabel: UILabel = UILabel()
    


    
    override func setHierarchy() {
        self.addSubviews(carouselImageView,
                         visitDateLabel,
                         primaryTitleLabel,
                         secondaryTitleLabel)
    }
    
    override func setLayout() {
        carouselImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(carouselImageView.snp.width)
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.top.equalTo(carouselImageView.snp.bottom).offset(23)
            $0.width.equalTo(70)
            $0.leading.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(visitDateLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        primaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(primaryTitleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        carouselImageView.image = UIImage(resource: .placeholder)
        
        [visitDateLabel, dateLabel, titleLabel, contentLabel].forEach {
            $0.roundedLabel(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.backgroundColor = UIColor(resource: .gray100).withAlphaComponent(0.5)
            $0.textColor = UIColor.clear
            $0.numberOfLines = 0
        }
        
        visitDateLabel.do {
            $0.roundedLabel(cornerRadius: 6, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.text = SKELETON.BANNERDETAIL.TAG
            $0.font = UIFont.suit(.body_semi_13)
        }
        
        dateLabel.do {
            $0.text = SKELETON.BANNERDETAIL.DATE
            $0.font = UIFont.suit(.body_bold_15)
        }
        
        primaryTitleLabel.do {
            $0.text = SKELETON.BANNERDETAIL.TITLE
            $0.font = UIFont.suit(.title_extra_24)
        }
        
        contentLabel.do {
            $0.text = SKELETON.BANNERDETAIL.CONTENT
            $0.font = UIFont.suit(.body_med_13)
        }
    }
    
}

