//
//  LocationCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/4/24.
//

import UIKit

final class TimelineInfoCell: BaseCollectionViewCell {

    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let circleView = UIView()
    
    private let indexNumLabel = UILabel()
    
    private let locationLabel = UILabel()
    
    private let timeBoxView = UIView()
    
    private let timeLabel = UILabel()
    
    override func setHierarchy() {
        self.addSubviews(
            timelineBackgroundView,
            circleView,
            indexNumLabel,
            locationLabel,
            timeBoxView,
            timeLabel
        )
    }
    
    override func setLayout() {
        timelineBackgroundView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        circleView.snp.makeConstraints {
            $0.leading.equalTo(timelineBackgroundView).inset(13)
            $0.centerY.equalTo(timelineBackgroundView)
            $0.size.equalTo(24)
        }
        
        indexNumLabel.snp.makeConstraints {
            $0.center.equalTo(circleView)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.trailing).offset(13)
            $0.centerY.equalTo(timelineBackgroundView)
        }
        
        timeBoxView.snp.makeConstraints {
            $0.trailing.equalTo(timelineBackgroundView).inset(13)
            $0.centerY.equalTo(timelineBackgroundView)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
        
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(timeBoxView)
        }
    }
    
    override func setStyle() {
        timelineBackgroundView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 14
        }
        
        circleView.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.layer.cornerRadius = 12
        }
        
        indexNumLabel.do {
            $0.text = "1"
            $0.font = UIFont.suit(.body_bold_13)
            $0.textColor = UIColor(resource: .drWhite)
        }
        
        locationLabel.do {
            $0.text = "성수 미술관 성수점"
            $0.font = UIFont.suit(.body_bold_15)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        timeBoxView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
        }
        
        timeLabel.do {
            $0.text = "1시간"
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
    }
}

extension TimelineInfoCell {
    
    func setCell(timelineData: TimelineModel) {
        print(timelineData,"🌀") // 데이터 로그 확인
        indexNumLabel.text = "\(timelineData.sequence)"
        locationLabel.text = timelineData.title
        timeLabel.text = "\(timelineData.duration.formatFloatTime())시간"
    }
}

