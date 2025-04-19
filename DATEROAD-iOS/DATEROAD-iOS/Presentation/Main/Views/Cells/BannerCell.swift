//
//  BannerCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit


protocol BannerDelegate: AnyObject {
    
    func didSwipeBanner(_ gestureRecognizer: UISwipeGestureRecognizer)
}

final class BannerCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let bannerImage: UIImageView = UIImageView()
    
    
    // MARK: - Properties
    
    weak var delegate: BannerDelegate?
    
    
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
            $0.top.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        bannerImage.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.roundCorners(cornerRadius: 14)
        }
    }
    
}

extension BannerCell {
    
    func setAddGesture() {
        let longPressGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeBanner))
        self.addGestureRecognizer(longPressGesture)
    }
    
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


extension BannerCell {
    
    @objc
    func didSwipeBanner(_ gestureRecognizer: UISwipeGestureRecognizer) {
        delegate?.didSwipeBanner(gestureRecognizer)
    }
    
}
