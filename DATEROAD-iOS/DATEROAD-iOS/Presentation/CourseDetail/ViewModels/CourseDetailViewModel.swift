//
//  CourseDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

final class CourseDetailViewModel: Serviceable {
    
    let updateConditionalData: ObservablePattern<Bool> = ObservablePattern(false)
    
    private var currentConditionalData: ConditionalModel?
    
    private var currentImageData: [ThumbnailModel]?
    
    private var currentLikeSum: Int?
    
    private var currentTitleHeaderData: TitleHeaderModel?
    
    private var currentMainContentsData: MainContentsModel?
    
    private var currentTimelineData: [TimelineModel]?
    
    private var currentTagData: [TagModel]?
    
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
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
            
    var numberOfSections: Int = 6
    
    var isChange: (() -> Void)?
    
    var startAt: String = ""
    
    var tagArr = [GetCourseDetailTag]()
    
    var userFreeRemained: String = ""
    
    var courseListId: String = ""
    
    var courseListTitle: String = ""
    
    var purchaseSuccess: Bool = false
    
    var errMessage: ObservablePattern<String> = ObservablePattern(nil)
    
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
        self.isSuccessGetData.value = false
        self.onFailNetwork.value = false
        
        NetworkService.shared.courseDetailService.getCourseDetailInfo(courseId: courseId){ response in
            switch response {
            case .success(let data):
                dump(data)
                
                let newConditionalData = ConditionalModel(
                    courseId: self.courseId,
                    isCourseMine: data.isCourseMine,
                    isAccess: data.isAccess,
                    free: data.free,
                    totalPoint: data.totalPoint,
                    isUserLiked: data.isUserLiked
                )
                
                if self.currentConditionalData != newConditionalData {
                    self.currentConditionalData = newConditionalData
                    self.conditionalData.value = newConditionalData
                    self.isChange?()
                    self.updateConditionalData.value = true
                }
                
                self.purchaseSuccess = data.isAccess
                self.startAt = data.startAt
                self.havePoint.value = data.totalPoint >= 50
                self.haveFreeCount.value = data.free > 0 && data.free <= 3
                self.isAccess.value = data.isAccess
                self.isCourseMine.value = data.isCourseMine
                
                let newImageData = data.images.map {ThumbnailModel(imageUrl: $0.imageURL, sequence: $0.sequence)}
                if self.currentImageData != newImageData {
                    self.currentImageData = newImageData
                    self.imageData.value = newImageData
                    self.updateConditionalData.value = true
                }
                
                if self.currentLikeSum != data.like {
                    self.currentLikeSum = data.like
                    self.likeSum.value = data.like
                    self.updateConditionalData.value = true
                }
                
                let newTitleHeaderData = TitleHeaderModel(date: data.date, title: data.title, cost: data.totalCost, totalTime: data.totalTime, city: data.city)
                if self.currentTitleHeaderData != newTitleHeaderData {
                    self.currentTitleHeaderData = newTitleHeaderData
                    self.titleHeaderData.value = newTitleHeaderData
                    self.updateConditionalData.value = true
                }
                
                let newMainContentsData = MainContentsModel(description: data.description)
                if self.currentMainContentsData != newMainContentsData {
                    self.currentMainContentsData = newMainContentsData
                    self.mainContentsData.value = newMainContentsData
                    self.updateConditionalData.value = true
                }
                
                let newTimelineData = data.places.map { place in
                    TimelineModel(sequence: place.sequence, title: place.title, duration: Float(place.duration))
                }
                if self.currentTimelineData != newTimelineData {
                    self.currentTimelineData = newTimelineData
                    self.timelineData.value = newTimelineData
                    self.updateConditionalData.value = true
                }
                
                self.tagArr = data.tags
                
                let newTagData = data.tags.map { tag in
                    TagModel(tag: tag.tag)
                }
                if self.currentTagData != newTagData {
                    self.currentTagData = newTagData
                    self.tagData.value = newTagData
                    self.updateConditionalData.value = true
                }
                
                self.isUserLiked.value = data.isUserLiked
                self.isSuccessGetData.value = true
                self.userFreeRemained = "\(data.free)"
                self.courseListId = "\(data.courseID)"
                self.courseListTitle = "\(data.title)"
                
                AmplitudeManager.shared.setUserProperty(userProperties: [StringLiterals.Amplitude.UserProperty.userFreeRemained : data.free])
                AmplitudeManager.shared.trackEventWithProperties(
                    StringLiterals.Amplitude.EventName.viewCourseDetails,
                    properties: [
                        StringLiterals.Amplitude.Property.courseListId: self.courseListId,
                        StringLiterals.Amplitude.Property.courseListTitle: self.courseListTitle
                    ]
                )
                
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .notFoundErr:
                self.errMessage.value = StringLiterals.Alert.notFound
            default:
                self.onFailNetwork.value = true
                print("Failed to fetch course data")
            }
        }
    }
    
    func postUsePoint(courseId: Int, request: PostUsePointRequest) {
        NetworkService.shared.usePointService.postUsePoint(courseId: self.courseId, request: request)  { result in
            switch result {
            case .success(let response):
                self.isAccess.value = true
                print("🥽Successfully used points:", response)
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.isSuccessGetData.value = false
                print("Failed to post course data")
                
            }
        }
    }
    
    func deleteCourse(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.courseDetailService.deleteCourse(courseId: courseId) { (success: Bool) in
            completion(success)
        }
    }
    
    func likeCourse(courseId: Int, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.likedCourseService.likeCourse(courseId: courseId) { success in
            completion(success)
        }
    }
    
    func deleteLikeCourse(courseId: Int, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.likedCourseService.deleteLikeCourse(courseId: courseId) { success in
            completion(success)
        }
    }

    func setLoading() {
        guard let isSuccessGetData = self.isSuccessGetData.value else { return }
        self.onLoading.value = !isSuccessGetData
    }
    
}
