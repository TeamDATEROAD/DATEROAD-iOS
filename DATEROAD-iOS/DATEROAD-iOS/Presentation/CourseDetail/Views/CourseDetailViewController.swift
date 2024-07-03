//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

final class CourseDetailViewController: BaseNavBarViewController {
    
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    private let bottomPageControlView = BottomPageControllView()
    
    private let viewModel: CourseDetailViewModel
    
    private var mainData: [CourseDetailContents] = CourseDetailContents.images.map { CourseDetailContents(image: $0) }
    
    private var currentPage: Int = 0
    
    init(viewModel: CourseDetailViewModel = CourseDetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        registerCell()
    }
    
    override func setHierarchy() {
        self.view.addSubview(mainCollectionView)
    }
    
    override func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.mainCollectionView.backgroundColor = UIColor(resource: .drWhite)
    }
    
    private func setDelegate() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
}

private extension CourseDetailViewController {
    
    func registerCell() {
        mainCollectionView.do {
            $0.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.identifier)
            $0.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.identifier)
            $0.register(TimelineInfoCell.self, forCellWithReuseIdentifier: TimelineInfoCell.identifier)
            $0.register(CoastInfoCell.self, forCellWithReuseIdentifier: CoastInfoCell.identifier)
            $0.register(TagInfoCell.self, forCellWithReuseIdentifier: TagInfoCell.identifier)
            $0.register(LikeCell.self, forCellWithReuseIdentifier: LikeCell.identifier)
            
            $0.register(InfoHeaderView.self, forSupplementaryViewOfKind: InfoHeaderView.elementKinds, withReuseIdentifier: InfoHeaderView.identifier)
            
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
   
        }
    }
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            let sectionType = self.viewModel.fetchSection(at: section)
            
            switch sectionType {
            case .imageCarousel: return self.makeImageCarouselLayout()
            case .mainContents: return self.makeMainContentsLayout()
            case .timelineInfo: return self.makeTimelineInfoLayout()
            case .coastInfo: return self.makeCoastInfoLayout()
            case .tagInfo: return self.makeTagInfoLayout()
            case .like: return self.makeLikeLayout()
            }
        }
    }
    
    func makeLayoutSection(itemInsets: NSDirectionalEdgeInsets, groupSize: NSCollectionLayoutSize, orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, hasHeader: Bool = false, hasFooter: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = itemInsets
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        
        if hasHeader {
            let header = makeHeaderView()
            section.boundarySupplementaryItems = [header]
        }
        
        if hasFooter {
            let footer = makeBottomPageControllView()
            section.boundarySupplementaryItems = [footer]
        }
        
        return section
    }
    
    func makeImageCarouselLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging, hasFooter: true)
    }
    
    func makeMainContentsLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging)
    }
    
    func makeTimelineInfoLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging, hasHeader: true)
    }
    
    func makeCoastInfoLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging, hasHeader: true)
    }
    
    func makeTagInfoLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging, hasHeader: true)
    }
    
    func makeLikeLayout() -> NSCollectionLayoutSection {
        let itemInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        return makeLayoutSection(itemInsets: itemInsets, groupSize: groupSize, orthogonalScrollingBehavior: .groupPaging)
    }
    
    func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: InfoHeaderView.elementKinds, alignment: .top)
        return header
    }
    
    func makeBottomPageControllView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: BottomPageControllView.elementKinds, alignment: .bottom)
        return footer
    }
}

extension CourseDetailViewController: ImageCarouselDelegate {
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        currentPage = index
        if let bottomPageControllView = mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
            bottomPageControllView.pageIndex = currentPage
        }
    }
}

extension CourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        let sectionType = viewModel.fetchSection(at: indexPath.section)
        
        switch sectionType {
        case .imageCarousel:
            guard let imageCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as? ImageCarouselCell else {
                fatalError("Unable to dequeue ImageCarouselCell")
            }
            imageCarouselCell.setPageVC(imageData: mainData)
            imageCarouselCell.delegate = self
            cell = imageCarouselCell
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.identifier, for: indexPath) as? MainContentsCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            cell = mainContentsCell
        case .timelineInfo:
            guard let timelineInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineInfoCell.identifier, for: indexPath) as? TimelineInfoCell else {
                fatalError("Unable to dequeue TimelineInfoCell")
            }
            cell = timelineInfoCell
        case .coastInfo:
            guard let coastInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoastInfoCell.identifier, for: indexPath) as? CoastInfoCell else {
                fatalError("Unable to dequeue CoastInfoCell")
            }
            cell = coastInfoCell
        case .tagInfo:
            guard let tagInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagInfoCell.identifier, for: indexPath) as? TagInfoCell else {
                fatalError("Unable to dequeue TagInfoCell")
            }
            cell = tagInfoCell
        case .like:
            guard let likeCell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCell.identifier, for: indexPath) as? LikeCell else {
                fatalError("Unable to dequeue LikeCell")
            }
            cell = likeCell
            cell.backgroundColor = .red
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == InfoHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else { return UICollectionReusableView() }
            switch viewModel.fetchSection(at: indexPath.section) {
            case .timelineInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.timelineInfoLabel)
            case .coastInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.coastInfoLabel)
            case .tagInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.tagInfoLabel)
            default:
                break
            }
            return header
        } else if kind == BottomPageControllView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else { return UICollectionReusableView() }
            footer.pageIndexSum = mainData.count
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
}
