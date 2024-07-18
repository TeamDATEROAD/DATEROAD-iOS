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
    
    // MARK: - Properties
    
    private let pastDateScheduleViewModel = DateScheduleViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.DateSchedule.pastDate, alignment: .center)
        
        registerCell()
        setDelegate()
        bindViewModel()
        setEmptyView()
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
        if pastDateScheduleViewModel.pastDateScheduleData.value?.count == 0 {
            pastDateContentView.emptyView.isHidden = false
        }
    }
    
    func bindViewModel() {
        self.pastDateScheduleViewModel.isSuccessGetPastDateScheduleData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.pastDateContentView.pastDateCollectionView.reloadData()
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
            let pastDateDetailVC = PastDateDetailViewController()
            self.navigationController?.pushViewController(pastDateDetailVC, animated: true)
            pastDateDetailVC.pastDateDetailViewModel = DateDetailViewModel(dateID: data.dateID)
            pastDateDetailVC.setColor(index: indexPath.item)
        }
    }
}
  
