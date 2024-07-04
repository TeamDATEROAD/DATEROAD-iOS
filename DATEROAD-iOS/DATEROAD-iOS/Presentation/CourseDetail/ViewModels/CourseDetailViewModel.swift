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
    
    init() {
        self.imageCarouselViewModel = ImageCarouselViewModel()
        self.mainContentsViewModel = MainContentsViewModel()
        self.timelineInfoViewModel = TimelineInfoViewModel()
        self.coastInfoViewModel = CoastInfoViewModel()
        self.tagInfoViewModel = TagInfoViewModel()
    }
    
    var sections: [CourseDetailSection] {
        return [.imageCarousel, .mainContents, .timelineInfo, .coastInfo, .tagInfo]
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
        }
    }
}





