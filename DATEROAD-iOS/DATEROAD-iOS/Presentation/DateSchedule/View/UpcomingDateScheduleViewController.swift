//
//  UpcomingDateScheduleViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateScheduleViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var upcomingDateScheduleView = UpcomingDateScheduleView()
    
    private let loadingView: DRLoadingView = DRLoadingView()

    private let errorView: DRErrorViewController = DRErrorViewController()
    
    // MARK: - Properties
    
    private let upcomingDateScheduleViewModel = DateScheduleViewModel()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(1)
        self.upcomingDateScheduleViewModel.getUpcomingDateScheduleData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bindViewModel()
        self.upcomingDateScheduleViewModel.getUpcomingDateScheduleData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.upcomingDateScheduleViewModel.setUpcomingScheduleLoading()
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setDelegate()
        setUIMethods()
        setAddTarget()
        setEmptyView()
        // bindViewModel()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(loadingView, upcomingDateScheduleView)
    }
    
    override func setLayout() {
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        upcomingDateScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func drawDateCardView() {
        print("draw date card view")
        upcomingDateScheduleView.cardCollectionView.reloadData()
        setUIMethods()
        setEmptyView()
    }
    
}

// MARK: - UI Setting Methods

private extension UpcomingDateScheduleViewController {
    @objc
    func pushToDateRegisterVC() {
        if (upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0) >= 5 {
            dateRegisterButtonTapped()
        } else {
            print("일정 등록으로 이동")
        }
    }
    
    @objc
    func pushToPastDateVC() {
        let pastDateVC = PastDateViewController()
        self.navigationController?.pushViewController(pastDateVC, animated: false)
    }
    
    func setUIMethods() {
        upcomingDateScheduleView.cardPageControl.do {
            $0.numberOfPages = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
        }
        print(upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count)
    }
    
    func setAddTarget() {
        upcomingDateScheduleView.dateRegisterButton.do {
            $0.addTarget(self, action: #selector(dateRegisterButtonTapped), for: .touchUpInside)
        }
        
        upcomingDateScheduleView.pastDateButton.do {
            $0.addTarget(self, action: #selector(pushToPastDateVC), for: .touchUpInside)
        }
    }
    
    func setEmptyView() {
        if upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count == 0 {
            upcomingDateScheduleView.emptyView.isHidden = false
        }
    }
    
    func bindViewModel() {
        self.upcomingDateScheduleViewModel.onUpcomingScheduleFailNetwork.bind { [weak self] onFailure in
             guard let onFailure else { return }
             if onFailure {
                 let errorVC = DRErrorViewController()
                 self?.navigationController?.pushViewController(errorVC, animated: false)
             }
         }

        self.upcomingDateScheduleViewModel.onUpcomingScheduleLoading.bind { [weak self] onLoading in
             guard let onLoading, let onFailNetwork = self?.upcomingDateScheduleViewModel.onUpcomingScheduleFailNetwork.value else { return }
             if !onFailNetwork {
                 self?.loadingView.isHidden = !onLoading
                 self?.upcomingDateScheduleView.isHidden = onLoading
             }
         }
        
        self.upcomingDateScheduleViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.upcomingDateScheduleViewModel.isSuccessGetUpcomingDateScheduleData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess == true {
                print("success 인디케이터")
                self?.drawDateCardView()
            } else {
                print("fail 인디케이터")
            }
        }
    }
    
}

// MARK: - Alert Delegate

extension UpcomingDateScheduleViewController: DRCustomAlertDelegate {
    @objc
    private func dateRegisterButtonTapped() {
        if upcomingDateScheduleViewModel.isMoreThanFiveSchedule {
            let customAlertVC = DRCustomAlertViewController(rightActionType: RightButtonType.none, alertTextType: .hasDecription, alertButtonType: .oneButton, titleText: StringLiterals.Alert.noMoreSchedule, descriptionText: StringLiterals.Alert.noMoreThanFive, longButtonText: StringLiterals.Alert.iChecked)
            customAlertVC.delegate = self
            customAlertVC.modalPresentationStyle = .overFullScreen
            self.present(customAlertVC, animated: false)
        } else {
            print("push to 일정등록하기")
           let vc = AddScheduleFirstViewController(viewModel: AddScheduleViewModel())
           self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
}

// MARK: - CollectionView Methods

private extension UpcomingDateScheduleViewController {
    
    func registerCell() {
        upcomingDateScheduleView.cardCollectionView.register(DateCardCollectionViewCell.self, forCellWithReuseIdentifier: DateCardCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        upcomingDateScheduleView.cardCollectionView.delegate = self
        upcomingDateScheduleView.cardCollectionView.dataSource = self
    }
}

// MARK: - Delegate

extension UpcomingDateScheduleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width * 0.776, height: ScreenUtils.height*0.5)
//        return UpcomingDateScheduleView.dateCardCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenUtils.width * 0.0693
    
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = UpcomingDateScheduleView.dateCardCollectionViewLayout
        
        let cellWidthIncludingSpacing = ScreenUtils.width * 0.776 + ScreenUtils.width * 0.0693
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        self.upcomingDateScheduleViewModel.currentIndex.value = Int(roundedIndex)
        upcomingDateScheduleView.cardPageControl.currentPage = Int(roundedIndex)
        // upcomingDateScheduleView.updatePageControlSelectedIndex(index: Int(roundedIndex))
    }
}

// MARK: - DataSource

extension UpcomingDateScheduleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.item] ?? DateCardModel(dateID: 0, title: "", date: "", city: "", tags: [], dDay: 0)
        print(data)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        print("🥵셀configure중🥵")
        cell.dataBind(data, indexPath.item)
        cell.setColor(index: indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc 
    func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: upcomingDateScheduleView.cardCollectionView)
        if let indexPath = upcomingDateScheduleView.cardCollectionView.indexPathForItem(at: location) {
            let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.item] ?? DateCardModel(dateID: 0, title: "", date: "", city: "", tags: [], dDay: 0)
            let upcomingDateDetailVC = UpcomingDateDetailViewController()
            self.navigationController?.pushViewController(upcomingDateDetailVC, animated: false)
//            upcomingDateDetailVC.upcomingDateScheduleView = upcomingDateScheduleView
            upcomingDateDetailVC.upcomingDateDetailViewModel = DateDetailViewModel(dateID: data.dateID)
            upcomingDateDetailVC.setColor(index: indexPath.item)
        }
    }
    
}
