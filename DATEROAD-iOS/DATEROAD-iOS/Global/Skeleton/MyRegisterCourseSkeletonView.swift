//
//  MyRegisterCourseSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/1/24.
//

import UIKit

final class MyRegisterCourseSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let firstCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let secondCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let thirdCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let fourthCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let fifthCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let sixthCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    
    override func setHierarchy() {
        self.addSubviews(firstCourseItem,
                         secondCourseItem,
                         thirdCourseItem,
                         fourthCourseItem,
                         fifthCourseItem,
                         sixthCourseItem)
    }
    
    override func setLayout() {
        firstCourseItem.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        secondCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(firstCourseItem.snp.bottom)
            $0.height.equalTo(140)
        }
        
        thirdCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(secondCourseItem.snp.bottom)
            $0.height.equalTo(140)
        }
        
        fourthCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(thirdCourseItem.snp.bottom)
            $0.height.equalTo(140)
        }
        
        fifthCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(fourthCourseItem.snp.bottom)
            $0.height.equalTo(140)
        }
        
        sixthCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(fifthCourseItem.snp.bottom)
            $0.height.equalTo(140)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
    }
    
}

