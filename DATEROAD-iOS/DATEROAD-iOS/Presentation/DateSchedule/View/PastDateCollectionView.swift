//
//  PastDateContentView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class PastDateContentView: BaseView {
    
    // MARK: - UI Properties
    
    var pastDateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: pastDateCollectionViewLayout)
    
    // MARK: - Properties
    
    static var pastDateCollectionViewLayout = UICollectionViewFlowLayout()
    
    lazy var pastDateScheduleData = DateScheduleModel(dateCards: [])
    
    var currentIndex: CGFloat = 0
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(pastDateCollectionView)
    }
    
    override func setLayout() {
        pastDateCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        pastDateCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            // $0.showsVerticalScrollIndicator = false
        }
        
        PastDateContentView.pastDateCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = ScreenUtils.width * 0.0427
            $0.itemSize = CGSize(width: ScreenUtils.width * 0.9147, height: ScreenUtils.height*0.25)
        }
        
        register()
        setDelegate()
    }
}

private extension PastDateContentView {
   func register() {
        pastDateCollectionView.register(PastDateCollectionViewCell.self, forCellWithReuseIdentifier: PastDateCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        pastDateCollectionView.delegate = self
    }
}

// MARK: - Delegate

extension PastDateContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PastDateContentView.pastDateCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.04266, bottom: 0, right: ScreenUtils.width * 0.04266)
    }
    
}
