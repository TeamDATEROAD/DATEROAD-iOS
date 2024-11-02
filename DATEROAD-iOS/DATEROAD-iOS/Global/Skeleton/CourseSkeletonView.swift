//
//  CourseSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 10/30/24.
//

import UIKit

final class CourseSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let firstStackView: UIStackView = UIStackView()
    
    private let firstCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    private let secondCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    private let secondStackView: UIStackView = UIStackView()
    
    private let thirdCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    private let fourthCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    private let thirdStackView: UIStackView = UIStackView()
    
    private let fifthCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    private let sixthCourse: CourseItemSkeletonView = CourseItemSkeletonView()
    
    
    override func setHierarchy() {
        self.addSubviews(firstStackView, secondStackView, thirdStackView)
        firstStackView.addArrangedSubviews(firstCourse, secondCourse)
        secondStackView.addArrangedSubviews(thirdCourse, fourthCourse)
        thirdStackView.addArrangedSubviews(fifthCourse, sixthCourse)
    }
    
    override func setLayout() {
        firstStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        secondStackView.snp.makeConstraints {
            $0.top.equalTo(firstStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        thirdStackView.snp.makeConstraints {
            $0.top.equalTo(secondStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        [firstCourse,
         secondCourse,
         thirdCourse,
         fourthCourse,
         fifthCourse,
         sixthCourse
        ].forEach { course in
            course.snp.makeConstraints {
                $0.width.equalTo((ScreenUtils.width - 48) / 2)
                $0.height.equalTo(226)
            }
        }
    }
    
    override func setStyle() {
        [firstStackView,
         secondStackView,
         thirdStackView
        ].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        [fifthCourse, sixthCourse].forEach {
            $0.setSkeletonImage()
        }
    }
}
