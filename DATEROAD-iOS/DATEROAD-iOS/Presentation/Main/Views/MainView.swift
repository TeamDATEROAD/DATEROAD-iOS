//
//  MainView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

protocol MainDelegate: AnyObject {
    
    func bindIndex(currentIndex: Int)
    
    func didTapFloatingButton()
    
}

final class MainView: BaseView {
    
    // MARK: - UI Properties
    
    lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCompositionalLayout())
    
    let floatingButton: DRImageButton = DRImageButton(image: UIImage(resource: .icPlus), buttonName: .deepPurple_white_25)
    
    
    // MARK: - Properties
    
    private var mainSectionData: [MainSection]
    
    weak var delegate: MainDelegate?
    
    
    // MARK: - Life Cycles
    
    init(mainSectionData: [MainSection]) {
        self.mainSectionData = mainSectionData
        
        super.init(frame: .zero)
        
        setHierarchy()
        setLayout()
        setStyle()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(mainCollectionView, floatingButton)
    }
    
    override func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setStyle() {
        mainCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func setAddTarget() {
        floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    }
    
}



// MARK: - @objc Methods

extension MainView {
    
    @objc
    func didTapFloatingButton() {
        delegate?.didTapFloatingButton()
    }
    
}


// MARK: - Compositional Layout

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
        
        if type == BannerIndexFooterView.elementKinds {
            section.visibleItemsInvalidationHandler = { (visibleItems, offset, env) in
                let currentPage = Int(max(0, round(offset.x / env.container.contentSize.width)))
                self.delegate?.bindIndex(currentIndex: currentPage)
            }
        }
        return section
    }
    
    func makeSupplementaryLayout(layout: MainSectionLayout, type: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let supplemetaryItemSize = layout.supplemetaryItemSize
        let supplemetaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplemetaryItemSize,
                                                                           elementKind: type,
                                                                           alignment: layout.supplementaryAlignment,
                                                                           absoluteOffset: layout.absoluteOffset)
        return supplemetaryItem
    }
    
}
