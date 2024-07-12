//
//  CoursedCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

class MyCourseListCollectionView: UICollectionView {

    // MARK: - UI Properties
    
    static var courseListCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    var courseListData : [MyCourseListModel] = []
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = MyCourseListCollectionView.courseListCollectionViewLayout
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        MyCourseListCollectionView.courseListCollectionViewLayout.do {
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .vertical
        }
    }

}
