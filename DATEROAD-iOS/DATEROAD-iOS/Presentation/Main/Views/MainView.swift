//
//  MainView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

final class MainView: BaseView {
    
    // MARK: - UI Properties
    
   lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCompositionalLayout())
    
    // MARK: - Properties
    
    private var mainSectionData: [MainSection]
    
    init(mainSectionData: [MainSection]) {
        self.mainSectionData = mainSectionData
        
        super.init(frame: .zero)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubview(mainCollectionView)
    }
    
    override func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        mainCollectionView.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.showsVerticalScrollIndicator = false
        }
    }

}

extension MainView {
    
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            switch self.mainSectionData[section] {
            case .upcomingDate:
                return self.makeSectionLayout(layout: UpcomingDateLayout())
            case .hotDateCourse:
                return self.makeSectionLayout(layout: HotDateLayout())
            case .banner:
                return self.makeSectionLayout(layout: BannerDateLayout())
            case .newDateCourse:
                return self.makeSectionLayout(layout: NewDateLayout())
            }
        }
    }
    
    func makeSectionLayout(layout: MainSectionLayout) -> NSCollectionLayoutSection {
        let itemSize = layout.itemSize
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = layout.itemContentInset
        
        let groupSize = layout.groupSize
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = layout.groupContentInset
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = layout.sectionContentInset
        
        guard let type = layout.elementKind else { return section }
        let supplemetaryItem = makeSupplementaryLayout(layout: layout, type: type)
        supplemetaryItem.zIndex = 2
        section.boundarySupplementaryItems = [supplemetaryItem]
        section.orthogonalScrollingBehavior = layout.scrollDirection
        return section
    }
    
    func makeSupplementaryLayout(layout: MainSectionLayout, type: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let supplemetaryItemSize = layout.supplemetaryItemSize
        let supplemetaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplemetaryItemSize,
                                                                           elementKind: type,
                                                                           alignment: layout.supplementaryAlignment)
        return supplemetaryItem
    }
}
