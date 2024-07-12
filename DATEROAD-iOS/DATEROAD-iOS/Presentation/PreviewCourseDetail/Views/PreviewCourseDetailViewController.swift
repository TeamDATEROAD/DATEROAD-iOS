//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

final class PreviewCourseDetailViewController: BaseViewController, CustomAlertDelegate {

    
    // MARK: - UI Properties
    
    private let previewView: PreviewView
    
    // MARK: - Properties
    
    private let previewCourseDetailViewModel: PreviewCourseDetailViewModel
    
    private var imageData: [ImageModel] = ImageModel.imageContents.map { ImageModel(image: $0) }
    
    private var likeSum: Int = ImageModel.likeSum
    
    private var mainContentsData: MainContentsModel = MainContentsModel.mainContents
    
    private var timelineData: [TimelineModel] = TimelineModel.timelineContents
    
    private var coastData: Int = DateInfoModel.coast
    
    private var tagData: [DateInfoModel] = DateInfoModel.tagContents
    
    private var currentPage: Int = 0
    
    
    init(viewModel: PreviewCourseDetailViewModel) {
        self.previewCourseDetailViewModel = viewModel
        self.previewView = PreviewView(previewCourseDetailSection: self.previewCourseDetailViewModel.sections)
        
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
        
        view.self.addSubview(previewView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
        previewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.view.backgroundColor = UIColor(resource: .drWhite)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
}

private extension PreviewCourseDetailViewController {
    
    func setDelegate() {
        previewView.mainCollectionView.delegate = self
        previewView.mainCollectionView.dataSource = self
    }
    
    func registerCell() {
        previewView.mainCollectionView.do {
            $0.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.cellIdentifier)
            $0.register(TitleInfoCell.self, forCellWithReuseIdentifier: TitleInfoCell.cellIdentifier)
            $0.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.cellIdentifier)
            $0.register(GradientView.self, forSupplementaryViewOfKind: GradientView.elementKinds, withReuseIdentifier: GradientView.identifier)
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
            $0.register(VisitDateView.self, forSupplementaryViewOfKind: VisitDateView.elementKinds, withReuseIdentifier: VisitDateView.identifier)
            $0.register(InfoBarView.self, forSupplementaryViewOfKind: InfoBarView.elementKinds, withReuseIdentifier: InfoBarView.identifier)
            $0.register(ContentMaskView.self, forSupplementaryViewOfKind: ContentMaskView.elementKinds, withReuseIdentifier: ContentMaskView.identifier)
        }
    }
}

extension PreviewCourseDetailViewController: ImageCarouselDelegate {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        currentPage = index
        if let bottomPageControllView = previewView.mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
            bottomPageControllView.pageIndex = currentPage
        }
    }
}

extension PreviewCourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return previewCourseDetailViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = previewCourseDetailViewModel.fetchSection(at: section)
        
        switch sectionType {
        case .imageCarousel:
            return previewCourseDetailViewModel.imageCarouselViewModel.numberOfItems
        default:
            return previewCourseDetailViewModel.numberOfItemsInSection(section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = previewCourseDetailViewModel.fetchSection(at: indexPath.section)
        
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
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == VisitDateView.elementKinds {
            guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VisitDateView.identifier, for: indexPath) as? VisitDateView else { return UICollectionReusableView() }
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
            footer.delegate = self
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
    
}

extension PreviewCourseDetailViewController: ContentMaskViewDelegate {
    
    func didTapReadCourseButton() {
        print("야미")
        let customAlertVC = CustomAlertViewController(
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: StringLiterals.Alert.buyCourse,
            descriptionText: StringLiterals.Alert.canNotRefund,
            rightButtonText: "확인"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
}
