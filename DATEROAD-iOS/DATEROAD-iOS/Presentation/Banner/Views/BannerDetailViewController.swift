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
    
    private let loadingView: DRLoadingView = DRLoadingView()
    
    //    private let courseInfoTabBarView = CourseBottomTabBarView()
    
    private var deleteCourseSettingView = DeleteCourseSettingView()
    
    // MARK: - Properties
    
    private let courseDetailViewModel: CourseDetailViewModel
    
    private var currentPage: Int = 0
    
    var courseId: Int?
    
    init(viewModel: CourseDetailViewModel, advertismentId: Int) {
        self.courseDetailViewModel = viewModel
        self.courseDetailViewModel.getBannerDetail(advertismentId: advertismentId)
        
        self.bannerDetailView = BannerDetailView(bannerDetailSection: self.courseDetailViewModel.bannerSectionData)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //            setSetctionCount()
        bindViewModel()
        setDelegate()
        registerCell()
        
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubviews(loadingView, bannerDetailView)
        //                              , courseInfoTabBarView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerDetailView.snp.makeConstraints {
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
        self.courseDetailViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading else { return }
            self?.loadingView.isHidden = !onLoading
            self?.bannerDetailView.isHidden = onLoading
        }
        
        courseDetailViewModel.currentPage.bind { [weak self] currentPage in
            guard let self = self else { return }
            if let bottomPageControllView = self.bannerDetailView.mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
                bottomPageControllView.pageIndex = currentPage ?? 0
            }
        }
        
        courseDetailViewModel.isSuccessGetBannerData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }            
            if isSuccess {
                self?.setNavBar()
                self?.bannerDetailView.mainCollectionView.reloadData()
            }
        }
    }
    
}

private extension BannerDetailViewController {
    
    func setDelegate() {
        bannerDetailView.mainCollectionView.delegate = self
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
            
            
            $0.register(GradientView.self, forSupplementaryViewOfKind: GradientView.elementKinds, withReuseIdentifier: GradientView.identifier)
            
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
        }
    }
}


extension BannerDetailViewController: ImageCarouselDelegate {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        courseDetailViewModel.didSwipeImage(to: index)
    }
}

extension BannerDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.courseDetailViewModel.setBannerDetailLoading()
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
            guard let titleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleInfoCell.cellIdentifier, for: indexPath) as? TitleInfoCell else {
                return UICollectionViewCell()
            }
            titleInfoCell.bindBannerTitle(title: courseDetailViewModel.bannerDetailTitle)
            return titleInfoCell
            
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.cellIdentifier, for: indexPath) as? MainContentsCell else {
                return UICollectionViewCell()
            }
            let mainData = courseDetailViewModel.mainContentsData.value ?? MainContentsModel(description: "")
            mainContentsCell.setCell(mainContentsData: mainData)
            mainContentsCell.mainTextLabel.numberOfLines = 0
            
            return mainContentsCell
        }
        
    }
    
    // TODO: - switch 문으로 변경
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let imageData = self.courseDetailViewModel.imageData.value ?? []
        let tagLabel = courseDetailViewModel.bannerHeaderData.value?.tag ?? ""
        let createDate = courseDetailViewModel.bannerHeaderData.value?.createAt ?? ""
        
        if kind == BannerInfoHeaderView.elementKinds {
            guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerInfoHeaderView.identifier, for: indexPath) as? BannerInfoHeaderView else {
                return UICollectionReusableView()
            }
            visitDate.bindTitle(tagLabel: tagLabel, visitDate: createDate)
            return visitDate
        } else if kind == InfoBarView.elementKinds {
            guard let infoView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoBarView.identifier, for: indexPath) as? InfoBarView else {
                return UICollectionReusableView()
            }
            infoView.allHidden()
            return infoView
        } else if kind == GradientView.elementKinds {
            guard let gradient = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GradientView.identifier, for: indexPath) as? GradientView else { return UICollectionReusableView() }
            return gradient
        } else if kind == BottomPageControllView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else { return UICollectionReusableView() }
            let likeNum = self.courseDetailViewModel.likeSum.value ?? 0
            footer.pageIndexSum = imageData.count
            footer.bindData(like: likeNum)
            footer.hiddenLikeStackView()
            return footer
        } else {
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
    
    func didTapDeleteButton() {}
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

