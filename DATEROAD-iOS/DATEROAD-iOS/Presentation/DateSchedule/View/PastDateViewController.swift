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
    
    private lazy var pastDateScheduleData = pastDateScheduleViewModel.pastDateScheduleDummyData
    
    var currentIndex: CGFloat = 0
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: "지난 데이트")
        
        setDataSource()
        
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

// MARK: - CollectionView Methods

private extension PastDateViewController {
    func setDataSource() {
        pastDateContentView.pastDateCollectionView.dataSource = self
    }
}

// MARK: - DataSource

extension PastDateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastDateScheduleData.dateCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastDateCollectionViewCell.cellIdentifier, for: indexPath) as? PastDateCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(pastDateScheduleData.dateCards[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToPastDateDetailVC(_:))))
        return cell
    }
    
    @objc func pushToPastDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: pastDateContentView.pastDateCollectionView)
        if let indexPath = pastDateContentView.pastDateCollectionView.indexPathForItem(at: location) {
            let pastDateDetailVC = PastDateDetailViewController()
            self.navigationController?.pushViewController(pastDateDetailVC, animated: true)
            pastDateDetailVC.pastDateDetailContentView.dataBind(pastDateScheduleData.dateCards[indexPath.item])
        }
    }
}
  
