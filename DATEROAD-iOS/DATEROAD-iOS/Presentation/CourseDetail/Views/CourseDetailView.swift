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
    
    lazy var mainCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createCompositioinalLayout())
    
    private let gradientView = GradientView()
    
    let stickyHeaderNavBarView = StickyHeaderNavBarView()
    
    private let layoutFactory = DRCompositionalLayoutFactory()
    
    // MARK: - UI Properties
    
    private var courseDetailSection: [CourseDetailSection]
    
    var isAccess: Bool = false
    
    // MARK: - Life Cycle
    
    init(courseDetailSection: [CourseDetailSection]) {
        self.courseDetailSection = courseDetailSection
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setHierarchy() {
        self.addSubviews(mainCollectionView, stickyHeaderNavBarView)
    }
    
    override func setLayout() {
        
        mainCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        stickyHeaderNavBarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(104)
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

extension CourseDetailView {
    
    func createCompositioinalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            switch self.courseDetailSection[section]  {
            case .imageCarousel:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1), itemHeight: .fractionalHeight(1), orthogonalBehavior: .groupPaging, supplementaryItems: [self.makeGradientView(), self.makeBottomPageControllView()], itemInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 23, trailing: 0))
            case .titleInfo:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160), itemHeight: .estimated(160),supplementaryItems: [self.makeInfoBarView(), self.makeVisitDateView()], itemInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            case .mainContents:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50), itemHeight: .estimated(50), supplementaryItems: !self.isAccess ? [self.makeContentMaskView()] : nil, itemInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            case .timelineInfo:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70), itemHeight: .estimated(70), supplementaryItems: [self.makeTimelineHeaderView()], sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0), itemInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            case .coastInfo:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50), itemHeight: .fractionalHeight(1), supplementaryItems: [self.makeHeaderView()], sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0), itemInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            case .tagInfo:
                return self.layoutFactory.createLayout(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30), itemWidth: .estimated(100), itemHeight: .fractionalHeight(1), supplementaryItems: [self.makeHeaderView()], sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 153, trailing: 0), groupInsets: NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16), interItemSpacing: .fixed(7))
            }
        }
    }
    
    func makeGradientView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let gradientSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(104))
        let collectionViewWidth = mainCollectionView.frame.width
        let gradient = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: gradientSize, elementKind: GradientView.elementKinds, alignment: .top, absoluteOffset: CGPoint(x: 0, y: 104))
        
        return gradient
    }

    func makeTimelineHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: TimelineHeaderView.elementKinds, alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16)
        return header
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
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
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
    
    func makeContentMaskView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(360))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: ContentMaskView.elementKinds, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: -50))
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return footer
    }
    
}


