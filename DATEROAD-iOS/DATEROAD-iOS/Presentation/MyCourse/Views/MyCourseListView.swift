//
//  CoursedCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

class MyCourseListView: BaseView {

    // MARK: - UI Properties
    
    var myCourseListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myCourseListCollectionViewLayout)
    
    var emptyView = CustomEmptyView()
    
    // MARK: - Properties
    
    var courseListData : [MyCourseListModel] = []
    
    static var myCourseListCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(myCourseListCollectionView, emptyView)
    }
    
    override func setLayout() {
        myCourseListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenUtils.height * 84 / 812)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 444/812)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        myCourseListCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.showsVerticalScrollIndicator = true
        }
        
        MyCourseListView.myCourseListCollectionViewLayout.do {
            self.backgroundColor = UIColor(resource: .drWhite)
            
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .vertical
        }
        
        emptyView.do {
            $0.isHidden = true
        }
    }

}
