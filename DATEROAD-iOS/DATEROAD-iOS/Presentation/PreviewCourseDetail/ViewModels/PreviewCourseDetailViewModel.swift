//
//  PreviewCourseDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import Foundation

enum PreviewCourseDetailSection {
    case imageCarousel
    case titleInfo
    case mainContents
    
    static var dataSource: [PreviewCourseDetailSection] {
        return [.imageCarousel,
                .titleInfo,
                .mainContents]
    }
}

class PreviewCourseDetailViewModel {
    
    let imageCarouselViewModel: ImageCarouselViewModel
    let titleInfoViewModel: TitleInfoViewModel
    let mainContentsViewModel: MainContentsViewModel
    
    init() {
        self.imageCarouselViewModel = ImageCarouselViewModel()
        self.titleInfoViewModel = TitleInfoViewModel()
        self.mainContentsViewModel = MainContentsViewModel()
    }
    
    var sections: [PreviewCourseDetailSection] {
        return [
            .imageCarousel,
            .titleInfo,
            .mainContents
        ]
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func fetchSection(at index: Int) -> PreviewCourseDetailSection {
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
