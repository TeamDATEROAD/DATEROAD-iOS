//
//  NavViewedCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

import SnapKit
import Then

class NavViewedCourseViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    private var courseCollectionView = ViewedCourseCollectionView()
    
    // MARK: - Properties
    
    private let viewedCourseViewModel = ViewedCourseViewModel()
    
    private lazy var viewedCourseDummyData = viewedCourseViewModel.viewedCourseDummyData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: "내가 등록한 코스", alignment: .center)
        // Do any additional setup after loading the view.
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(courseCollectionView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        courseCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(88)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        self.view.backgroundColor = UIColor(resource: .drWhite)
        
        courseCollectionView.do {
            $0.setUpBindings(viewedCourseData: viewedCourseDummyData)
        }
    }

}
