//
//  CourseDetailSection.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 9/26/24.
//

import Foundation

enum CourseDetailSection {
    
    case imageCarousel
    
    case titleInfo
    
    case mainContents
    
    case timelineInfo
    
    case coastInfo
    
    case tagInfo
    
    static var dataSource: [CourseDetailSection] {
        return [.imageCarousel, .titleInfo, .mainContents, .timelineInfo, .coastInfo, .tagInfo]
    }
    
}
