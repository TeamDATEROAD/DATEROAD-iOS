//
//  BannerImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/27/25.
//

import UIKit

final class BannerImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let bannerImage: UIImageView = UIImageView()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.contentView.addSubview(bannerImage)
    }
    
    override func setLayout() {
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bannerImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        bannerImage.contentMode = .scaleAspectFill
    }
    
}


// MARK: - Methods

extension BannerImageCollectionViewCell {
    
    // 배너 상세 이미지 데이터를 세팅해주는 메소드
    func setBannerImageData(_ data: ThumbnailModel) {
        self.bannerImage.kfSetImage(with: data.imageUrl)
    }
    
}
