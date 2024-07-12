//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class CourseDetailViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let courseDetailView: CourseDetailView
    
    // MARK: - Properties
    
    private let courseDetailViewModel: CourseDetailViewModel
    
    private var imageData: [ImageModel] = ImageModel.imageContents.map { ImageModel(image: $0) }
    
    private var likeSum: Int = ImageModel.likeSum
    
    private var mainContentsData: MainContentsModel = MainContentsModel.mainContents
    
    private var timelineData: [TimelineModel] = TimelineModel.timelineContents
    
    private var coastData: Int = DateInfoModel.coast
    
    private var tagData: [DateInfoModel] = DateInfoModel.tagContents
    
    private var currentPage: Int = 0
    
    
    init(viewModel: CourseDetailViewModel) {
        self.courseDetailViewModel = viewModel
        self.courseDetailView = CourseDetailView(courseDetailSection: self.courseDetailViewModel.sections)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerCell()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        view.self.addSubview(courseDetailView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
        courseDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.view.backgroundColor = UIColor(resource: .drWhite)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
}

private extension CourseDetailViewController {
    
    func setDelegate() {
        courseDetailView.mainCollectionView.delegate = self
        courseDetailView.mainCollectionView.dataSource = self
    }
    
    func registerCell() {
        courseDetailView.mainCollectionView.do {
            $0.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.cellIdentifier)
            
            $0.register(TitleInfoCell.self, forCellWithReuseIdentifier: TitleInfoCell.cellIdentifier)
            
            $0.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.cellIdentifier)
            
            $0.register(TimelineInfoCell.self, forCellWithReuseIdentifier: TimelineInfoCell.cellIdentifier)
            
            $0.register(CoastInfoCell.self, forCellWithReuseIdentifier: CoastInfoCell.cellIdentifier)
            
            $0.register(TagInfoCell.self, forCellWithReuseIdentifier: TagInfoCell.cellIdentifier)
            
            $0.register(VisitDateView.self, forSupplementaryViewOfKind: VisitDateView.elementKinds, withReuseIdentifier: VisitDateView.identifier)
            
            $0.register(InfoBarView.self, forSupplementaryViewOfKind: InfoBarView.elementKinds, withReuseIdentifier: InfoBarView.identifier)
            
            $0.register(InfoHeaderView.self, forSupplementaryViewOfKind: InfoHeaderView.elementKinds, withReuseIdentifier: InfoHeaderView.identifier)
            
            $0.register(GradientView.self, forSupplementaryViewOfKind: GradientView.elementKinds, withReuseIdentifier: GradientView.identifier)
            
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
        }
    }
}

extension CourseDetailViewController: ImageCarouselDelegate {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        currentPage = index
        if let bottomPageControllView = courseDetailView.mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
            bottomPageControllView.pageIndex = currentPage
        }
    }
}

extension CourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return courseDetailViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = courseDetailViewModel.fetchSection(at: section)
        
        switch sectionType {
        case .imageCarousel:
            return courseDetailViewModel.imageCarouselViewModel.numberOfItems
        default:
            return courseDetailViewModel.numberOfItemsInSection(section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = courseDetailViewModel.fetchSection(at: indexPath.section)
        
        switch sectionType {
        case .imageCarousel:
            guard let imageCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.cellIdentifier, for: indexPath) as? ImageCarouselCell else {
                fatalError("Unable to dequeue ImageCarouselCell")
            }
            imageCarouselCell.setPageVC(imageData: imageData)
            imageCarouselCell.delegate = self
            return imageCarouselCell
            
        case .titleInfo:
            guard let titleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleInfoCell.cellIdentifier, for: indexPath) as? TitleInfoCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            titleInfoCell.setCell(mainContentsData: mainContentsData)
            return titleInfoCell
            
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.cellIdentifier, for: indexPath) as? MainContentsCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            mainContentsCell.setCell(mainContentsData: mainContentsData)
            return mainContentsCell
            
        case .timelineInfo:
            guard let timelineInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineInfoCell.cellIdentifier, for: indexPath) as? TimelineInfoCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            timelineInfoCell.setCell(timelineData[indexPath.row])
            return timelineInfoCell
            
        case .coastInfo:
            guard let coastInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoastInfoCell.cellIdentifier, for: indexPath) as? CoastInfoCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            coastInfoCell.setCell(coastData: coastData)
            return coastInfoCell
        case .tagInfo:
            guard let tagInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagInfoCell.cellIdentifier, for: indexPath) as? TagInfoCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            tagInfoCell.setCell(tagData: tagData[indexPath.row])
            return tagInfoCell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == VisitDateView.elementKinds {
            guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VisitDateView.identifier, for: indexPath) as? VisitDateView else {
                return UICollectionReusableView()
            }
            return visitDate
        } else if kind == InfoBarView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoBarView.identifier, for: indexPath) as? InfoBarView else { return UICollectionReusableView() }
            return footer
        } else if kind == GradientView.elementKinds {
            guard let gradient = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GradientView.identifier, for: indexPath) as? GradientView else { return UICollectionReusableView() }
            return gradient
        } else if kind == BottomPageControllView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else { return UICollectionReusableView() }
            footer.pageIndexSum = imageData.count
            return footer
        } else if kind == ContentMaskView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentMaskView.identifier, for: indexPath) as? ContentMaskView else { return UICollectionReusableView() }
            return footer
        } else if kind == InfoHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else { return UICollectionReusableView() }
            switch courseDetailViewModel.fetchSection(at: indexPath.section) {
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
        } else {
            return UICollectionReusableView()
        }
    }
    
}

