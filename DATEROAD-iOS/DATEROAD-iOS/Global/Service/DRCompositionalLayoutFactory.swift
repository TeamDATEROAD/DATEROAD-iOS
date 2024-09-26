//
//  DRCompositionalLayoutFactory.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 9/11/24.
//

import UIKit

final class DRCompositionalLayoutFactory {
    
    func createLayout(
        widthDimension: NSCollectionLayoutDimension,
        heightDimension: NSCollectionLayoutDimension,
        itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1),
        itemHeight: NSCollectionLayoutDimension,
        orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]? = nil,
        sectionInsets: NSDirectionalEdgeInsets = .zero,
        itemInsets: NSDirectionalEdgeInsets = .zero,
        groupInsets: NSDirectionalEdgeInsets = .zero,
        interItemSpacing: NSCollectionLayoutSpacing? = nil
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = itemInsets
        
        let groupSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = groupInsets
        group.interItemSpacing = interItemSpacing
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalBehavior
        section.contentInsets = sectionInsets
        
        if let supplementaryItems = supplementaryItems {
            section.boundarySupplementaryItems = supplementaryItems
        }
        
        return section
    }
    
}
