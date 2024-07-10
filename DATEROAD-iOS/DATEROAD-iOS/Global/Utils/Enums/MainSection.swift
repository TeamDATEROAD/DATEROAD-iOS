//
//  MainSection.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

enum MainSection {
    case upcomingDate
    case hotDateCourse
    case banner
    case newDateCourse
    
//    var title: String {
//        switch self {
//        case .upcomingDate:
//            return StringLiterals.MyPage.myCourse
//        case .hotDateCourse:
//            return StringLiterals.MyPage.pointSystem
//        case .banner:
//            return StringLiterals.MyPage.inquiry
//        case .newDateCourse:
//            return StringLiterals.MyPage.logout
//        }
//    }
    
    static let dataSource: [MainSection] = [
        MainSection.upcomingDate,
        MainSection.hotDateCourse,
        MainSection.banner,
        MainSection.newDateCourse
    ]
}
