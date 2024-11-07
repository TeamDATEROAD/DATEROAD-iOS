//
//  MyCourseListViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import Foundation

final class MyCourseListViewModel: Serviceable {
    
    var viewedCoursesModel = ViewedCoursesManager.shared.viewedCoursesModel
    
    var broughtViewedCoursesModel = BroughtViewedCoursesManager.shared.broughtViewedCoursesModel
    
    var myRegisterCoursesModel = MyRegisterCoursesManager.shared.myRegisterCoursesModel
    
    var viewedCoursesModelIsUpdate: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var broughtViewedCoursesModelIsUpdate: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var myRegisterCoursesModelIsUpdate: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var viewedCourseData: ObservablePattern<[MyCourseModel]> = ObservablePattern([])
    
    var myRegisterCourseData: ObservablePattern<[MyCourseModel]> = ObservablePattern([])
    
    var isSuccessGetViewedCourseInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetNavViewedCourseInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetMyRegisterCourseInfo: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onViewedCourseLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onNavViewedCourseLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onMyRegisterCourseLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onViewedCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onNavViewedCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onMyRegisterCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    init() {
        setViewedCourseData()
        setMyRegisterCourseData()
    }
    
    // '열람한 코스'(탭바) _ viewedCoursesModel
    func setViewedCourseData() {
        self.isSuccessGetViewedCourseInfo.value = false
        self.onViewedCourseFailNetwork.value = false
        
        NetworkService.shared.myCourseService.getViewedCourse() { response in
            switch response {
            case .success(let data):
                let viewedCourseInfo = data.courses.map { MyCourseModel(courseId: $0.courseID,
                                                                        thumbnail: $0.thumbnail,
                                                                        title: $0.title,
                                                                        city: $0.city,
                                                                        cost: $0.cost.priceRangeTag(),
                                                                        duration: ($0.duration).formatFloatTime(),
                                                                        like: $0.like) }
                AmplitudeManager.shared.setUserProperty(userProperties: [StringLiterals.Amplitude.UserProperty.userPurchaseCount: viewedCourseInfo.count])
                
                if self.viewedCoursesModel != viewedCourseInfo {
                    self.viewedCourseData.value = viewedCourseInfo
                    self.viewedCoursesModel = viewedCourseInfo
                    self.viewedCoursesModelIsUpdate.value = true
                }
                
                self.isSuccessGetViewedCourseInfo.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onViewedCourseFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
    
    func setViewedCourseLoading() {
        guard let isSuccessGetViewedCourseInfo = self.isSuccessGetViewedCourseInfo.value else { return }
        self.onViewedCourseLoading.value = !isSuccessGetViewedCourseInfo
    }
    
    // 일정등록(불러오기 '내가 열람한 코스') _ broughtViewedCoursesModel
    func setNavViewedCourseData() {
        self.isSuccessGetNavViewedCourseInfo.value = false
        self.onNavViewedCourseFailNetwork.value = false
        
        NetworkService.shared.myCourseService.getViewedCourse() { response in
            switch response {
            case .success(let data):
                let viewedCourseInfo = data.courses.map { MyCourseModel(courseId: $0.courseID,
                                                                        thumbnail: $0.thumbnail,
                                                                        title: $0.title,
                                                                        city: $0.city,
                                                                        cost: $0.cost.priceRangeTag(),
                                                                        duration: ($0.duration).formatFloatTime(),
                                                                        like: $0.like) }
                
                if self.broughtViewedCoursesModel != viewedCourseInfo {
                    self.viewedCourseData.value = viewedCourseInfo
                    self.broughtViewedCoursesModel = viewedCourseInfo
                    self.broughtViewedCoursesModelIsUpdate.value = true
                }
                
                self.isSuccessGetNavViewedCourseInfo.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onNavViewedCourseFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
    
    func setNavViewedCourseLoading() {
        guard let isSuccessGetNavViewedCourseInfo = self.isSuccessGetNavViewedCourseInfo.value else { return }
        self.onNavViewedCourseLoading.value = !isSuccessGetNavViewedCourseInfo
    }
    
    // 내가 등록한 코스
    func setMyRegisterCourseData() {
        self.isSuccessGetMyRegisterCourseInfo.value = false
        self.onMyRegisterCourseFailNetwork.value = false
        
        NetworkService.shared.myCourseService.getMyRegisterCourse() { response in
            switch response {
            case .success(let data):
                let myRegisterCourseInfo = data.courses.map { MyCourseModel(courseId: $0.courseID,
                                                                            thumbnail: $0.thumbnail,
                                                                            title: $0.title,
                                                                            city: $0.city,
                                                                            cost: ($0.cost).priceRangeTag(),
                                                                            duration: ($0.duration).formatFloatTime(),
                                                                            like: $0.like) }
                AmplitudeManager.shared.setUserProperty(userProperties: [StringLiterals.Amplitude.UserProperty.userCourseCount: myRegisterCourseInfo.count])
                
                if self.myRegisterCoursesModel != myRegisterCourseInfo {
                    self.myRegisterCourseData.value = myRegisterCourseInfo
                    self.myRegisterCoursesModel = myRegisterCourseInfo
                    self.myRegisterCoursesModelIsUpdate.value = true
                }
                
                self.isSuccessGetMyRegisterCourseInfo.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onMyRegisterCourseFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
    
    func setMyRegisterCourseLoading() {
        guard let isSuccessGetMyRegisterCourseInfo = self.isSuccessGetMyRegisterCourseInfo.value else { return }
        self.onMyRegisterCourseLoading.value = !isSuccessGetMyRegisterCourseInfo
    }
    
}
