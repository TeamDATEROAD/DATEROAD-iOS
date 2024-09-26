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
    
    static let dataSource: [MainSection] = [
        MainSection.upcomingDate,
        MainSection.hotDateCourse,
        MainSection.banner,
        MainSection.newDateCourse
    ]
}
