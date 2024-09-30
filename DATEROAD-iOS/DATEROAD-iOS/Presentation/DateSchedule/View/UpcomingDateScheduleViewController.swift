//
//  UpcomingDateScheduleViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

final class UpcomingDateScheduleViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var upcomingDateScheduleView = UpcomingDateScheduleView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    private var upcomingDateScheduleViewModel: DateScheduleViewModel
    
    
    // MARK: - LifeCycle
    
    init(upcomingDateScheduleViewModel: DateScheduleViewModel) {
        self.upcomingDateScheduleViewModel = upcomingDateScheduleViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.upcomingDateScheduleViewModel.getUpcomingDateScheduleData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        setAddTarget()
        self.upcomingDateScheduleViewModel.isSuccessGetUpcomingDateScheduleData.value = false
        bindViewModel()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubview(upcomingDateScheduleView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        upcomingDateScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func drawDateCardView() {
        let isEmpty = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count == 0
        upcomingDateScheduleView.emptyView.isHidden = !isEmpty
        upcomingDateScheduleView.cardCollectionView.isHidden = isEmpty
        upcomingDateScheduleView.cardPageControl.isHidden = isEmpty
        if !isEmpty {
            upcomingDateScheduleView.cardPageControl.numberOfPages = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
            self.upcomingDateScheduleView.cardCollectionView.reloadData()
        }
    }
    
}


// MARK: - UI Setting Methods

private extension UpcomingDateScheduleViewController {
    
    func setAddTarget() {
        upcomingDateScheduleView.dateRegisterButton.addTarget(self, action: #selector(dateRegisterButtonTapped), for: .touchUpInside)
        
        upcomingDateScheduleView.pastDateButton.addTarget(self, action: #selector(pushToPastDateVC), for: .touchUpInside)
    }
    
    func bindViewModel() {
        self.upcomingDateScheduleViewModel.onUpcomingScheduleLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.upcomingDateScheduleViewModel.onUpcomingScheduleFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView()
                    self?.upcomingDateScheduleView.isHidden = true
                    self?.tabBarController?.tabBar.isHidden = true
                } else {
                    self?.drawDateCardView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self?.upcomingDateScheduleView.isHidden = false
                        self?.tabBarController?.tabBar.isHidden = false
                        self?.hideLoadingView()
                    }
                }
            }
        }
        
        self.upcomingDateScheduleViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.upcomingDateScheduleViewModel.getUpcomingDateScheduleData()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.upcomingDateScheduleViewModel.isSuccessGetUpcomingDateScheduleData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.upcomingDateScheduleViewModel.setUpcomingScheduleLoading()
            }
        }
        
        self.upcomingDateScheduleViewModel.onUpcomingScheduleFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                self?.hideLoadingView()
                let errorVC = DRErrorViewController()
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
    }
    
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
        let pastDateVC = PastDateViewController(pastDateScheduleViewModel: DateScheduleViewModel())
        self.navigationController?.pushViewController(pastDateVC, animated: false)
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
            let vc = AddScheduleFirstViewController(viewModel: AddScheduleViewModel(), viewPath: StringLiterals.Amplitude.ViewPath.dateSchedule)
            self.navigationController?.pushViewController(vc, animated: false)
        }
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickAddSchedule)
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenUtils.width * 0.0693
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = ScreenUtils.width * 0.776 + ScreenUtils.width * 0.0693
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        self.upcomingDateScheduleViewModel.currentIndex.value = Int(roundedIndex)
        upcomingDateScheduleView.cardPageControl.currentPage = Int(roundedIndex)
    }
    
}


// MARK: - DataSource

extension UpcomingDateScheduleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.item] ?? DateCardModel.emptyModel
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(data, indexPath.item)
        cell.setColor(index: indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc
    func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: upcomingDateScheduleView.cardCollectionView)
        if let indexPath = upcomingDateScheduleView.cardCollectionView.indexPathForItem(at: location) {
            let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.item] ?? DateCardModel.emptyModel
            let upcomingDateDetailVC = UpcomingDateDetailViewController(dateID: data.dateID, viewPath: StringLiterals.TabBar.date, upcomingDateDetailViewModel: DateDetailViewModel()
            )
            upcomingDateDetailVC.setColor(index: indexPath.item)
            self.navigationController?.pushViewController(upcomingDateDetailVC, animated: false)
        }
    }
    
}
