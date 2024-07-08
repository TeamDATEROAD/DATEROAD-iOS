//
//  DateCardCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class DateCardCollectionView: UICollectionView {
    
    // MARK: - UI Properties
    
    static var dateCardCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    lazy var upcomingDateScheduleData = DateScheduleModel(dateCards: [])
    
    var currentIndex: CGFloat = 0
    
    var isOneStepPaging = true
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = DateCardCollectionView.dateCardCollectionViewLayout
        super.init(frame: frame, collectionViewLayout: flowLayout)
        register()
        setDelegate()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        self.isPagingEnabled = false
        self.contentInsetAdjustmentBehavior = .never
        self.clipsToBounds = true
        self.decelerationRate = .fast
        
        DateCardCollectionView.dateCardCollectionViewLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = ScreenUtils.width * 0.0693
            $0.itemSize = CGSize(width: ScreenUtils.width * 0.776, height: 406)
        }
    }

}

// MARK: - CollectionView Methods

extension DateCardCollectionView {
    private func register() {
        self.register(DateCardCollectionViewCell.self, forCellWithReuseIdentifier: DateCardCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    func setUpBindings(upcomingDateScheduleData: DateScheduleModel) {
        self.upcomingDateScheduleData = upcomingDateScheduleData
        self.reloadData()
    }
}

// MARK: - Delegate

extension DateCardCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DateCardCollectionView.dateCardCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = DateCardCollectionView.dateCardCollectionViewLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

// MARK: - DataSource

extension DateCardCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateScheduleData.dateCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(upcomingDateScheduleData.dateCards[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        if let indexPath = self.indexPathForItem(at: location) {
            print("다가올 데이트 상세 페이지로 이동 \(upcomingDateScheduleData.dateCards[indexPath.item].courseID ?? 0)")
        }
    }
}
