//
//  CoursedCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

class ViewedCourseCollectionView: UICollectionView {

    // MARK: - UI Properties
    
    static var viewedCourseCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    var viewedCourseData : [ViewedCourseModel] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = ViewedCourseCollectionView.viewedCourseCollectionViewLayout
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
        ViewedCourseCollectionView.viewedCourseCollectionViewLayout.do {
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .vertical
        }
    }

}

// MARK: - CollectionView Methods

extension ViewedCourseCollectionView {
    private func register() {
        self.register(ViewedCourseCollectionViewCell.self, forCellWithReuseIdentifier: ViewedCourseCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    func setUpBindings(viewedCourseData : [ViewedCourseModel]) {
        self.viewedCourseData = viewedCourseData
    }
}

// MARK: - Delegate

extension ViewedCourseCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 140)
    }
}

// MARK: - DataSource

extension ViewedCourseCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewedCourseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewedCourseCollectionViewCell.cellIdentifier, for: indexPath) as? ViewedCourseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(viewedCourseData[indexPath.item], indexPath.item)
        return cell
    }
    
}
