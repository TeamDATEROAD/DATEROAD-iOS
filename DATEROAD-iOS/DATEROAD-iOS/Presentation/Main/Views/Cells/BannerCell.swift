//
//  BannerCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

final class BannerCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let bannerImage: UIImageView = UIImageView()
    
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        self.bannerImage.image = nil
    }
    
    override func setHierarchy() {
        self.addSubviews(bannerImage)
    }
    
    override func setLayout() {
        bannerImage.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(30)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        bannerImage.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
    }
    
}

extension BannerCell {
    
    func bindData(bannerData: BannerModel?) {
        guard let bannerData else { return }
        
        if let url = URL(string: bannerData.imageUrl) {
            self.bannerImage.kf.setImage(with: url,  options: [.transition(.none),
                                                               .cacheOriginalImage,
                                                               .keepCurrentImageWhileLoading])
        } else {
            self.bannerImage.image = UIImage(resource: .imgBanner1)
        }
    }
    
}
