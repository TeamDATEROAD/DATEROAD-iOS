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
    
    var absoluteOffset: CGPoint { get }
    
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
        return NSDirectionalEdgeInsets.zero
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
    
    var absoluteOffset: CGPoint {
        return .zero
    }
}

struct UpcomingDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(185 + UIApplication.shared.statusBarFrame.size.height))
    
}

struct HotDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(254), heightDimension: .estimated(356))
        
    var elementKind: String? = MainHeaderView.elementKinds
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(119))
    
    var scrollDirection: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    
}

struct BannerDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(ScreenUtils.width), heightDimension: .absolute(192))
    
    var elementKind: String? = BannerIndexFooterView.elementKinds
    
    var supplementaryAlignment: NSRectAlignment = .bottom
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
 
    var absoluteOffset: CGPoint = CGPoint(x: -16, y: -55)
    
}

struct NewDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140))
        
    var elementKind: String? = MainHeaderView.elementKinds
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
    
    var scrollDirection: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
    
}
