//
//  MainViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

final class MainViewModel: Serviceable {
    
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
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var courseListId: String = ""
    
    var courseListTitle: String = ""
    
    var courseListLocation: String = ""
    
    var courseListCost: String = ""

    var count: Int = 0

}

extension MainViewModel {
    
    func fetchSectionData() {
        initProperty()
        setLoading()
        getBanner()
        getUserProfile()
        getDateCourse(sortBy: StringLiterals.Main.hot)
        getDateCourse(sortBy: StringLiterals.Main.new)
        getUpcomingDateCourse()
    }
    
    func getUserProfile() {
        self.isSuccessGetUserInfo.value = false
        self.onFailNetwork.value = false
        
        NetworkService.shared.mainService.getMainUserProfile() { response in
            switch response {
            case .success(let data):
                self.mainUserData.value = MainUserModel(name: data.name, point: data.point, imageUrl: data.image)
                self.nickname.value = data.name
                UserDefaults.standard.setValue(data.name, forKey: StringLiterals.Network.userName)
                UserDefaults.standard.setValue(data.point, forKey: StringLiterals.Network.userPoint)
                AmplitudeManager.shared.setUserProperty(userProperties: [
                    StringLiterals.Amplitude.UserProperty.userName:  data.name,
                    StringLiterals.Amplitude.UserProperty.userPoint:  data.point])
                
                self.isSuccessGetUserInfo.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = true
            default:
                print("Failed to fetch user profile")
                return
            }
        }
    }
    
    func getDateCourse(sortBy: String) {
        var dateData: [DateCourseModel] = []
        self.sortCourseType(type: sortBy, isSuccessGetData: false, dateData: dateData)
        self.onFailNetwork.value = false
        
        NetworkService.shared.mainService.getFilteredDateCourse(sortBy: sortBy) { response in
            switch response {
            case .success(let data):
                dateData = data.courses.map { DateCourseModel(courseId: $0.courseID,
                                                                              thumbnail: $0.thumbnail,
                                                                              title: $0.title,
                                                                              city: $0.city,
                                                                              like: $0.like,
                                                                              cost: $0.cost,
                                                                              duration: $0.duration.formatFloatTime()) }
                
                self.courseListId += sortBy == StringLiterals.Main.hot ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListTitle += sortBy == StringLiterals.Main.hot ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListLocation += sortBy == StringLiterals.Main.hot ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListCost += sortBy == StringLiterals.Main.hot ? StringLiterals.Main.hot : StringLiterals.Main.new

                self.sortCourseType(type: sortBy, isSuccessGetData: true, dateData: dateData)

                dateData.forEach {
                    self.courseListId += "\($0.courseId) "
                    self.courseListTitle += "\($0.title) "
                    self.courseListLocation += "\($0.city) "
                    self.courseListCost += "\($0.cost) "
                }

                self.count += 1
                if self.count == 2 {
                    AmplitudeManager.shared.trackEventWithProperties(StringLiterals.Amplitude.EventName.viewMain,
                                                                     properties: [StringLiterals.Amplitude.Property.courseListId: self.courseListId,
                                                                                  StringLiterals.Amplitude.Property.courseListTitle: self.courseListTitle,
                                                                                  StringLiterals.Amplitude.Property.courseListLocation: self.courseListLocation,
                                                                                  StringLiterals.Amplitude.Property.courseListCost: self.courseListCost])
                }
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = true
            default:
                print("Failed to fetch filtered date course")
                return
            }
        }
    }
    
    func getUpcomingDateCourse() {
        self.isSuccessGetUpcomingDate.value = false
        self.onFailNetwork.value = false
        
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
            case .requestErr:
                self.isSuccessGetUpcomingDate.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = false
            default:
                print("Failed to fetch upcoming date course")
                return
            }
        }
    }
    
    func getBanner() {
        self.isSuccessGetBanner.value = false
        self.onFailNetwork.value = false
        
        NetworkService.shared.mainService.getBanner() { response in
            switch response {
            case .success(let data):
                self.bannerData.value = data.advertisementDtoResList.map { BannerModel(advertisementId: $0.advertisementID, imageUrl: $0.thumbnail)
                }
                
                // 앞뒤에 아이템을 추가하여 무한 스크롤 구현
                guard let last = self.bannerData.value?.last, let first = self.bannerData.value?.first else { return }
                self.bannerData.value?.insert(last, at: 0)
                self.bannerData.value?.append(first)
                self.isSuccessGetBanner.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = true
            default:
                print("Failed to fetch get banner data")
                return
            }
        }
    }
    
    func setLoading() {
        guard let isSuccessGetUserInfo = self.isSuccessGetUserInfo.value,
              let isSuccessGetHotDate = self.isSuccessGetHotDate.value,
              let isSuccessGetBanner = self.isSuccessGetBanner.value,
              let isSuccessGetNewDate = self.isSuccessGetNewDate.value,
              let isSuccessGetUpcomingDate = self.isSuccessGetUpcomingDate.value
        else { return }
        
        if isSuccessGetUserInfo
            && isSuccessGetHotDate
            && isSuccessGetUpcomingDate
            && isSuccessGetBanner
            && isSuccessGetNewDate {
            self.onLoading.value = false
        } else {
            self.onLoading.value = true
        }
    }
    
    func initProperty() {
        courseListId = ""
        courseListTitle = ""
        courseListLocation = ""
        courseListCost = ""
        count = 0
    }
    
    func sortCourseType(type: String, isSuccessGetData: Bool, dateData: [DateCourseModel]) {
        if type == StringLiterals.Main.hot {
            self.hotCourseData.value = dateData
            self.isSuccessGetHotDate.value = isSuccessGetData
        } else {
            self.newCourseData.value = dateData
            self.isSuccessGetNewDate.value = isSuccessGetData
        }
    }

}
