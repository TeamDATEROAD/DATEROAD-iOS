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
    
    private let indexNumLabel: DRTextLabel = DRTextLabel(title: "1", textLabelType: .clear(.bold13_white))
    
    private let locationLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.systemBold15_black), alignment: .left)
    
    private let timeBoxView = UIView()
    
    private let timeLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_black))
    
    
    // MARK: - Life Cycles
    
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
            $0.trailing.equalTo(timeBoxView.snp.leading).offset(-13)
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
        
        timeBoxView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
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

