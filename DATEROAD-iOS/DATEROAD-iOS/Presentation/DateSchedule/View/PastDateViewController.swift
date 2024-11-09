//
//  PastDateViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class PastDateViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    var pastDateContentView = PastDateContentView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    var pastDateScheduleViewModel: DateScheduleViewModel
    
    private var loaded: Bool = false
    
    
    // MARK: - Life Cycles
    
    init(pastDateScheduleViewModel: DateScheduleViewModel) {
        self.pastDateScheduleViewModel = pastDateScheduleViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.pastDateScheduleViewModel.getPastDateScheduleData()
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.DateSchedule.pastDate, alignment: .center)
        registerCell()
        setDelegate()
        self.pastDateScheduleViewModel.isSuccessGetPastDateScheduleData.value = false
        bindViewModel()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubview(pastDateContentView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        pastDateContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


// MARK: - UI Setting Methods

private extension PastDateViewController {
    
    func setEmptyView() {
        guard let dataCount = pastDateScheduleViewModel.pastDateScheduleData.value?.count else { return }
        pastDateContentView.emptyView.isHidden = !(dataCount == 0)
    }
    
    func bindViewModel() {
        self.pastDateScheduleViewModel.updatePastDateScheduleData.bind { [weak self] flag in
            guard let flag else { return }
            if flag {
                DispatchQueue.main.async {
                    UIView.performWithoutAnimation {
                        self?.pastDateContentView.pastDateCollectionView.performBatchUpdates({
                            self?.pastDateContentView.pastDateCollectionView.reloadSections(IndexSet(integer: 0))
                        })
                    }
                }
                self?.pastDateScheduleViewModel.updatePastDateScheduleData.value = false
            }
        }
        
        self.pastDateScheduleViewModel.onPastScheduleFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.pastDateScheduleViewModel.onPastScheduleLoading.bind { [weak self] onLoading in
            guard let onLoading,let loaded = self?.loaded, let onFailNetwork = self?.pastDateScheduleViewModel.onPastScheduleFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView(type: StringLiterals.DateSchedule.pastDate)
                    self?.pastDateContentView.isHidden = onLoading
                } else {
                    if !loaded {
                         self?.pastDateContentView.pastDateCollectionView.reloadData()
                     }
                    self?.setEmptyView()
                    self?.pastDateContentView.isHidden = onLoading
                    self?.hideLoadingView()
                    self?.loaded = true
                }
            }
        }
        
        self.pastDateScheduleViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.pastDateScheduleViewModel.getPastDateScheduleData()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.pastDateScheduleViewModel.isSuccessGetPastDateScheduleData.bind { [weak self] _ in
            self?.pastDateScheduleViewModel.setPastScheduleLoading()
        }
    }
    
}


// MARK: - CollectionView Methods

private extension PastDateViewController {
    
    func registerCell() {
        pastDateContentView.pastDateCollectionView.register(PastDateCollectionViewCell.self, forCellWithReuseIdentifier: PastDateCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        pastDateContentView.pastDateCollectionView.delegate = self
        pastDateContentView.pastDateCollectionView.dataSource = self
    }
    
}


// MARK: - Delegate

extension PastDateViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PastDateContentView.pastDateCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.04266, bottom: 0, right: ScreenUtils.width * 0.04266)
    }
    
}


// MARK: - DataSource

extension PastDateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastDateScheduleViewModel.pastDateScheduleData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = pastDateScheduleViewModel.pastDateScheduleData.value?[indexPath.item] else { return UICollectionViewCell()}
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastDateCollectionViewCell.cellIdentifier, for: indexPath) as? PastDateCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(data, indexPath.item)
        cell.setColor(index: indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToPastDateDetailVC(_:))))
        return cell
    }
    
    @objc
    func pushToPastDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: pastDateContentView.pastDateCollectionView)
        if let indexPath = pastDateContentView.pastDateCollectionView.indexPathForItem(at: location) {
            guard let data = pastDateScheduleViewModel.pastDateScheduleData.value?[indexPath.item] else { return }
            let pastDateDetailVC = PastDateDetailViewController(index: indexPath.item, dateID: data.dateID, pastDateDetailViewModel: DateDetailViewModel())
            pastDateDetailVC.setColor(index: indexPath.item)
            self.navigationController?.pushViewController(pastDateDetailVC, animated: false)
        }
    }
    
}
