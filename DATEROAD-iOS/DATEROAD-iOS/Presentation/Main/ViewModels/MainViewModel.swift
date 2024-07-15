//
//  MainViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

final class MainViewModel {
    
    var isSuccessGetUserInfo: ObservablePattern<Bool> = ObservablePattern(false)
    var currentIndex: ObservablePattern<IndexPath> = ObservablePattern(IndexPath(item: 0, section: 2))
    
    var nickname: ObservablePattern<String> = ObservablePattern(nil)
    
    var upcomingData: ObservablePattern<UpcomingDateModel> = ObservablePattern(nil)
    
    var mainUserData: ObservablePattern<MainUserModel> = ObservablePattern(nil)

    var hotCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)
    
    var bannerData: ObservablePattern<[BannerModel]> = ObservablePattern(nil)

    var newCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)

    let sectionData: [MainSection] = MainSection.dataSource
    
    
    init() {
        fetchSectionData()
    }
    
}

extension MainViewModel {
    
    // TODO: - 서버 통신 후 수정 예정
    
    func fetchSectionData() {
        upcomingData.value = UpcomingDateModel.dummyData
        mainUserData.value = MainUserModel.dummyData
        hotCourseData.value = DateCourseModel.hotDateDummyData
        newCourseData.value = DateCourseModel.newDateDummyData
        bannerData.value = BannerModel.bannerDummyData
        nickname.value = MainUserModel.dummyData.name
        getUserProfile()
        getBanner()
    }
    
    func getUserProfile() {
        NetworkService.shared.mainService.getUserProfile() { response in
            switch response {
            case .success(let data):
                self.mainUserData.value = MainUserModel(name: data.name, point: data.point, imageUrl: data.image)
                self.nickname.value = data.name
                self.isSuccessGetUserInfo.value = true
            default:
                print("Failed to fetch user profile")
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
                for i in data.advertisementDtoResList {
                    self.bannerData.value?.append(BannerModel(advertisementId: i.advertisementID, imageUrl: i.thumbnail))
                }
                self.isSuccessGetBanner.value = true
            default:
                print("Failed to fetch user profile")
                return
            }
        }
    }
}
