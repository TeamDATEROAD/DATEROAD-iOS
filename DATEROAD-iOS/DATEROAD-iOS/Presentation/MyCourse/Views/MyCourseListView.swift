//
//  CoursedCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

final class MyCourseListView: BaseView {

    // MARK: - UI Properties
    
    var myCourseListCollectionView = UICollectionView(frame: .zero, collectionViewLayout:  UICollectionViewFlowLayout())
    
    var emptyView = CustomEmptyView()
    
    // MARK: - Properties
    
    var courseListData : [MyCourseListModel] = []
        
    private var type: String?
    
    // MARK: - LifeCycle
    
    init(type: String) {
        self.type = type
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(myCourseListCollectionView, emptyView)
    }
    
    override func setLayout() {
        myCourseListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        if self.type == StringLiterals.NavType.nav {
            emptyView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(ScreenUtils.height * 84 / 812)
                $0.horizontalEdges.equalToSuperview()
            }
        } else {
            emptyView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        myCourseListCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.showsVerticalScrollIndicator = true
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: ScreenUtils.width, height: 140)            
            $0.collectionViewLayout = layout

        }
        
        emptyView.do {
            $0.isHidden = true
        }
    }

}
