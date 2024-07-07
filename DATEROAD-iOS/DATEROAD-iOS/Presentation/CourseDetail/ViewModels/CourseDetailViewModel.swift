//
//  CourseDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import Foundation

enum CourseDetailSection {
    case imageCarousel
    case mainContents
    case timelineInfo
    case coastInfo
    case tagInfo
    case bringCourse
    
    static var dataSource: [CourseDetailSection] {
        return [.imageCarousel,
                .mainContents,
                .timelineInfo,
                .coastInfo,
                .tagInfo]
    }
}

class CourseDetailViewModel {
    
    let imageCarouselViewModel: ImageCarouselViewModel
    let mainContentsViewModel: MainContentsViewModel
    let timelineInfoViewModel: TimelineInfoViewModel
    let coastInfoViewModel: CoastInfoViewModel
    let tagInfoViewModel: TagInfoViewModel
    let bringCourseViewModel: BringCourseViewModel
    
    init() {
        self.imageCarouselViewModel = ImageCarouselViewModel()
        self.mainContentsViewModel = MainContentsViewModel()
        self.timelineInfoViewModel = TimelineInfoViewModel()
        self.coastInfoViewModel = CoastInfoViewModel()
        self.tagInfoViewModel = TagInfoViewModel()
        self.bringCourseViewModel = BringCourseViewModel()
    }
    
    var sections: [CourseDetailSection] {
        return [
            .imageCarousel,
            .mainContents,
            .timelineInfo,
            .coastInfo,
            .tagInfo,
            .bringCourse
        ]
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func fetchSection(at index: Int) -> CourseDetailSection {
        return sections[index]
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        switch sections[section] {
        case .imageCarousel:
            return imageCarouselViewModel.numberOfItems
        case .mainContents:
            return mainContentsViewModel.numberOfItems
        case .timelineInfo:
            return timelineInfoViewModel.numberOfItems
        case .coastInfo:
            return coastInfoViewModel.numberOfItems
        case .tagInfo:
            return tagInfoViewModel.numberOfItems
        case .bringCourse:
            return bringCourseViewModel.numberOfItems
        }
    }
}


struct ImageCarouselViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct MainContentsViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct TimelineInfoViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct CoastInfoViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct TagInfoViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct BringCourseViewModel {
    var numberOfItems: Int {
        return 1
    }
}


