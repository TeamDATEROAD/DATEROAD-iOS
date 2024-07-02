//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

class CourseDetailViewController: UIViewController {
    
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    private let bottomPageControlView = BottomPageControllView()
    
    private let viewModel: CourseDetailViewModel
    
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
        registerCell()
    }
    
    func setHierarchy() {
        self.view.addSubview(mainCollectionView)
    }
    
    func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.mainCollectionView.backgroundColor = UIColor.white
    }
    
    private func registerCell() {
        mainCollectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.identifier)
        mainCollectionView.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.identifier)
        mainCollectionView.register(TimelineInfoCell.self, forCellWithReuseIdentifier: TimelineInfoCell.identifier)
        mainCollectionView.register(CoastInfoCell.self, forCellWithReuseIdentifier: CoastInfoCell.identifier)
        mainCollectionView.register(TagInfoCell.self, forCellWithReuseIdentifier: TagInfoCell.identifier)
        mainCollectionView.register(LikeCell.self, forCellWithReuseIdentifier: LikeCell.identifier)
        
        mainCollectionView.register(InfoHeaderView.self, forSupplementaryViewOfKind: InfoHeaderView.elementKinds, withReuseIdentifier: InfoHeaderView.identifier)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }

    
    private func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            let sectionType = self.viewModel.section(at: section)
            
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
    
    // 섹션 레이아웃들
    private func makeImageCarouselLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func makeMainContentsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func makeTimelineInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func makeCoastInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func makeTagInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func makeLikeLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: InfoHeaderView.elementKinds, alignment: .top)
        return header
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
        
        let sectionType = viewModel.section(at: indexPath.section)
        
        switch sectionType {
        case .imageCarousel:
            let imageCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as! ImageCarouselCell
            imageCarouselCell.backgroundColor = .red
            cell = imageCarouselCell
        case .mainContents:
            let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.identifier, for: indexPath) as! MainContentsCell
            mainContentsCell.backgroundColor = .green
            cell = mainContentsCell
        case .timelineInfo:
            let timelineInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineInfoCell.identifier, for: indexPath) as! TimelineInfoCell
            timelineInfoCell.backgroundColor = .blue
            cell = timelineInfoCell
        case .coastInfo:
            let coastInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoastInfoCell.identifier, for: indexPath) as! CoastInfoCell
            coastInfoCell.backgroundColor = .yellow
            cell = coastInfoCell
        case .tagInfo:
            let tagInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagInfoCell.identifier, for: indexPath) as! TagInfoCell
            tagInfoCell.backgroundColor = .purple
            cell = tagInfoCell
        case .like:
            let likeCell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCell.identifier, for: indexPath) as! LikeCell
            likeCell.backgroundColor = .orange
            cell = likeCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == InfoHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else { return UICollectionReusableView() }
            switch viewModel.section(at: indexPath.section) {
            case .timelineInfo:
                header.bindTitle(headerTitle: "코스 타임라인")
            case .coastInfo:
                header.bindTitle(headerTitle: "총 비용")
            case .tagInfo:
                header.bindTitle(headerTitle: "태그")
            default:
                break
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}
