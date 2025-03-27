//
//  InfoBarView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class InfoBarView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let coastIconImageView = UIImageView(image: .coastIcon)
    
    private let costLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_gray400))
    
    private let timeIconImageView = UIImageView(image: .timeIcon)
    
    private let timeLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_gray400))
    
    private let locationIconImageView = UIImageView(image: .locationIcon)
    
    private let locationLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_gray400))
    
    
    // MARK: - Properties
    
    static let elementKinds: String = "infoBarView"
    
    static let identifier: String = "InfoBarView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubviews(
            costLabel,
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
        
        costLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(3.5)
        }
        
        timeIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(102)
            $0.size.equalTo(14)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(3.5)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.top.equalTo(coastIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(72)
            $0.width.equalTo(12)
            $0.height.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationIconImageView)
            $0.leading.equalTo(locationIconImageView.snp.trailing).offset(3.5)
        }
    }
    
}

extension InfoBarView {
    
    func bindTitleHeader(titleHeaderData: TitleHeaderModel) {
        print("가격 여기여기",titleHeaderData.cost)
        costLabel.text = "\(titleHeaderData.cost.priceRangeTag())"
        timeLabel.text = "\(titleHeaderData.totalTime.formatTime())시간"
        locationLabel.text = titleHeaderData.city
    }
    
    func allHidden() {
        [costLabel,
         coastIconImageView,
         timeLabel,
         timeIconImageView,
         locationLabel,
         locationIconImageView].forEach {
            $0.isHidden =  true
        }
    }
    
}
