//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

final class PreviewCourseDetailViewController: BaseNavBarViewController, CustomAlertDelegate {

    // MARK: - UI Properties
    
    private let previewView: PreviewView
    
    // MARK: - Properties
    
    private let previewCourseDetailViewModel: PreviewCourseDetailViewModel
    
    private var conditionalModel: ConditionalModel = ConditionalModel.conditionalDummyData
    
    private var imageData: [ImageModel] = ImageModel.imageContents.map { ImageModel(image: $0) }
    
    private var likeSum: Int = ImageModel.likeSum
    
    private var titleHeaderData: TitleHeaderModel = TitleHeaderModel.titleHeaderDummyData
    
    private var mainContentsData: MainContentsModel = MainContentsModel.descriptionDummyData
    
    private var coastData: Int = CoastModel.coastDummyData.totalCoast
    
    private var tagData: [TagModel] = TagModel.tagDummyData
    
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
        setLeftBackButton()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(previewView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
        previewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


extension PreviewCourseDetailViewController: ContentMaskViewDelegate {
    
    func action(rightButtonAction: RightButtonType) {
        
        switch rightButtonAction {
        case .addCourse:
            didTapAddCourseButton()
        case .checkCourse:
            didTapBuyButton()
        case .none:
            return
        }
    }
    
    func didTapButton() {
        
        if conditionalModel.free > 0 {
            didTapFreeViewButton()
        } else {
            didTapReadCourseButton()
        }
    }
    
    func didTapFreeViewButton() {
        let customAlertVC = CustomAlertViewController(
            rightActionType: RightButtonType.checkCourse,
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: "무료 열람 기회를 사용해 보시겠어요?",
            descriptionText: "무료 열람 기회는 한번 사용하면 취소할 수 없어요",
            rightButtonText: "확인"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    func didTapReadCourseButton() {
        let customAlertVC = CustomAlertViewController(
            rightActionType: RightButtonType.checkCourse,
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
    
    func didTapBuyButton(){
        let customAlertVC = CustomAlertViewController(
            rightActionType: RightButtonType.addCourse, 
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: "코스를 열람하기에 포인트가 부족해요",
            descriptionText: "코스를 등록하고 포인트를 모아보세요",
            rightButtonText: "코스 등록하기"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    func didTapAddCourseButton() {
        let addCourseVC = AddCourseFirstViewController()
        self.navigationController?.pushViewController(addCourseVC, animated: false)
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
            print(imageData)
            return imageCarouselCell
        case .titleInfo:
            guard let titleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleInfoCell.cellIdentifier, for: indexPath) as? TitleInfoCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            titleInfoCell.setCell(titleHeaderData: titleHeaderData)
            return titleInfoCell
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.cellIdentifier, for: indexPath) as? MainContentsCell else {
                fatalError("Unable to dequeue MainContentsCell")
            }
            mainContentsCell.mainTextLabel.numberOfLines = 3
            mainContentsCell.setCell(mainContentsData: mainContentsData)
            return mainContentsCell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case VisitDateView.elementKinds:
            return configureVisitDateView(for: collectionView, at: indexPath)
        case InfoBarView.elementKinds:
            return configureInfoBarView(for: collectionView, at: indexPath)
        case GradientView.elementKinds:
            return configureGradientView(for: collectionView, at: indexPath)
        case BottomPageControllView.elementKinds:
            return configureBottomPageControlView(for: collectionView, at: indexPath)
        case ContentMaskView.elementKinds:
            return configureContentMaskView(for: collectionView, at: indexPath)
        default:
            return UICollectionReusableView()
        }
    }

    private func configureVisitDateView(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: VisitDateView.elementKinds, withReuseIdentifier: VisitDateView.identifier, for: indexPath) as? VisitDateView else {
            return UICollectionReusableView()
        }
        visitDate.bindDate(titleHeaderData: titleHeaderData)
        return visitDate
    }

    private func configureInfoBarView(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: InfoBarView.elementKinds, withReuseIdentifier: InfoBarView.identifier, for: indexPath) as? InfoBarView else {
            return UICollectionReusableView()
        }
        footer.bindTitleHeader(titleHeaderData: titleHeaderData)
        return footer
    }

    private func configureGradientView(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let gradient = collectionView.dequeueReusableSupplementaryView(ofKind: GradientView.elementKinds, withReuseIdentifier: GradientView.identifier, for: indexPath) as? GradientView else {
            return UICollectionReusableView()
        }
        return gradient
    }

    private func configureBottomPageControlView(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else {
            return UICollectionReusableView()
        }
        footer.pageIndexSum = imageData.count
        return footer
    }

    private func configureContentMaskView(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: ContentMaskView.elementKinds, withReuseIdentifier: ContentMaskView.identifier, for: indexPath) as? ContentMaskView else {
            return UICollectionReusableView()
        }
        footer.checkFree(conditionalModel: conditionalModel)
        footer.delegate = self
        return footer
    }

}

