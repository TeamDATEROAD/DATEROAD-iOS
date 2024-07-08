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
    
    lazy var upcomingDateScheduleData = DateSchdeuleModel(dateCards: [])
    
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
        
        DateCardCollectionView.dateCardCollectionViewLayout.do {
            $0.minimumLineSpacing = 20
            $0.scrollDirection = .horizontal
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
    
    func setUpBindings(upcomingDateScheduleData: DateSchdeuleModel) {
        self.upcomingDateScheduleData = upcomingDateScheduleData
    }
}

// MARK: - Delegate

extension DateCardCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 291, height: 406)
    }
    
}

// MARK: - DataSource

extension DateCardCollectionView : UICollectionViewDataSource {
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
        let indexPath = self.indexPathForItem(at: location)

        if indexPath != nil {
           print("다가올 데이트 상세 페이지로 이동 \(upcomingDateScheduleData.dateCards[indexPath?.item ?? 0].courseID ?? 0)")
       }
    }
    
}
