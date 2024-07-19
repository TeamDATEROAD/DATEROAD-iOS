//
//  MainViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

final class MainViewModel {
    
    var isSuccessGetUserInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetHotDate: ObservablePattern<Bool> = ObservablePattern(false)

    var isSuccessGetBanner: ObservablePattern<Bool> = ObservablePattern(false)

    var isSuccessGetNewDate: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetUpcomingDate: ObservablePattern<Bool> = ObservablePattern(false)
        
    var currentIndex: ObservablePattern<IndexPath> = ObservablePattern(IndexPath(item: 0, section: 2))
    
    var nickname: ObservablePattern<String> = ObservablePattern(nil)
    
    var upcomingData: ObservablePattern<UpcomingDateModel> = ObservablePattern(nil)
    
    var mainUserData: ObservablePattern<MainUserModel> = ObservablePattern(nil)

    var hotCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)
    
    var bannerData: ObservablePattern<[BannerModel]> = ObservablePattern(nil)

    var newCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)

    let sectionData: [MainSection] = MainSection.dataSource
    
    
//    init() {
//        fetchSectionData()
//    }
    
}

extension MainViewModel {
        
    func fetchSectionData() {
        getUserProfile()
        getDateCourse(sortBy: "POPULAR")
        getDateCourse(sortBy: "LATEST")
        getBanner()
        getUpcomingDateCourse()
    }
    
    func getUserProfile() {
        NetworkService.shared.mainService.getMainUserProfile() { response in
            switch response {
            case .success(let data):
                self.mainUserData.value = MainUserModel(name: data.name, point: data.point, imageUrl: data.image)
                self.nickname.value = data.name
               UserDefaults.standard.setValue(data.name, forKey: "userName")
                UserDefaults.standard.setValue(data.point, forKey: "userPoint")
                self.isSuccessGetUserInfo.value = true
            default:
                print("Failed to fetch user profile")
                return
            }
        }
    }
    
    func getDateCourse(sortBy: String) {
        NetworkService.shared.mainService.getFilteredDateCourse(sortBy: sortBy) { response in
            switch response {
            case .success(let data):
                if sortBy == "POPULAR" {
                    self.hotCourseData.value = data.courses.map { DateCourseModel(courseId: $0.courseID,
                                                                                  thumbnail: $0.thumbnail,
                                                                                  title: $0.title,
                                                                                  city: $0.city,
                                                                                  like: $0.like,
                                                                                  cost: $0.cost,
                                                                                  duration: $0.duration.formatFloatTime()) }
                    self.isSuccessGetHotDate.value = true
                } else {
                    self.newCourseData.value = data.courses.map { DateCourseModel(courseId: $0.courseID,
                                                                                  thumbnail: $0.thumbnail,
                                                                                  title: $0.title,
                                                                                  city: $0.city,
                                                                                  like: $0.like,
                                                                                  cost: $0.cost,
                                                                                  duration: $0.duration.formatFloatTime()) }
                    self.isSuccessGetNewDate.value = true
                }
            default:
                print("Failed to fetch filtered date course")
                return
            }
        }
    }
    
    func getUpcomingDateCourse() {
        NetworkService.shared.mainService.getUpcomingDate() { response in
            switch response {
            case .success(let data):
                self.upcomingData.value = UpcomingDateModel(dateId: data.dateID,
                                                            dDay: data.dDay,
                                                            dateName: data.dateName,
                                                            month: data.month,
                                                            day: data.day,
                                                            startAt: data.startAt)
                self.isSuccessGetUpcomingDate.value = true
            default:
                print("Failed to fetch upcoming date course")
                return
            }
        }
    }
    
    func getBanner() {
        NetworkService.shared.mainService.getBanner() { response in
            switch response {
            case .success(let data):
                self.bannerData.value = data.advertisementDtoResList.map { BannerModel(advertisementId: $0.advertisementID, imageUrl: $0.thumbnail)
                }
                self.isSuccessGetBanner.value = true
            default:
                print("Failed to fetch user profile")
                return
            }
        }
    }
}
