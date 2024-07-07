//
//  TabBarController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/8/24.
//

import UIKit

import SnapKit
import Then

final class TabBarController: UITabBarController {
    
    // MARK: - UI Properties
    
    let homeVC = CourseDetailViewController()
    
    let courseVC = UIViewController()
    
    let dateVC = UIViewController()
    
    let viewedCourseVC = UIViewController()
    
    let mypageVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHierarchy()
    }
}

// MARK: - Private Methods

private extension TabBarController {
    
    func setStyle() {
        
        let iconOffset: Int = 4
        
        let font = UIFont.suit(.cap_reg_11)
        
        tabBar.do {
            $0.tintColor = UIColor(resource: .drBlack)
            $0.barTintColor = UIColor(resource: .drWhite)
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .gray100).cgColor
        }
        
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(resource: .gray200)
        ]
        
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(resource: .drBlack)
        ]
        
        homeVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.home,
                image: UIImage(resource: .icHome).withRenderingMode(.alwaysOriginal), // 원본 이미지 사용
                selectedImage: UIImage(resource: .icHome).withRenderingMode(.alwaysTemplate) // 선택된 상태의 이미지
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        courseVC.do {
            $0.view.backgroundColor = UIColor(resource: .drWhite)
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.course,
                image: UIImage(resource: .icLook).withRenderingMode(.alwaysOriginal), // 원본 이미지 사용
                selectedImage: UIImage(resource: .icLook).withRenderingMode(.alwaysTemplate) // 선택된 상태의 이미지
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        dateVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.date,
                image: UIImage(resource: .icTimeline).withRenderingMode(.alwaysOriginal), // 원본 이미지 사용
                selectedImage: UIImage(resource: .icTimeline).withRenderingMode(.alwaysTemplate) // 선택된 상태의 이미지
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        viewedCourseVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.viewedCourse,
                image: UIImage(resource: .icRead).withRenderingMode(.alwaysOriginal), // 원본 이미지 사용
                selectedImage: UIImage(resource: .icRead).withRenderingMode(.alwaysTemplate) // 선택된 상태의 이미지
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        mypageVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.myPage,
                image: UIImage(resource: .icMypage).withRenderingMode(.alwaysOriginal), // 원본 이미지 사용
                selectedImage: UIImage(resource: .icMypage).withRenderingMode(.alwaysTemplate) // 선택된 상태의 이미지
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
    }
    
    func setHierarchy() {
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        homeNavVC.setNavigationBarHidden(true, animated: false)

        let viewControllers = [homeNavVC, courseVC, dateVC, viewedCourseVC, mypageVC]
        self.setViewControllers(viewControllers, animated: true)
        
        if let items = tabBar.items {
            for item in items {
                 item.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -7, right: 0)
            }
        }
    }
}
