//
//  BannerCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

final class BannerCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
        
    lazy var bannerCollectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    
    let indexLabel: DRPaddingLabel = DRPaddingLabel()

    
    // MARK: - Properties
    

    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(bannerCollectionView, indexLabel)
    }
    
    override func setLayout() {
        bannerCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        indexLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(bannerCollectionView).inset(6)
            $0.height.equalTo(19)
        }

    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        bannerCollectionView.do {
            $0.backgroundColor = UIColor(resource: .lightLime)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.isPagingEnabled = true            
//            $0.isScrollEnabled = true
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsHorizontalScrollIndicator = false
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = $0.frame.size
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
        }
 
        indexLabel.do {
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.textColor = UIColor(resource: .drWhite)
            $0.font = UIFont.suit(.cap_reg_11)
            $0.setPadding(top: 2, left: 12, bottom: 2, right: 12)
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
    }
}

extension BannerCell {
    
    // TODO: - 인덱스 바인딩 해주기
    func bindIndexData(currentIndex: Int, count: Int) {
        self.indexLabel.text = "\(currentIndex)/\(count)"
    }
}
