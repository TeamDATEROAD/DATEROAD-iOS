//
//  MainContentsCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class MainContentsCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let dateLabel = UILabel()
    
    private let titleLabel = UILabel()
    
    private let coastIconImageView = UIImageView(image: .coastIcon)
    
    private let coastLabel = UILabel()
    
    private let timeIconImageView = UIImageView(image: .coastIcon)
    
    private let timeLabel = UILabel()
    
    private let locationIconImageView = UIImageView(image: .coastIcon)
    
    private let locationLabel = UILabel()
    
    private let mainTextLabel = UILabel()

    
    // MARK: - Properties
    
    static let identifier: String = "MainContentsCell"

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension MainContentsCell {
    
    func setHierarchy() {
        self.addSubviews(dateLabel, titleLabel, coastLabel, coastIconImageView, timeLabel, timeIconImageView, locationLabel,locationIconImageView, mainTextLabel )
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        
        coastIconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(14)
        }
        
        coastLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(5)
        }
        
        timeIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(coastLabel.snp.trailing).offset(-37)
            $0.width.height.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(5)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(timeLabel.snp.trailing).offset(-42)
            $0.width.equalTo(12)
            $0.height.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(5)
        }
        
        mainTextLabel.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(47)
        }
    
    }
    
    func setStyle() {
        dateLabel.do {
            $0.text = "2024.06.27"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
        titleLabel.do {
            $0.text = "2024.06.27"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        coastLabel.do {
            $0.text = "2024.06.27"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        timeLabel.do {
            $0.text = "6시간"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        locationLabel.do {
            $0.text = "건대/성수/왕십리"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        mainTextLabel.do {
            $0.text = "5년차 장기연애 커플이 보장하는 성수동 당일치기 데이트 코스를 소개해 드릴게요. 저희 커플은 12시에 만나서 브런치 집을 갔어요. 여기에서는 프렌치 토스트를 꼭 시키세요. 강추합니다."
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
        }

    }

}




