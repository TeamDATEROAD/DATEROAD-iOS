//
//  BannerDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import UIKit

import SnapKit
import Then

final class BannerDetailViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let bannerDetailView: BannerDetailView
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    private var deleteCourseSettingView = DeleteCourseSettingView()
    
    private let bannerDetailSkeletonView: BannerDetailSkeletonView = BannerDetailSkeletonView()
    
    
    // MARK: - Properties
    
    private let courseDetailViewModel: CourseDetailViewModel
    
    private var advertismentId: Int
    
    var courseId: Int?
    
    
    // MARK: - Life Cycle
    
    init(viewModel: CourseDetailViewModel, advertismentId: Int) {
        self.courseDetailViewModel = viewModel
        self.advertismentId = advertismentId
        self.bannerDetailView = BannerDetailView(bannerDetailSection: self.courseDetailViewModel.bannerSectionData)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setDelegate()
        registerCell()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        self.bannerDetailSkeletonView.isHidden = false
        self.bannerDetailView.isHidden = true
        self.courseDetailViewModel.getBannerDetail(advertismentId: advertismentId)
        self.showLoadingView(type: StringLiterals.Amplitude.ViewPath.courseDetail)
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubviews(bannerDetailView, bannerDetailSkeletonView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        bannerDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerDetailSkeletonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.view.backgroundColor = UIColor(resource: .drWhite)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    func bindViewModel() {
        self.courseDetailViewModel.isSuccessGetBannerData.bind { [weak self] onSuccess in
            guard let onSuccess  else { return }
            self?.courseDetailViewModel.onLoading.value = !onSuccess
        }
        
        self.courseDetailViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess, let advertisementId = self?.courseDetailViewModel.advertisementId else { return }
            if onSuccess {
                self?.courseDetailViewModel.getBannerDetail(advertismentId: advertisementId)
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.courseDetailViewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.courseDetailViewModel.onFailNetwork.value = false
                    self?.courseDetailViewModel.onLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.courseDetailViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.courseDetailViewModel.onFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.bannerDetailSkeletonView.isHidden = false
                    self?.bannerDetailView.isHidden = true
                    self?.showLoadingView(type: StringLiterals.Amplitude.ViewPath.courseDetail)
                } else {
                    self?.bannerDetailSkeletonView.isHidden = true
                    self?.setNavBar()
                    self?.bannerDetailView.mainCollectionView.reloadData()
                    self?.bannerDetailView.isHidden = false
                    self?.hideLoadingView()
                }
            }
        }
        
        courseDetailViewModel.currentPage.bind { [weak self] currentPage in
            guard let currentPage else { return }
            if let bottomPageControllView = self?.bannerDetailView.mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
                bottomPageControllView.pageIndex = currentPage
            }
        }
    }
    
}

private extension BannerDetailViewController {
    
    func setDelegate() {
        bannerDetailView.mainCollectionView.dataSource = self
        bannerDetailView.stickyHeaderNavBarView.delegate = self
    }
    
    func registerCell() {
        bannerDetailView.mainCollectionView.do {
            $0.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.cellIdentifier)
            $0.register(TitleInfoCell.self, forCellWithReuseIdentifier: TitleInfoCell.cellIdentifier)
            $0.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.cellIdentifier)
            $0.register(BannerInfoHeaderView.self, forSupplementaryViewOfKind: BannerInfoHeaderView.elementKinds, withReuseIdentifier: BannerInfoHeaderView.identifier)
            $0.register(InfoBarView.self, forSupplementaryViewOfKind: InfoBarView.elementKinds, withReuseIdentifier: InfoBarView.identifier)
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
        }
    }
}


extension BannerDetailViewController: ImageCarouselDelegate {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        courseDetailViewModel.didSwipeImage(to: index)
    }
    
}


extension BannerDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return courseDetailViewModel.bannerSectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch courseDetailViewModel.bannerSectionData[indexPath.section] {
        case .imageCarousel:
            guard let imageCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.cellIdentifier, for: indexPath) as? ImageCarouselCell else {
                return UICollectionViewCell()
            }
            let imageData = courseDetailViewModel.imageData.value ?? []
            imageCarouselCell.setPageVC(thumbnailModel: imageData)
            imageCarouselCell.setAccess(isAccess: true)
            imageCarouselCell.delegate = self
            return imageCarouselCell
            
        case .titleInfo:
            guard let titleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleInfoCell.cellIdentifier, for: indexPath) as? TitleInfoCell
            else { return UICollectionViewCell() }
            titleInfoCell.bindBannerTitle(title: courseDetailViewModel.bannerDetailTitle)
            return titleInfoCell
            
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.cellIdentifier, for: indexPath) as? MainContentsCell else { return UICollectionViewCell() }
            let mainData = courseDetailViewModel.mainContentsData.value ?? MainContentsModel(description: "")
            mainContentsCell.setCell(mainContentsData: mainData)
            mainContentsCell.mainTextLabel.numberOfLines = 0
            
            return mainContentsCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let imageData = self.courseDetailViewModel.imageData.value ?? []
        let tagLabel = courseDetailViewModel.bannerHeaderData.value?.tag ?? ""
        let createDate = courseDetailViewModel.bannerHeaderData.value?.createAt ?? ""
        
        switch kind {
        case BannerInfoHeaderView.elementKinds:
            guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerInfoHeaderView.identifier, for: indexPath) as? BannerInfoHeaderView else { return UICollectionReusableView() }
            visitDate.bindTitle(tagLabel: tagLabel, visitDate: createDate)
            return visitDate
            
        case InfoBarView.elementKinds:
            guard let infoView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoBarView.identifier, for: indexPath) as? InfoBarView else { return UICollectionReusableView() }
            infoView.allHidden()
            return infoView
            
        case BottomPageControllView.elementKinds:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else { return UICollectionReusableView() }
            let likeNum = self.courseDetailViewModel.likeSum.value ?? 0
            footer.pageIndexSum = imageData.count
            footer.bindData(like: likeNum)
            footer.hiddenLikeStackView()
            return footer
            
        default :
            return UICollectionReusableView()
        }
    }
    
}

extension BannerDetailViewController {
    
    func setNavBar() {
        bannerDetailView.stickyHeaderNavBarView.moreButton.isHidden = true
    }
    
}


extension BannerDetailViewController: StickyHeaderNavBarViewDelegate {
    
    func didTapMoreButton() {}
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: false)
    }
    
}

