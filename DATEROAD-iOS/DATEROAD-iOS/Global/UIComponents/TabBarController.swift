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
    
    let homeVC = MainViewController(viewModel: MainViewModel())
    
    let courseVC = CourseViewController(courseViewModel: CourseViewModel())
    
    let dateVC = UpcomingDateScheduleViewController(upcomingDateScheduleViewModel: DateScheduleViewModel())
    
    let viewedCourseVC = ViewedCourseViewController(viewedCourseViewModel: MyCourseListViewModel())
    
    let mypageVC = MyPageViewController(myPageViewModel: MyPageViewModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHierarchy()
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBar.frame.size.height = view.frame.height * 0.11
        self.tabBar.frame.origin.y = view.frame.height - self.tabBar.frame.size.height
    }
}

// MARK: - Private Methods

private extension TabBarController {
    
    func setStyle() {
        
        let iconOffset = -(view.frame.height * 0.008)
        
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
            .foregroundColor: UIColor(resource: .gray300)
        ]
        
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(resource: .drBlack)
        ]
        
        homeVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.home,
                image: UIImage(resource: .icHome).withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(resource: .icHome).withRenderingMode(.alwaysTemplate)
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        courseVC.do {
            $0.view.backgroundColor = UIColor(resource: .drWhite)
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.course,
                image: UIImage(resource: .icLook).withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(resource: .icLook).withRenderingMode(.alwaysTemplate)
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        dateVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.date,
                image: UIImage(resource: .icTimeline).withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(resource: .icTimeline).withRenderingMode(.alwaysTemplate)
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        viewedCourseVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.viewedCourse,
                image: UIImage(resource: .icRead).withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(resource: .icRead).withRenderingMode(.alwaysTemplate)
            )
            $0.tabBarItem.setTitleTextAttributes(normalTitleAttributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: CGFloat(iconOffset))
        }
        
        mypageVC.do {
            $0.tabBarItem = UITabBarItem(
                title: StringLiterals.TabBar.myPage,
                image: UIImage(resource: .icMypage).withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(resource: .icMypage).withRenderingMode(.alwaysTemplate)
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
                let imageInset = view.frame.height * 0.002
                item.imageInsets = UIEdgeInsets(top: -imageInset, left: 0, bottom: imageInset, right: 0)
            }
        }
        
    }
}
