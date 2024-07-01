//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

enum CourseDetailSection {
    case imageCarousel
    case mainContents
    case timelineInfo
    case coastInfo
    case tagInfo
    case like
    
    static let dataSource: [CourseDetailSection] = [
        CourseDetailSection.imageCarousel,
        CourseDetailSection.mainContents,
        CourseDetailSection.timelineInfo,
        CourseDetailSection.coastInfo,
        CourseDetailSection.tagInfo,
        CourseDetailSection.like
    ]
}

class CourseDetailViewController: UIViewController {
    
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    private let dataSource: [CourseDetailSection] = CourseDetailSection.dataSource
    
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
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    private func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            switch self.dataSource[section] {
            case .imageCarousel: return self.makeImageCarouselLayout()
            case .mainContents: return self.makeMainContentsLayout()
            case .timelineInfo: return self.makeTimelineInfoLayout()
            case .coastInfo: return self.makeCoastInfoLayout()
            case .tagInfo: return self.makeTagInfoLayout()
            case .like: return self.makeLikeLayout()
            }
        }
    }
    
    // 레이아웃들
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
}

extension CourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch self.dataSource[indexPath.section] {
        case .imageCarousel:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.identifier, for: indexPath) as! ImageCarouselCell
            cell.backgroundColor = .red
        case .mainContents:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.identifier, for: indexPath) as! MainContentsCell
            cell.backgroundColor = .green
        case .timelineInfo:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineInfoCell.identifier, for: indexPath) as! TimelineInfoCell
            cell.backgroundColor = .blue
        case .coastInfo:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoastInfoCell.identifier, for: indexPath) as! CoastInfoCell
            cell.backgroundColor = .yellow
        case .tagInfo:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagInfoCell.identifier, for: indexPath) as! TagInfoCell
            cell.backgroundColor = .purple
        case .like:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCell.identifier, for: indexPath) as! LikeCell
            cell.backgroundColor = .orange
        }
        
        return cell
    }
}
