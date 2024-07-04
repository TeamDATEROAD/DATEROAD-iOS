//
//  PointCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import UIKit

final class PointCollectionView: UICollectionView {
    
    // MARK: - UI Properties
    
    static var pointCollectionViewLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        return layout
   }
    
    // MARK: - Properties
    
    private var pointData: [PointModel] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = PointCollectionView.pointCollectionViewLayout
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.backgroundColor = .black
        register()
        setDelegate()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
    }

}


// MARK: - CollectionView Methods

extension PointCollectionView {
    private func register() {
        self.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: "PointCollectionViewCell")
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }

    func setUpBindings(pointData : [PointModel]) {
        self.pointData = pointData
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PointCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 86)
    }
}

// MARK: - UICollectionViewDataSource

extension PointCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pointData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.identifier, for: indexPath) as? PointCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(pointData[indexPath.item], indexPath.item)
        return cell
    }
}
