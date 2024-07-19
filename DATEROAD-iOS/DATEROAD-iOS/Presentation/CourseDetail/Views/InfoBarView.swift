//
//  InfoBarView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class InfoBarView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let coastIconImageView = UIImageView(image: .coastIcon)
    
    private let coastLabel = UILabel()
    
    private let timeIconImageView = UIImageView(image: .timeIcon)
    
    private let timeLabel = UILabel()
    
    private let locationIconImageView = UIImageView(image: .locationIcon)
    
    private let locationLabel = UILabel()
    
    // MARK: - Properties
    
    static let elementKinds: String = "infoBarView"
    
    static let identifier: String = "InfoBarView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubviews(
            coastLabel,
            coastIconImageView,
            timeLabel,
            timeIconImageView,
            locationLabel,
            locationIconImageView
        )
    }
    
    func setLayout() {
        
        coastIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(14)
        }
        
        coastLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(3.5)
        }
        
        timeIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalToSuperview().inset(106)
            $0.size.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(3.5)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalToSuperview().inset(202)
            $0.width.equalTo(12)
            $0.height.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationIconImageView)
            $0.leading.equalTo(locationIconImageView.snp.trailing).offset(3.5)
        }
    }
    
    func setStyle() {
      
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

extension InfoBarView {
     
    func bindTitleHeader(titleHeaderData: TitleHeaderModel) {
        print("가격 여기여기",titleHeaderData.cost)
        coastLabel.text = "\(titleHeaderData.cost.priceRangeTag())"
        timeLabel.text = "\(titleHeaderData.totalTime.formatTime())시간"
        locationLabel.text = titleHeaderData.city
    }
}
