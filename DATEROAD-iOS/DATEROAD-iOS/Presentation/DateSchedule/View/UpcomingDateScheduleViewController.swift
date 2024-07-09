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
    
    
    // MARK: - Properties
    
    private let upcomingDateScheduleViewModel = DateScheduleViewModel()
    
    private lazy var upcomingDateScheduleData = upcomingDateScheduleViewModel.upcomingDateScheduleDummyData
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        setDelegate()
        setupBindings()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(upcomingDateScheduleView)
    }
    
    override func setLayout() {
        upcomingDateScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Private Methods

private extension UpcomingDateScheduleViewController {
    @objc
    func pushToDateRegisterVC() {
       print("일정 등록으로 이동")
    }
    
    @objc
    func pushToPastDateVC() {
        let pastDateVC = PastDateViewController()
        self.navigationController?.pushViewController(pastDateVC, animated: true)
    }
    
    func setupBindings() {
        upcomingDateScheduleView.cardPageControl.do {
            $0.numberOfPages = upcomingDateScheduleData.dateCards.count
        }
        
        upcomingDateScheduleView.dateRegisterButton.do {
            $0.addTarget(self, action: #selector(pushToDateRegisterVC), for: .touchUpInside)
        }
        
        upcomingDateScheduleView.pastDateButton.do {
            $0.addTarget(self, action: #selector(pushToPastDateVC), for: .touchUpInside)
        }
    }
    
}

// MARK: - CollectionView Methods

extension UpcomingDateScheduleViewController {
    private func register() {
        upcomingDateScheduleView.cardCollectionView.register(DateCardCollectionViewCell.self, forCellWithReuseIdentifier: DateCardCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        upcomingDateScheduleView.cardCollectionView.delegate = self
        upcomingDateScheduleView.cardCollectionView.dataSource = self
    }
    
    func setUpBindings(upcomingDateScheduleData: DateScheduleModel) {
        upcomingDateScheduleView.upcomingDateScheduleData = upcomingDateScheduleData
        upcomingDateScheduleView.cardCollectionView.reloadData()
    }
}

// MARK: - Delegate

extension UpcomingDateScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UpcomingDateScheduleView.dateCardCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = UpcomingDateScheduleView.dateCardCollectionViewLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        upcomingDateScheduleView.updatePageControlSelectedIndex(index: Int(roundedIndex))
    }
}


// MARK: - DataSource

extension UpcomingDateScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateScheduleData.dateCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(upcomingDateScheduleData.dateCards[indexPath.item], indexPath.item)
        cell.setColor(index: indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: upcomingDateScheduleView.cardCollectionView)
        if let indexPath = upcomingDateScheduleView.cardCollectionView.indexPathForItem(at: location) {
            let upcomingDateDetailVC = UpcomingDateDetailViewController()
            self.navigationController?.pushViewController(upcomingDateDetailVC, animated: true)
            upcomingDateDetailVC.upcomingDateDetailContentView.dataBind(upcomingDateScheduleData.dateCards[indexPath.item])
            upcomingDateDetailVC.setColor(index: indexPath.item)
        }
    }
}
  
