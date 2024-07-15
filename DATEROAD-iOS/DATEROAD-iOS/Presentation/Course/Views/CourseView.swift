//
//  CourseView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

import SnapKit
import Then

class CourseView: BaseView {
    
    // MARK: - UI Properties
   
    let courseNavigationBarView = CourseNavigationBarView()
    
    let courseFilterView = CourseFilterView()
    
    let courseListView = CourseListView()
    
   
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            courseNavigationBarView,
            courseFilterView,
            courseListView
        )
    }
    
    override func setLayout() {
        courseNavigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        courseFilterView.snp.makeConstraints {
            $0.top.equalTo(courseNavigationBarView.snp.bottom).inset(-14)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        courseListView.snp.makeConstraints {
            $0.top.equalTo(courseFilterView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    
    }

}


