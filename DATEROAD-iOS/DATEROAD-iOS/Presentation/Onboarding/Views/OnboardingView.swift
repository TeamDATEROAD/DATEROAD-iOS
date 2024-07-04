//
//  OnboardingView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

final class OnboardingView: BaseView {
    
    // MARK: - UI Properties

    let onboardingCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let pageControl: UIPageControl = UIPageControl()
    
    
    // MARK: - Properties
    

    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(onboardingCollectionView, pageControl)
    }
    
    override func setLayout() {
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(35)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
    }
    
    override func setStyle() {
        onboardingCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.contentInsetAdjustmentBehavior = .never
            $0.isPagingEnabled = true
            $0.isScrollEnabled = true
        }
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(resource: .gray200)
            $0.currentPageIndicatorTintColor = UIColor(resource: .deepPurple)
        }
    }
    
}
