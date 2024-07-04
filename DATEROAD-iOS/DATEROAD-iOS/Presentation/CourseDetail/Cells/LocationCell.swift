//
//  LocationCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/4/24.
//

import UIKit

class LocationCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let circleView = UIView()
    
    private let indexNumLabel = UILabel()
    
    private let locationLabel = UILabel()
    
    private let timeBoxView = UIView()
    
    private let timeLabel = UILabel()
    
    // MARK: - Properties
    
    static let identifier: String = "LocationCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationCell {
    func dataBind(_ locationData: CourseDetailContents) {
        if let index = locationData.index {
            indexNumLabel.text = String(index)
        } else {
            indexNumLabel.text = nil
        }
        locationLabel.text = locationData.location
        timeLabel.text = locationData.time
    }
}

// MARK: - Private Methods

private extension LocationCell {
    
    func setHierarchy() {
        self.addSubviews(timelineBackgroundView, circleView, indexNumLabel, locationLabel, timeBoxView, timeLabel)
    }
    
    func setLayout() {
        timelineBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        circleView.snp.makeConstraints {
            $0.leading.equalTo(timelineBackgroundView).inset(13)
            $0.centerY.equalTo(timelineBackgroundView)
            $0.width.height.equalTo(24)
        }
        
        indexNumLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(circleView)
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
            $0.centerX.centerY.equalTo(timeBoxView)
        }
    }
    
    func setStyle() {
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






