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
    
    private let bannerDetailView: BannerDetailView = BannerDetailView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    private var deleteCourseSettingView = DeleteCourseSettingView()
    
    private let bannerDetailSkeletonView: BannerDetailSkeletonView = BannerDetailSkeletonView()
    
    
    // MARK: - Properties
    
    private let bannerViewModel: BannerViewModel
    
    
    // MARK: - Life Cycle
    
    init(viewModel: BannerViewModel) {
        self.bannerViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setDelegate()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        self.bannerDetailSkeletonView.isHidden = false
        self.bannerDetailView.isHidden = true
        self.showLoadingView(type: StringLiterals.Amplitude.ViewPath.courseDetail)
        self.bannerViewModel.getBannerDetail()
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

}

private extension BannerDetailViewController {
    
    func setDelegate() {
        bannerDetailView.bannerImageCollectionView.delegate = self
        bannerDetailView.bannerImageCollectionView.dataSource = self
        bannerDetailView.stickyHeaderNavBarView.delegate = self
        bannerDetailView.scrollView.delegate = self
    }

    func setNavBar() {
        bannerDetailView.stickyHeaderNavBarView.hiddenMoreButton(true)
    }
    
    func bindViewModel() {
        self.bannerViewModel.updateBannerDetailData.bind { [weak self] flag in
            guard let flag, let newData = self?.bannerViewModel.bannerDetailData.value else { return }
            if flag {
                self?.bannerViewModel.totalIndex.value = newData?.images.count
                DispatchQueue.main.async {
                    self?.bannerDetailView.updateData(newData)
                    self?.bannerDetailView.bannerImageCollectionView.reloadData()
                }
                self?.bannerViewModel.updateBannerDetailData.value = false
            }
        }
        
        self.bannerViewModel.isSuccessGetBannerData.bind { [weak self] onSuccess in
            guard let onSuccess  else { return }
            self?.bannerViewModel.onLoading.value = !onSuccess
        }
        
        self.bannerViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.bannerViewModel.getBannerDetail()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.bannerViewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.bannerViewModel.onFailNetwork.value = false
                    self?.bannerViewModel.onLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.bannerViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading,
                    let onFailNetwork = self?.bannerViewModel.onFailNetwork.value,
                    let newData = self?.bannerViewModel.bannerDetailData.value
            else { return }
            
            if !onFailNetwork {
                if onLoading {
                    self?.bannerDetailSkeletonView.isHidden = false
                    self?.bannerDetailView.isHidden = true
                    self?.showLoadingView(type: StringLiterals.Amplitude.ViewPath.courseDetail)
                } else {
                    self?.bannerDetailSkeletonView.isHidden = true
                    self?.setNavBar()
                    self?.bannerDetailView.updateData(newData)
                    self?.bannerDetailView.bannerImageCollectionView.reloadData()
                    self?.bannerDetailView.isHidden = false
                    self?.hideLoadingView()
                }
            }
        }
        
        bannerViewModel.currentPage.bind { [weak self] currentPage in
            guard let currentPage, let totalIndex = self?.bannerViewModel.totalIndex.value else { return }
            self?.bannerDetailView.updateIndexLabel(currentPage, totalIndex)
        }
        
    }
    
}


// MARK: - BannerDetailView ScrollView Delegate

extension BannerDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bannerDetailView.stickyHeaderNavBarView.backgroundColor = scrollView.contentOffset.y > ScreenUtils.width ? UIColor.drWhite : UIColor.clear
        bannerDetailView.stickyHeaderNavBarView.updateIconColor(scrollView.contentOffset.y > ScreenUtils.width ? "" : "White")
    }
    
}


// MARK: - UICollectionViewDelegate

extension BannerDetailViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.bannerViewModel.currentPage.value = page
    }

}

extension BannerDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}

extension BannerDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItemsInSection = bannerViewModel.imageData.value?.count else { return 0 }
        bannerViewModel.totalIndex.value = numberOfItemsInSection
        bannerDetailView.updateIndexLabel(0, numberOfItemsInSection)
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bannerImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.cellIdentifier, for: indexPath) as? BannerImageCollectionViewCell,
              let imageData = bannerViewModel.imageData.value
        else {
            return UICollectionViewCell()
        }
        bannerImageCell.setBannerImageData(imageData[indexPath.item])
        return bannerImageCell
    }
    
}


// MARK: - StickyHeaderNavBarViewDelegate

extension BannerDetailViewController: StickyHeaderNavBarViewDelegate {
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: false)
    }
    
}

