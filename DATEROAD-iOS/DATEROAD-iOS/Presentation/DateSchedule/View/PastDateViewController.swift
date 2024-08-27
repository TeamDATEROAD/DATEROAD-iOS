//
//  PastDateViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class PastDateViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    var pastDateContentView = PastDateContentView()
    
    private let loadingView: DRLoadingView = DRLoadingView()

    private let errorView: DRErrorViewController = DRErrorViewController()
    
    // MARK: - Properties
    
    private let pastDateScheduleViewModel = DateScheduleViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        bindViewModel()
        loadDataAndReload()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.DateSchedule.pastDate, alignment: .center)
        
        registerCell()
        setDelegate()
        bindViewModel()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubviews(loadingView, pastDateContentView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pastDateContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func drawDateCardView() {
        print("hi im drawing")
        pastDateContentView.pastDateCollectionView.reloadData()
        DispatchQueue.main.async {
            self.setEmptyView()
        }
    }

    private func loadDataAndReload() {
        self.pastDateScheduleViewModel.getPastDateScheduleData()
        self.pastDateScheduleViewModel.isSuccessGetPastDateScheduleData.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess == true {
                DispatchQueue.main.async {
                    self.drawDateCardView()
                }
            }
        }
    }
}

// MARK: - UI Setting Methods

private extension PastDateViewController {
    func setEmptyView() {
        print("all")
        if let dataCount = pastDateScheduleViewModel.pastDateScheduleData.value?.count, dataCount == 0 {
            print("dfd")
            pastDateContentView.emptyView.isHidden = false
        } else {
            pastDateContentView.emptyView.isHidden = true
        }
    }

    
    func bindViewModel() {
        self.pastDateScheduleViewModel.onPastScheduleFailNetwork.bind { [weak self] onFailure in
             guard let onFailure else { return }
             if onFailure {
                 let errorVC = DRErrorViewController()
                 self?.navigationController?.pushViewController(errorVC, animated: false)
             }
         }

        self.pastDateScheduleViewModel.onPastScheduleLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.pastDateScheduleViewModel.onPastScheduleFailNetwork.value else { return
            }
             if !onFailNetwork {
                 self?.loadingView.isHidden = !onLoading
                 self?.pastDateContentView.isHidden = onLoading
             }
         }
        
        self.pastDateScheduleViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.pastDateScheduleViewModel.isSuccessGetPastDateScheduleData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.pastDateContentView.pastDateCollectionView.reloadData()
            }
        }
        
        self.pastDateScheduleViewModel.onPastScheduleFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                self?.loadingView.isHidden = true
                let errorVC = DRErrorViewController()
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
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
    
    @objc func pushToPastDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: pastDateContentView.pastDateCollectionView)
        if let indexPath = pastDateContentView.pastDateCollectionView.indexPathForItem(at: location) {
            guard let data = pastDateScheduleViewModel.pastDateScheduleData.value?[indexPath.item] else { return }
            let pastDateDetailVC = PastDateDetailViewController(dateID: data.dateID, pastDateDetailViewModel: DateDetailViewModel())
            pastDateDetailVC.setColor(index: indexPath.item)
            self.navigationController?.pushViewController(pastDateDetailVC, animated: false)
        }
    }
}
