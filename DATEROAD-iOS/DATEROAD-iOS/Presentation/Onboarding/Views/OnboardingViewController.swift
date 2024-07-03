//
//  OnboardingViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let onboardingView = OnboardingView()
    
    
    // MARK: - Properties
    
    private let onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        bindViewModel()
    }
    
    override func setHierarchy() {
        self.view.addSubview(onboardingView)
    }
    
    override func setLayout() {
        onboardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}


// MARK: - Private Methods

private extension OnboardingViewController {
    
    func registerCell() {
        self.onboardingView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.onboardingView.onboardingCollectionView.delegate = self
        self.onboardingView.onboardingCollectionView.dataSource = self
    }
    
    func bindViewModel() {
        self.onboardingViewModel.currentPage.bind { [weak self] page in
            guard let page else { return }
            self?.onboardingView.pageControl.currentPage = page
        }
        
        self.onboardingViewModel.goToNextVC = { [weak self] isLastIndex in
            if isLastIndex {
                let createProfileVC = BaseViewController()
                self?.navigationController?.pushViewController(createProfileVC, animated: true)
            } else {
                let currentOffset = self?.onboardingView.onboardingCollectionView.contentOffset ?? CGPoint.zero
                let offset = CGPoint(x: CGFloat(self?.onboardingViewModel.currentPage.value ?? 0) * (self?.onboardingView.onboardingCollectionView.frame.width ?? 0), y: currentOffset.y)
                self?.onboardingView.onboardingCollectionView.setContentOffset(offset, animated: true)
            }
        }
    }
    
    @objc
    func pushToNextView(_ sender: UIButton) {
        self.onboardingViewModel.handleToIndex()
    }
}


// MARK: - Delegates

extension OnboardingViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.onboardingViewModel.currentPage.value = page
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.onboardingViewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.cellIdentifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setOnboardingData(data: onboardingViewModel.datasource[indexPath.row])
        cell.nextButton.addTarget(self, action: #selector(pushToNextView), for: .touchUpInside)
        return cell
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: ScreenUtils.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
