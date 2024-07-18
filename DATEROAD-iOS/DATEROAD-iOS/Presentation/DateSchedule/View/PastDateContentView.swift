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
    
    var emptyView = CustomEmptyView()
    
    // MARK: - Properties
    
    static var pastDateCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(pastDateCollectionView, emptyView)
    }
    
    override func setLayout() {
        pastDateCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenUtils.height * 84 / 812)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 444/812)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        pastDateCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.showsVerticalScrollIndicator = true
        }
        
        PastDateContentView.pastDateCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = ScreenUtils.width * 0.0427
            $0.itemSize = CGSize(width: ScreenUtils.width * 0.9147, height: ScreenUtils.height*0.25)
        }
        
        emptyView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .emptyPastSchedule), emptyTitle: StringLiterals.EmptyView.emptyPastSchedule)
        }
    }
}
