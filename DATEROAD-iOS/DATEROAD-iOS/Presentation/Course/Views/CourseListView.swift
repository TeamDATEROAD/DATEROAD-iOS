//
//  CourseListView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/11/24.
//

import UIKit

import SnapKit
import Then

class CourseListView: BaseView {
    
    // MARK: - UI Properties

    var emptyView = CustomEmptyView()

    let courseListCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            emptyView,
            courseListCollectionView
        )
    }
    
    override func setLayout() {
        
//        courseEmptyImageView.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(24)
//            $0.horizontalEdges.equalToSuperview()
//        }
//        
//        courseEmptyLabel.snp.makeConstraints {
//            $0.top.equalTo(courseEmptyImageView.snp.bottom)
//            $0.centerX.equalToSuperview()
//        }
//        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 419/812)
        }
        
        courseListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.11)
        }
        
    }
    
    override func setStyle() {
        courseListCollectionView.showsVerticalScrollIndicator = false
        courseListCollectionView.showsHorizontalScrollIndicator = false
        
        emptyView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .imgCourseEmpty), 
                            emptyTitle: StringLiterals.Course.isCourseEmpty)
        }
    }
    
}

