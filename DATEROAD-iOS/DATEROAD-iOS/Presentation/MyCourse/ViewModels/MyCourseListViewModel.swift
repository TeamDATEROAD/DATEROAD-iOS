//
//  MyCourseListViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import Foundation

class MyCourseListViewModel: Serviceable {
    
    var userName: String = ""
    
    let myCourseService = MyCourseService()
    
    var viewedCourseData: ObservablePattern<[MyCourseModel]> = ObservablePattern([])
    
    var myRegisterCourseData: ObservablePattern<[MyCourseModel]> = ObservablePattern([])
    
    var isSuccessGetViewedCourseInfo: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var isSuccessGetNavViewedCourseInfo: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var isSuccessGetMyRegisterCourseInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onViewedCourseLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onNavViewedCourseLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onMyRegisterCourseLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onViewedCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onNavViewedCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onMyRegisterCourseFailNetwork: ObservablePattern<Bool> = ObservablePattern(nil)
    
    init() {
        let name = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.userName = name
        
        setViewedCourseData()
        setMyRegisterCourseData()
        print("@log", myRegisterCourseData.value?.count)
    }
    
    func setViewedCourseData() {
        self.isSuccessGetViewedCourseInfo.value = false
        self.onViewedCourseFailNetwork.value = false
        self.setViewedCourseLoading()
        
        NetworkService.shared.myCourseService.getViewedCourse() { response in
            switch response {
            case .success(let data):
                let viewedCourseInfo = data.courses.map {
                    MyCourseModel(courseId: $0.courseID, thumbnail: $0.thumbnail, title: $0.title, city: $0.city, cost: $0.cost.priceRangeTag(), duration: ($0.duration).formatFloatTime(), like: $0.like)
                }
                self.viewedCourseData.value = viewedCourseInfo
                self.isSuccessGetViewedCourseInfo.value = true
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            case .serverErr:
                self.onViewedCourseFailNetwork.value = true
            default:
                print("내가 열람한 코스 에러")
                self.onViewedCourseFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
        
    func setViewedCourseLoading() {
        guard let isSuccessGetViewedCourseInfo = self.isSuccessGetViewedCourseInfo.value else { return }
        self.onViewedCourseLoading.value = !isSuccessGetViewedCourseInfo
    }
    
    func setNavViewedCourseData() {
        self.isSuccessGetNavViewedCourseInfo.value = false
        self.onNavViewedCourseFailNetwork.value = false
        self.setNavViewedCourseLoading()
        
        NetworkService.shared.myCourseService.getViewedCourse() { response in
            switch response {
            case .success(let data):
                let viewedCourseInfo = data.courses.map {
                    MyCourseModel(courseId: $0.courseID, thumbnail: $0.thumbnail, title: $0.title, city: $0.city, cost: $0.cost.priceRangeTag(), duration: ($0.duration).formatFloatTime(), like: $0.like)
                }
                self.viewedCourseData.value = viewedCourseInfo
                self.isSuccessGetNavViewedCourseInfo.value = true
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            case .serverErr:
                self.onNavViewedCourseFailNetwork.value = true
            default:
                print("내가 열람한 코스 에러")
                self.onNavViewedCourseFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
    
    func setNavViewedCourseLoading() {
        guard let isSuccessGetNavViewedCourseInfo = self.isSuccessGetNavViewedCourseInfo.value else { return }
        self.onNavViewedCourseLoading.value = !isSuccessGetNavViewedCourseInfo
    }
    
    func setMyRegisterCourseData() {
        self.isSuccessGetMyRegisterCourseInfo.value = false
        self.onMyRegisterCourseFailNetwork.value = false
        self.setMyRegisterCourseLoading()
        
        NetworkService.shared.myCourseService.getMyRegisterCourse() { response in
            switch response {
            case .success(let data):
                let myRegisterCourseInfo = data.courses.map {
                    MyCourseModel(courseId: $0.courseID, thumbnail: $0.thumbnail, title: $0.title, city: $0.city, cost: ($0.cost).priceRangeTag(), duration: ($0.duration).formatFloatTime(), like: $0.like)
                }
                self.myRegisterCourseData.value = myRegisterCourseInfo
                self.isSuccessGetMyRegisterCourseInfo.value = true
                print("isUpdate>", self.myRegisterCourseData)
            case .reIssueJWT:
                self.onReissueSuccess.value = self.patchReissue()
            case .serverErr:
                self.onMyRegisterCourseFailNetwork.value = true
            default:
                print("내가 등록한 코스 에러")
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
