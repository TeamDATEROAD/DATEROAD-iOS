//
//  DateTimeLineCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

//TODO: 민서언니 코드랑 같음 !! -> 나중에 병합
final class DateTimeLineCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let circleView = UIView()
    
    private let indexNumLabel = UILabel()
    
    private let locationLabel = UILabel()
    
    private let timeBoxView = UIView()
    
    private let timeLabel = UILabel()
    
    
    // MARK: - Properties
    
    var dateDetailItemRow: Int?
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_bold_13))
        }
        
        locationLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_15))
        }
        
        timeBoxView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
        }
        
        timeLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_med_13))
        }
    }
    
}

extension DateTimeLineCollectionViewCell {
    
    func dataBind(_ placeData: DatePlaceModel, _ dateDetailItemRow: Int) {
        indexNumLabel.text = "\(placeData.sequence+1)"
        locationLabel.text = placeData.name
        timeLabel.text = "\(placeData.duration) 시간"
        self.dateDetailItemRow = dateDetailItemRow
    }
    
}







