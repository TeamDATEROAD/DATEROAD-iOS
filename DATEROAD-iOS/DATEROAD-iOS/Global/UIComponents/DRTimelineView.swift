//
//  DRTimelineView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 3/24/25.
//

import UIKit

final class DRTimelineView: BaseView {
    
    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let circleView = UIView()
    
    let indexNumLabel = UILabel()
    
    let locationLabel = UILabel()
    
    private let timeBoxView = UIView()
    
    let timeLabel = UILabel()
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(timelineBackgroundView,
                         circleView,
                         indexNumLabel,
                         locationLabel,
                         timeBoxView,
                         timeLabel)
    }
    
    override func setLayout() {
        timelineBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(54)
            $0.width.equalTo(ScreenUtils.width * 343 / 375)
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
            $0.backgroundColor = UIColor(resource: .purple600)
            $0.layer.cornerRadius = 12
        }
        
        timeBoxView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
        }
    }
    
}







