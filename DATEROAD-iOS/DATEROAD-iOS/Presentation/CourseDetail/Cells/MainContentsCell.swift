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
    
    private let timeIconImageView = UIImageView(image: .timeIcon)
    
    private let timeLabel = UILabel()
    
    private let locationIconImageView = UIImageView(image: .locationIcon)
    
    private let locationLabel = UILabel()
    
    let mainTextLabel = UILabel()
    
    
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
        self.addSubviews(
            dateLabel,
            titleLabel,
            coastLabel,
            coastIconImageView,
            timeLabel,
            timeIconImageView,
            locationLabel,
            locationIconImageView,
            mainTextLabel
        )
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
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
            $0.leading.equalTo(coastLabel.snp.trailing).offset(37)
            $0.width.height.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(5)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(timeLabel.snp.trailing).offset(42)
            $0.width.equalTo(12)
            $0.height.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationIconImageView)
            $0.leading.equalTo(locationIconImageView.snp.trailing).offset(5)
        }
        
        mainTextLabel.snp.makeConstraints {
            $0.top.equalTo(locationIconImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34)
        }
        
    }
    
    func setStyle() {
        dateLabel.do {
            $0.text = "2024.06.27"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
        
        titleLabel.do {
            $0.text = "5년차 장기연애 커플이 보장하는 성수동 당일치기 데이트 코스"
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
        
        mainTextLabel.do {
            $0.text = """
    5년차 장기연애 커플이 보장하는 성수동 당일치기 데이트 코스를 소개해 드릴게요.
    저희 커플은 12시에 만나서 브런치 집을 갔어요. 여기에서는 프렌치 토스트를 꼭 시키세요. 강추합니다.

    1시간 정도 밥을 먹고 바로 성수미술관에 가서 그림을 그렸는데요. 물감이 튈 수 있어서 흰색 옷은 피하는 것을 추천드려요. 2시간 정도 소요가 되는데 저희는 예약을 해둬서 웨이팅 없이 바로 입장했고, 네이버 예약을 이용했습니다. 평일 기준 20,000원이니 꼭 예약해서 가세요!
    미술관에서 나와서는 어니언 카페에 가서 팡도르를 먹었습니다. 일찍 안 가면 없다고 하니 꼭 일찍 가세요!
    """
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 0
        }
        
    }
    
    
    
}




