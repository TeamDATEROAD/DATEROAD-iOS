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
    
    let courseEmptyImageView = UIImageView(image: .imgCourseEmpty)
    
    let courseEmptyLabel = UILabel()

    let courseListCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(courseEmptyImageView,courseEmptyLabel, courseListCollectionView)
    }
    
    override func setLayout() {
        courseListCollectionView.showsVerticalScrollIndicator = true
        courseListCollectionView.showsHorizontalScrollIndicator = true
        
        courseEmptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        
        courseEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(courseEmptyImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        courseListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.11)
        }
        
    }
    
    override func setStyle() {
        courseEmptyImageView.isHidden = true
        courseEmptyLabel.isHidden = true
        
        courseEmptyLabel.do {
            $0.text = StringLiterals.Course.isCourseEmpty
            $0.textColor = UIColor(resource: .gray500)
            $0.font = UIFont.suit(.title_bold_18)
        }
    }
    
}



