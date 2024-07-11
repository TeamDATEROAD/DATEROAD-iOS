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
    
    var elementKind: String? { get }
    
    var supplemetaryItemSize: NSCollectionLayoutSize { get }

    var supplementaryAlignment: NSRectAlignment { get }
    
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
}

struct UpcomingDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(343/375), heightDimension: .fractionalHeight(184 / 812))
            
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 36, trailing: 16)
    
}

struct HotDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(238/375), heightDimension: .estimated(356))
    
    var groupContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 21, leading: 16, bottom: 0, trailing: 0)
    
//    var elementKind: String? = HotDateCourseHeader.elementKind
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(86/812))
    
}

struct BannerDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(343/375), heightDimension: .fractionalHeight(132 / 812))
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 36, trailing: 16)

}

struct NewDateLayout: MainSectionLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(255 / 812))
    
    var groupContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
    
    var sectionContentInset: NSDirectionalEdgeInsets =  NSDirectionalEdgeInsets(top: 30, leading: 16, bottom: 16, trailing: 16)
    
//    var elementKind: String? = NewDateCourseHeader.elementKind
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(50/812))
    
}
