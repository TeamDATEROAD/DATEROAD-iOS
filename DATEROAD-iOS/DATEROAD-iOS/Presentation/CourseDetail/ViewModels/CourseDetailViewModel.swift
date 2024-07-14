//
//  CourseDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
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

class CourseDetailViewModel {
    
    let imageCarouselViewModel: ImageCarouselViewModel
    let titleInfoViewModel: TitleInfoViewModel
    let mainContentsViewModel: MainContentsViewModel
    let timelineInfoViewModel: TimelineInfoViewModel
    let coastInfoViewModel: CoastInfoViewModel
    let tagInfoViewModel: TagInfoViewModel
    
    init() {
        self.imageCarouselViewModel = ImageCarouselViewModel()
        self.titleInfoViewModel = TitleInfoViewModel()
        self.mainContentsViewModel = MainContentsViewModel()
        self.timelineInfoViewModel = TimelineInfoViewModel(timelineData: TimelineModel.timelineDummyData)
        self.coastInfoViewModel = CoastInfoViewModel()
        self.tagInfoViewModel = TagInfoViewModel(tagInfoData: TagModel.tagDummyData)
    }
    
    var sections: [CourseDetailSection] {
        return [.imageCarousel, .titleInfo, .mainContents, .timelineInfo, .coastInfo, .tagInfo]
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
        case .titleInfo:
            return titleInfoViewModel.numberOfItems
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
struct ImageCarouselViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct TitleInfoViewModel {
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
    var timelineData: [TimelineModel]
    
    var numberOfItems: Int {
        return timelineData.count
    }

}



struct CoastInfoViewModel {
    var numberOfItems: Int {
        return 1
    }
}

struct TagInfoViewModel {
    var tagInfoData: [TagModel]
    
    var numberOfItems: Int {
        return tagInfoData.count
    }
}

