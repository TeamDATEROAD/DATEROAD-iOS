//
//  MyPageSection.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import Foundation

enum MyPageSection {
    
    case myCourse
    
    case pointSystem
    
    case inquiry
    
    case logout
    
    var title: String {
        switch self {
        case .myCourse:
            return StringLiterals.MyPage.myCourse
        case .pointSystem:
            return StringLiterals.MyPage.pointSystem
        case .inquiry:
            return StringLiterals.MyPage.inquiry
        case .logout:
            return StringLiterals.MyPage.logout
        }
    }
    
    static let dataSource: [MyPageSection] = [
        MyPageSection.myCourse,
        MyPageSection.pointSystem,
        MyPageSection.inquiry,
        MyPageSection.logout
    ]
    
}
