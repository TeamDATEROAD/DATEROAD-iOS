//
//  BannerDetailSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 10/28/24.
//

import UIKit

final class BannerDetailSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let carouselImageView: UIImageView = UIImageView()
    
    private let bannerTagLabel: UILabel = UILabel()
    
    private let dateLabel: UILabel = UILabel()
    
    private let titleLabel: UILabel = UILabel()
    
    private let firstDetailContentView: DetailContentView = DetailContentView()
    
    private let secondDetailContentView: DetailContentView = DetailContentView()
    
    
    override func setHierarchy() {
        self.addSubviews(carouselImageView,
                         bannerTagLabel,
                         dateLabel,
                         titleLabel,
                         firstDetailContentView,
                         secondDetailContentView)
    }
    
    override func setLayout() {
        carouselImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(carouselImageView.snp.width)
        }
        
        bannerTagLabel.snp.makeConstraints {
            $0.top.equalTo(carouselImageView.snp.bottom).offset(23)
            $0.width.equalTo(70)
            $0.height.equalTo(22)
            $0.leading.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(bannerTagLabel.snp.bottom).offset(14)
            $0.width.equalTo(110)
            $0.height.equalTo(21)
            $0.leading.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        firstDetailContentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(240)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        secondDetailContentView.snp.makeConstraints {
            $0.top.equalTo(firstDetailContentView.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        carouselImageView.image = UIImage(resource: .placeholder)
        
        [bannerTagLabel,
         dateLabel,
         titleLabel
        ].forEach {
            $0.setSkeletonLabel()
        }
    }
    
}
