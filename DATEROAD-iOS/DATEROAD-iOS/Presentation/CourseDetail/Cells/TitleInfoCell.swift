//
//  MainContentsCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class TitleInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let dateLabel = UILabel()
    
    private let titleView = UIView()
    
    private let titleLabel = UILabel()
    
    private let coastIconImageView = UIImageView(image: .coastIcon)
    
    private let coastLabel = UILabel()
    
    private let timeIconImageView = UIImageView(image: .timeIcon)
    
    private let timeLabel = UILabel()
    
    private let locationIconImageView = UIImageView(image: .locationIcon)
    
    private let locationLabel = UILabel()
    
    override func setHierarchy() {
        self.addSubviews(
            dateLabel,
            titleLabel,
            coastLabel,
            coastIconImageView,
            titleView,
            timeLabel,
            timeIconImageView,
            locationLabel,
            locationIconImageView
        )
    }
    
    override func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalToSuperview()
        }
        titleView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleView)
            $0.leading.trailing.equalToSuperview()
        }
        
        coastIconImageView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(14)
        }
        
        coastLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(3.5)
        }
        
        timeIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(coastLabel.snp.trailing).offset(25)
            $0.width.height.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(3.5)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(timeLabel.snp.trailing).offset(25)
            $0.width.equalTo(12)
            $0.height.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationIconImageView)
            $0.leading.equalTo(locationIconImageView.snp.trailing).offset(3.5)
        }
        
    }
    
    override func setStyle() {
        
        dateLabel.do {
            $0.text = "2024년 6월 27일"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
        titleLabel.do {
            $0.text = "나랑 스껄 할래?"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 0
        }
        
        coastLabel.do {
            $0.text = "10만원 이하"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
        timeLabel.do {
            $0.text = "6시간"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
        locationLabel.do {
            $0.text = "건대/성수/왕십리"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
    }
    
    
}

extension TitleInfoCell {
    
    func setCell(mainContentsData: MainContents) {
        dateLabel.text = mainContentsData.date
        titleLabel.text = mainContentsData.title
        coastLabel.text = mainContentsData.coast
        timeLabel.text = mainContentsData.time
        locationLabel.text = mainContentsData.location
    }
}
