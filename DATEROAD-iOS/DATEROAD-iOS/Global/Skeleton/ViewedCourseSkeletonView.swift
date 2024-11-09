//
//  ViewedCourseSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/1/24.
//

import UIKit

final class ViewedCourseSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let primaryTitleLabel: UIView = UIView()
    
    private let secondaryTitleLabel: UIView = UIView()
    
    private let countLabel: UIView = UIView()
    
    private let createCourseLabel: UIView = UIView()
    
    private let firstCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let secondCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let thirdCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let fourthCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    private let fifthCourseItem: MyCourseItemSkeletonView = MyCourseItemSkeletonView()
    
    
    override func setHierarchy() {
        self.addSubviews(primaryTitleLabel,
                         secondaryTitleLabel,
                         countLabel,
                         createCourseLabel,
                         firstCourseItem,
                         secondCourseItem,
                         thirdCourseItem,
                         fourthCourseItem,
                         fifthCourseItem)
    }
    
    override func setLayout() {
        primaryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(82)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(185)
        }
        
        secondaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(primaryTitleLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(185)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(secondaryTitleLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(80)
        }
        
        createCourseLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(235)
        }
        
        firstCourseItem.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(createCourseLabel.snp.bottom).offset(18)
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
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        [primaryTitleLabel, secondaryTitleLabel].forEach {
            $0.setSkeletonLabel()
        }
        
        [countLabel, createCourseLabel].forEach {
            $0.setSkeletonLabel()
        }
    }
    
}

