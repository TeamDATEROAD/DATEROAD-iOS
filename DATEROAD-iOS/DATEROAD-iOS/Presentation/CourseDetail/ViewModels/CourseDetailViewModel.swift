//
//  CourseDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

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

class CourseDetailViewModel: Serviceable {
    
    var courseId: Int
    
    var currentPage: ObservablePattern<Int> = ObservablePattern(0)
    
    var freeViewChance: ObservablePattern<Int> = ObservablePattern(3)
    
    var isFreeView: ObservablePattern<Bool> = ObservablePattern(true)
    
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
    
    var isUserLiked: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var haveFreeCount: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var havePoint: ObservablePattern<Bool> = ObservablePattern(nil)
    
    let bannerSectionData: [BannerDetailSection] = BannerDetailSection.dataSource
    
    var isSuccessGetBannerData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var bannerDetailData: ObservablePattern<BannerDetailModel> = ObservablePattern(nil)
    
    var bannerHeaderData: ObservablePattern<BannerHeaderModel> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var advertisementId: Int = 0
    
    var bannerDetailTitle: String = ""
    
    var numberOfSections: Int = 6
    
    var isChange: (() -> Void)?
    
    var startAt: String = ""
    
    var tagArr = [GetCourseDetailTag]()
    
    
    init(courseId: Int) {
        self.courseId = courseId
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
        setLoading()
        NetworkService.shared.courseDetailService.getCourseDetailInfo(courseId: courseId){ response in
            switch response {
            case .success(let data):
                dump(data)
                self.conditionalData.value = ConditionalModel(courseId: self.courseId, isCourseMine: data.isCourseMine, isAccess: data.isAccess, free: data.free, totalPoint: data.totalPoint, isUserLiked: data.isUserLiked)
                self.isChange?()
                
                self.startAt = data.startAt
                
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
                
                self.likeSum.value = data.like
                self.titleHeaderData.value = TitleHeaderModel(date: data.date, title: data.title, cost: data.totalCost, totalTime: data.totalTime, city: data.city)
                
                
                self.mainContentsData.value = MainContentsModel(description: data.description)
                
                self.timelineData.value = data.places.map { place in
                    TimelineModel(sequence: place.sequence + 1, title: place.title, duration: Float(place.duration))
                }
                
                self.tagArr = data.tags
                
                self.tagData.value = data.tags.map { tag in
                    TagModel(tag: tag.tag)
                }
                
                self.isUserLiked.value = data.isUserLiked
                
                self.isSuccessGetData.value = true
                
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
                
            default:
                self.isSuccessGetData.value = false
                print("Failed to fetch course data")
            }
        }
    }
    
    
    func postUsePoint(courseId: Int, request: PostUsePointRequest) {
        UsePointService().postUsePoint(courseId: self.courseId, request: request)  { result in
            switch result {
            case .success(let response):
                self.isAccess.value = true
                print("🥽Successfully used points:", response)
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            default:
                self.isSuccessGetData.value = false
                print("Failed to post course data")
                
            }
        }
    }
    
    func deleteCourse(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.courseDetailService.deleteCourse(courseId: courseId) { (success: Bool) in
            if success {
                completion(success)
            }
        }
    }
    
    func likeCourse(courseId: Int) {
        LikeCourseService().likeCourse(courseId: courseId) { success in
            if success {
                
            } else {
                print("ffsdasdfsadfsadfsdfdsafs")
            }
        }
    }
    
    func deleteLikeCourse(courseId: Int) {
        LikeCourseService().deleteLikeCourse(courseId: courseId) { success in
            if success {
                
            } else {
                print("dfsadfasdsfasdfadsfdsasf")
            }
        }
    }
    
    func getBannerDetail(advertismentId: Int) {
        self.isSuccessGetBannerData.value = false
        self.onFailNetwork.value = false
        
        NetworkService.shared.courseDetailService.getBannerDetailInfo(advertismentId: advertismentId){ response in
            switch response {
            case .success(let data):
                
                self.imageData.value = data.images.map { ThumbnailModel(imageUrl: $0.imageURL, sequence: $0.sequence)}
                
                self.bannerHeaderData.value = BannerHeaderModel(tag: AdTagType.getAdTag(byEnglish: data.adTagType)?.tag.title ?? "", createAt: data.createAt)
                
                self.bannerDetailTitle = data.title
                
                self.mainContentsData.value = MainContentsModel(description: data.description)
                
                self.isSuccessGetBannerData.value = true
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            case .serverErr:
                self.onFailNetwork.value = true
            default:
                self.isSuccessGetBannerData.value = false
                print("Failed to fetch banner detail data")
            }
        }
    }
    
    func setBannerDetailLoading() {
        guard let isSuccessGetBannerData = self.isSuccessGetBannerData.value else { return }
        self.onLoading.value = isSuccessGetBannerData ? false : true
    }
    
    func setLoading() {
        guard let isSuccessGetData = self.isSuccessGetData.value else {
            return
        }
        
        if isSuccessGetData {
            self.onLoading.value = false
        } else {
            self.onLoading.value = true
        }
    }

    
}
