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

    var freeViewChance: ObservablePattern<Int> = ObservablePattern(3)
    var isFreeView: ObservablePattern<Bool> = ObservablePattern(true)

    let imageCarouselViewModel: ImageCarouselViewModel
    let titleInfoViewModel: TitleInfoViewModel
    let mainContentsViewModel: MainContentsViewModel

    init() {
        self.imageCarouselViewModel = ImageCarouselViewModel()
        self.titleInfoViewModel = TitleInfoViewModel()
        self.mainContentsViewModel = MainContentsViewModel()
        
        // freeViewChance가 변경될 때마다 checkFreeAble 호출
        self.freeViewChance.bind { [weak self] _ in
            self?.checkFreeAble()
        }
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

    func checkFreeAble() {
        isFreeView.value = freeViewChance.value ?? 3 > 0
    }
}
