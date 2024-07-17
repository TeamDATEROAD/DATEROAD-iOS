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
    
    var currentPage: ObservablePattern<Int> = ObservablePattern(0)
    
    var freeViewChance: ObservablePattern<Int> = ObservablePattern(3)
    
    var isFreeView: ObservablePattern<Bool> = ObservablePattern(true)
    
//    let imageCarouselViewModel: ImageCarouselViewModel
//    
//    let titleInfoViewModel: TitleInfoViewModel
//    
//    let mainContentsViewModel: MainContentsViewModel
//    
//    let timelineInfoViewModel: TimelineInfoViewModel
//    
//    let coastInfoViewModel: CoastInfoViewModel
//    
//    let tagInfoViewModel: TagInfoViewModel
        
    var conditionalData: ObservablePattern<ConditionalModel> = ObservablePattern(nil)
    
    var imageData: ObservablePattern<[ThumbnailModel]> = ObservablePattern(nil)
    
    var timelineData: ObservablePattern<[TimelineModel]> = ObservablePattern(nil)

    var tagData: ObservablePattern<[TagModel]> = ObservablePattern(nil)
    
    var likeSum: ObservablePattern<Int> = ObservablePattern(nil)
    
    var titleHeaderData: ObservablePattern<TitleHeaderModel> = ObservablePattern(nil)
    
    var mainContentsData: ObservablePattern<MainContentsModel> = ObservablePattern(nil)
    
    var isAccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var isCourseMine: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var isSuccessGetData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var haveFreeCount: ObservablePattern<Bool> = ObservablePattern(nil)

    var havePoint: ObservablePattern<Bool> = ObservablePattern(nil)

    
    var numberOfSections: Int = 6
    
    init() {
//        self.imageCarouselViewModel = ImageCarouselViewModel()
//        self.titleInfoViewModel = TitleInfoViewModel()
//        self.mainContentsViewModel = MainContentsViewModel()
//        self.timelineInfoViewModel = TimelineInfoViewModel(timelineData: TimelineModel.timelineContents)
//        self.coastInfoViewModel = CoastInfoViewModel()
//        self.tagInfoViewModel = TagInfoViewModel(tagInfoData: TagModel.tagDummyData)
        getCourseDetail()
    }
    
    var sections: [CourseDetailSection] {
        return [.imageCarousel, .titleInfo, .mainContents, .timelineInfo, .coastInfo, .tagInfo]
    }
    
    func setNumberOfSections(_ count: Int) {
        self.numberOfSections = count
    }
    
    
    func fetchSection(at index: Int) -> CourseDetailSection {
        return sections[index]
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        switch sections[section] {
        case .imageCarousel, .titleInfo, .mainContents, .coastInfo:
            return 1
        case .timelineInfo:
            guard let timelineData = self.timelineData.value else {return 0}
            return timelineData.count
        case .tagInfo:
            guard let tagData = self.tagData.value else {return 0}
            return tagData.count
        }
    }
    
    func didSwipeImage(to index: Int) {
        currentPage.value = index
    }
    
}

extension CourseDetailViewModel {
    func getCourseDetail() {
        CourseDetailService().getCourseDetailInfo(courseId: 31){ response in
            switch response {
            case .success(let data):
                self.conditionalData.value = ConditionalModel(courseId: 31, isCourseMine: data.isCourseMine, isAccess: data.isAccess, free: data.free, totalPoint: data.totalPoint, isUserLiked: data.isUserLiked)

                if data.totalPoint >= 50 {
                    self.havePoint.value = true
                } else {
                    self.havePoint.value = false
                }
                
                if data.free > 0 && data.free <= 3 {
                    self.haveFreeCount.value = true
                } else {
                    self.haveFreeCount.value = false
                }
                
                self.isAccess.value = data.isAccess
                self.isCourseMine.value = data.isCourseMine
                
                self.imageData.value = data.images.map {ThumbnailModel(imageUrl: $0.imageURL, sequence: $0.sequence)}
                
//                let updatedImageData = data.images.map { (imageUrl: $0.imageURL, sequence: $0.sequence) }
//                self.imageData = updatedImageData
                self.likeSum.value = data.like
                self.titleHeaderData.value = TitleHeaderModel(date: data.date, title: data.title, cost: data.totalCost, totalTime: data.totalTime, city: data.city)
//                self.titleHeaderData.date = data.date
//                self.titleHeaderData.title = data.title
//                self.titleHeaderData.city = data.city
//                self.titleHeaderData.totalTime = data.totalTime
//                self.titleHeaderData.cost = data.totalCost
        
                self.mainContentsData.value = MainContentsModel(description: data.description)
                
                self.timelineData.value = data.places.map { place in
                    TimelineModel(sequence: place.sequence, title: place.title, duration: Float(place.duration))
                }
                print(self.timelineData,"🚨")

            
//                self.coastData = data.totalCost
                self.tagData.value = data.tags.map { tag in
                    TagModel(tag: tag.tag)
                }
                self.isSuccessGetData.value = true

                
            default:
                self.isSuccessGetData.value = false
                print("Failed to fetch course data")
            }
        }
    }
}
//
//struct ImageCarouselViewModel {
//    var numberOfItems: Int {
//        return 1
//    }
//}
//
//struct TitleInfoViewModel {
//    var numberOfItems: Int {
//        return 1
//    }
//}
//
//struct MainContentsViewModel {
//    var numberOfItems: Int {
//        return 1
//    }
//}
//
//struct TimelineInfoViewModel {
//    var timelineData: [TimelineModel]
//    
//    var numberOfItems: Int {
//        return timelineData.count
//    }
//}
//
//
//struct CoastInfoViewModel {
//    var numberOfItems: Int {
//        return 1
//    }
//}
//
//struct TagInfoViewModel {
//    var tagInfoData: [TagModel]
//    
//    var numberOfItems: Int {
//        return tagInfoData.count
//    }
//}
//
