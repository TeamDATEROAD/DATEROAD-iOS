//
//  DateTimeLineCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class DateTimeLineCollectionView: UICollectionView {
    
    // MARK: - UI Properties
    
    static var dateTimeLineCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    var upcomingDateDetailData = DateTimeLineModel(startTime: "", places: [])
    var currentIndex: CGFloat = 0
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = DateTimeLineCollectionView.dateTimeLineCollectionViewLayout
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
        self.showsHorizontalScrollIndicator = false
        
        DateTimeLineCollectionView.dateTimeLineCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
            $0.itemSize = CGSize(width: 343, height: 54)
        }
    }

}

// MARK: - CollectionView Methods

extension DateTimeLineCollectionView {
    private func register() {
        self.register(DateTimeLineCollectionViewCell.self, forCellWithReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    func setUpBindings(upcomingDateDetailData: DateTimeLineModel) {
        self.upcomingDateDetailData = upcomingDateDetailData
    }
}

// MARK: - Delegate

extension DateTimeLineCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DateTimeLineCollectionView.dateTimeLineCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
}

// MARK: - DataSource

extension DateTimeLineCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateDetailData.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(upcomingDateDetailData.places[indexPath.item], indexPath.item)
        return cell
    }

}
