//
//  BannerDetailView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import UIKit

import SnapKit
import Then

final class BannerDetailView: BaseView {
    
    // MARK: - UI Properties
    
    lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    private let gradientView = GradientView()
    
    let stickyHeaderNavBarView = StickyHeaderNavBarView()
    
    
    // MARK: - Properties
    
    private var bannerDetailSection: [BannerDetailSection]
    
    var isAccess: Bool = false
    
    
    // MARK: - Life Cycle
    
    init(bannerDetailSection: [BannerDetailSection]) {
        self.bannerDetailSection = bannerDetailSection
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setHierarchy() {
        self.addSubviews(mainCollectionView, gradientView, stickyHeaderNavBarView)
    }
    
    override func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        stickyHeaderNavBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIApplication.shared.statusBarFrame.size.height)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        mainCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        stickyHeaderNavBarView.do {
            $0.backgroundColor = .clear
        }
    }
    
}

extension BannerDetailView {
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            switch self.bannerDetailSection[section]  {
            case .imageCarousel:
                return self.makeImageCarouselLayout()
            case .titleInfo:
                return self.makeTitleInfoLayout()
            case .mainContents:
                return self.makeMainContentsLayout()
            }
        }
    }
    
    func makeImageCarouselLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 23, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let footer = makeBottomPageControllView()
        section.boundarySupplementaryItems = [footer]
        
        return section
    }
    
    func makeTitleInfoLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(124))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(124))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let infoBar = makeInfoBarView()
        let date = makeVisitDateView()
        section.boundarySupplementaryItems = [infoBar, date]
        
        return section
    }
    
    func makeMainContentsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func makeBottomPageControllView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(22))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: BottomPageControllView.elementKinds, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: -55))
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return footer
    }
    
    func makeVisitDateView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let dateSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(71))
        let date = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: dateSize, elementKind: BannerInfoHeaderView.elementKinds, alignment: .top, absoluteOffset: CGPoint(x: 0, y: 0))
        date.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 14, trailing: 16)
        return date
    }
    
    func makeInfoBarView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: InfoBarView.elementKinds, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: 0))
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return footer
    }
    
}


