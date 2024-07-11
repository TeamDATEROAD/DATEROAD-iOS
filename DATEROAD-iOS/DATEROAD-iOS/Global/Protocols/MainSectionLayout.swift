//
//  MainSectionLayout.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

protocol MainSectionLayout {
    
    var itemSize: NSCollectionLayoutSize { get }
    
    var groupSize: NSCollectionLayoutSize { get }
        
    var itemContentInset: NSDirectionalEdgeInsets { get }
    
    var groupContentInset: NSDirectionalEdgeInsets { get }

    var sectionContentInset: NSDirectionalEdgeInsets { get }
    
    var headerContentInset: NSDirectionalEdgeInsets { get }
    
    var elementKind: String? { get }
    
    var supplemetaryItemSize: NSCollectionLayoutSize { get }

    var supplementaryAlignment: NSRectAlignment { get }
    
    var scrollDirection: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
    
}

extension MainSectionLayout {
    var itemSize: NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    }
    
    var itemContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets.zero
    }
    
    var groupContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets.zero
    }
    
    var headerContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets.zero
    }
    
    var sectionContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    }
    
    var elementKind: String? {
        return nil
    }
    
    var supplemetaryItemSize: NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .estimated(0))
    }
    
    var supplementaryAlignment: NSRectAlignment {
        return .top
    }
    
    var scrollDirection: UICollectionLayoutSectionOrthogonalScrollingBehavior {
        return .paging
    }
}

struct UpcomingDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
            
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
}

struct HotDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(238), heightDimension: .estimated(356))
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var elementKind: String? = MainHeaderView.elementKinds
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(119))
    
}

struct BannerDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(ScreenUtils.width), heightDimension: .absolute(162))
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets.zero

}

struct NewDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140))
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets.zero
    
    var elementKind: String? = MainHeaderView.elementKinds
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
    
    var scrollDirection: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
    
}
