//
//  PointDetailsViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/3/24.
//

import UIKit

class PointDetailViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let pointDetailView = PointDetailView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    var pointViewModel: PointViewModel
    
    
    // MARK: - LifeCycle
    
    init(pointViewModel: PointViewModel) {
        self.pointViewModel = pointViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.pointViewModel.setPointDetailLoading()
        self.pointViewModel.getPointDetail(nowEarnedPointHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.PointDetail.title, alignment: .center)
        setProfile(userName: pointViewModel.userName, totalPoint: pointViewModel.totalPoint.value ?? 0)
        registerCell()
        setDelegate()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(pointDetailView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        pointDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension PointDetailViewController {
    
    func bindViewModel() {
        self.pointViewModel.totalPoint.bind { [weak self] totalPoint in
            guard let self, let totalPoint else { return }
            pointDetailView.totalPointLabel.text = "\(totalPoint) P"
        }
        
        self.pointViewModel.updateGainedPointData.bind { [weak self] flag in
            guard let flag else { return }
            if flag {
                self?.pointDetailView.pointCollectionView.performBatchUpdates({
                    self?.pointDetailView.pointCollectionView.reloadSections(IndexSet(integer: 0))
                })
                self?.pointViewModel.updateGainedPointData.value = false
            }
        }
        
        self.pointViewModel.updateUsedPointData.bind { [weak self] flag in
            guard let flag else { return }
            if flag {
                self?.pointDetailView.pointCollectionView.performBatchUpdates({
                    self?.pointDetailView.pointCollectionView.reloadSections(IndexSet(integer: 0))
                })
                self?.pointViewModel.updateUsedPointData.value = false
            }
        }
        
        self.pointViewModel.onGetPointDetailFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.pointViewModel.onGetPointDetailFailNetwork.value = false
                    self?.pointViewModel.onGetPointDetailLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.pointViewModel.onGetPointDetailLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.pointViewModel.onGetPointDetailFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView(type: StringLiterals.PointDetail.title)
                    self?.pointDetailView.isHidden = onLoading
                } else {
                    self?.pointDetailView.pointCollectionView.reloadData()
                    self?.pointViewModel.updateData(nowEarnedPointHidden: false)
                    self?.changeSelectedSegmentLayout(isEarnedPointHidden: false)
                    self?.pointDetailView.isHidden = onLoading
                    self?.hideLoadingView()
                }
            }
            self?.pointViewModel.onGetPointDetailLoading.value = nil
        }
        
        self.pointViewModel.isSuccessGetPointInfo.bind { [weak self] _ in
            self?.pointViewModel.setPointDetailLoading()
        }
        
        self.pointViewModel.isSuccessPostPoint.bind { [weak self] isSuccess in
            guard let isSuccess = isSuccess else { return }
            if isSuccess {
                self?.pointViewModel.getPointDetail(nowEarnedPointHidden: false)
            }
        }
        
        self.pointViewModel.onPostPointFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    GoogleAdsManager.shared.loadRewardedAd()
                    self?.pointViewModel.onPostPointFailNetwork.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
    }
    
    func setProfile(userName: String, totalPoint: Int) {
        pointDetailView.userNameLabel.text = "\(userName) 님의 포인트"
        pointDetailView.totalPointLabel.text = "\(totalPoint) P"
    }
 
}


// MARK: - Private Method

private extension PointDetailViewController {
    
    func setSegmentViewHidden(_ view: UIView) {
        pointDetailView.pointCollectionView.isHidden = true
        pointDetailView.emptyUsedPointView.isHidden = true
        pointDetailView.emptyGainedPointView.isHidden = true
        view.isHidden = false
    }
    
    func changeSelectedSegmentLayout(isEarnedPointHidden: Bool?) {
        guard let isEarnedPointHidden = isEarnedPointHidden else { return }
        if isEarnedPointHidden {
            switch pointViewModel.usedPointData.value?.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyUsedPointView)
                pointDetailView.pointCollectionView.reloadData()
            case false:
                setSegmentViewHidden(pointDetailView.pointCollectionView)
                pointDetailView.pointCollectionView.reloadData()
            }
            
            pointDetailView.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().inset(ScreenUtils.width/2)
            }
        } else {
            switch pointViewModel.gainedPointData.value?.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyGainedPointView)
                pointDetailView.pointCollectionView.reloadData()
            case false:
                setSegmentViewHidden(pointDetailView.pointCollectionView)
                pointDetailView.pointCollectionView.reloadData()
            }
            
            pointDetailView.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview()
            }
        }
    }
    
}


// MARK: - CollectionView Methods

private extension PointDetailViewController {
    
    func registerCell() {
        pointDetailView.pointCollectionView.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: PointCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        pointDetailView.delegate = self
        pointDetailView.pointCollectionView.delegate = self
        pointDetailView.pointCollectionView.dataSource = self
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PointDetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 86)
    }
    
}


// MARK: - UICollectionViewDataSource

extension PointDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pointViewModel.nowPointData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.cellIdentifier, for: indexPath) as? PointCollectionViewCell else { return UICollectionViewCell() }
        let data = pointViewModel.nowPointData.value?[indexPath.item] ?? PointDetailModel(sign: "", point: 0, description: "", createdAt: "")
        cell.dataBind(data, indexPath.item)
        return cell
    }
    
}


// MARK: - DRCustomAlert

extension PointDetailViewController: DRCustomAlertDelegate {}


// MARK: - GoogleAdsHandler

extension PointDetailViewController: GoogleAdsPresentable {
    
    func showPointShortageVC() {
        let pointShortageVC = PointShortageViewController()
        pointShortageVC.modalPresentationStyle = .overFullScreen
        
        pointShortageVC.onAdvertisementDismiss = { [weak self] in
            guard let self = self else { return }
            self.showRewardedAd()
        }
        
        pointShortageVC.onAddCourseDismiss = { [weak self] in
            guard let self = self else { return }
            let addCourseFirstVC = AddCourseFirstViewController(
                viewModel: AddCourseViewModel(),
                viewPath: StringLiterals.Amplitude.ViewPath.pointShortage
            )
            self.navigationController?.pushViewController(addCourseFirstVC, animated: false)
        }
        
        self.present(pointShortageVC, animated: false)
    }
        
}


// MARK: - PointDetailDelegate

extension PointDetailViewController: PointDetailDelegate {

    func goToPointShortageVC() {
        showPointShortageVC()
    }
    
    func didChangeValue(segment: UISegmentedControl) {
        pointViewModel.changeSegment(segmentIndex: pointDetailView.segmentControl.selectedSegmentIndex)
        changeSelectedSegmentLayout(isEarnedPointHidden: pointViewModel.isEarnedPointHidden.value)
    }
    
}
