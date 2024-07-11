//
//  PointCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import UIKit

import Then

final class PointCollectionView: UICollectionView {
    
    // MARK: - UI Properties
    
    static var pointCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    private var pointData: [PointDetailModel] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = PointCollectionView.pointCollectionViewLayout
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.backgroundColor = .black

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        PointCollectionView.pointCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
        }
    }

}
