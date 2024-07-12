//
//  CourseDetailView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class CourseDetailView: BaseView {
    
    // MARK: - UI Properties
    
    lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())

    
    // MARK: - UI Properties
    
    private var courseDetailSection: [CourseDetailSection]
    
    // MARK: - Life Cycle
    
    init(courseDetailSection: [CourseDetailSection]) {
        self.courseDetailSection = courseDetailSection
        
        super.init(frame: .zero)
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
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
    }
    
}

extension CourseDetailView {
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            switch self.courseDetailSection[section]  {
            case .imageCarousel: 
                return self.makeImageCarouselLayout()
            case .titleInfo: 
                return self.makeTitleInfoLayout()
            case .mainContents: 
                return self.makeMainContentsLayout()
            case .timelineInfo:
                return self.makeTimelineInfoLayout()
            case .coastInfo: 
                return self.makeCoastInfoLayout()
            case .tagInfo: 
                return self.makeTagInfoLayout()
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
        
        let gradient = makeGradientView()
        let footer = makeBottomPageControllView()
        
        section.boundarySupplementaryItems = [gradient, footer]
        
        return section
    }
    
    func makeTitleInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
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
    
    func makeTimelineInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    
    func makeCoastInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func makeTagInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(7)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 45, trailing: 0)
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    
    func makeGradientView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let gradientSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.27))
        let collectionViewWidth = mainCollectionView.frame.width
        let gradient = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: gradientSize, elementKind: GradientView.elementKinds, alignment: .top, absoluteOffset: CGPoint(x: 0, y: collectionViewWidth * 0.27))
        
        return gradient
    }
    
    func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(37))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: InfoHeaderView.elementKinds, alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16)
        return header
    }
    
    func makeBottomPageControllView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(22))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: BottomPageControllView.elementKinds, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: -55))
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return footer
    }
    
    func makeVisitDateView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let dateSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(21))
        let date = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: dateSize, elementKind: VisitDateView.elementKinds, alignment: .top, absoluteOffset: CGPoint(x: 0, y: -14))
        date.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return date
    }
    
    func makeInfoBarView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(36))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: InfoBarView.elementKinds, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: 20))
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return footer
    }
    
}

