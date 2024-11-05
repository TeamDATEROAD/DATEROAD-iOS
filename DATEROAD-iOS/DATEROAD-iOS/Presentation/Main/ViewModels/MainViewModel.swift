//
//  MainViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

final class MainViewModel: Serviceable {
    
    var currentIndex: ObservablePattern<IndexPath> = ObservablePattern(IndexPath(item: 0, section: 2))
    
    var nickname: ObservablePattern<String> = ObservablePattern(nil)
    
    var upcomingData: ObservablePattern<UpcomingDateModel> = ObservablePattern(nil)
    
    var mainUserData: ObservablePattern<MainUserModel> = ObservablePattern(nil)
    
    var hotCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)
    
    var bannerData: ObservablePattern<[BannerModel]> = ObservablePattern(nil)
    
    var newCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)
    
    let sectionData: [MainSection] = MainSection.dataSource
    
    var updateSectionIndex: ObservablePattern<Int> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var isAllLoaded: (() -> Void)?
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var courseListId: String = ""
    
    var courseListTitle: String = ""
    
    var courseListLocation: String = ""
    
    var courseListCost: String = ""
    
    var count: Int = 0
    
    var totalFetchCount: Int = 0
    
}

extension MainViewModel {
    
    func fetchSectionData() {
        initProperty()
        setLoading(true)
        getBanner()
        getUserProfile()
        getDateCourse(sortBy: StringLiterals.Main.popular)
        getDateCourse(sortBy: StringLiterals.Main.latest)
        getUpcomingDateCourse()
    }
    
    func getUserProfile() {
        self.onFailNetwork.value = false
        
        NetworkService.shared.mainService.getMainUserProfile() { response in
            switch response {
            case .success(let data):
                if self.mainUserData.value != MainUserModel(name: data.name, point: data.point, imageUrl: data.image) {
                    self.mainUserData.value = MainUserModel(name: data.name, point: data.point, imageUrl: data.image)
                    self.nickname.value = data.name
                    self.updateSectionIndex.value = 0
                }
                UserDefaults.standard.setValue(data.name, forKey: StringLiterals.Network.userName)
                UserDefaults.standard.setValue(data.point, forKey: StringLiterals.Network.userPoint)
                AmplitudeManager.shared.setUserProperty(userProperties: [
                    StringLiterals.Amplitude.UserProperty.userName:  data.name,
                    StringLiterals.Amplitude.UserProperty.userPoint:  data.point])
                
                self.totalFetchCount += 1
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch user profile")
                self.onFailNetwork.value = true
                return
            }
            self.checkLoadingStatus()
        }
    }
    
    func getDateCourse(sortBy: String) {
        var dateData: [DateCourseModel] = []
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
                
                self.courseListId += sortBy == StringLiterals.Main.popular ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListTitle += sortBy == StringLiterals.Main.popular ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListLocation += sortBy == StringLiterals.Main.popular ? StringLiterals.Main.hot : StringLiterals.Main.new
                self.courseListCost += sortBy == StringLiterals.Main.popular ? StringLiterals.Main.hot : StringLiterals.Main.new
                
                self.sortCourseType(type: sortBy, dateData: dateData)
                
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
                self.totalFetchCount += 1
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch filtered date course")
                self.onFailNetwork.value = true
                return
            }
            self.checkLoadingStatus()
        }
    }
    
    func getUpcomingDateCourse() {
        self.onFailNetwork.value = false
        var newData: UpcomingDateModel = UpcomingDateModel.emptyData
        
        NetworkService.shared.mainService.getUpcomingDate() { response in
            switch response {
            case .success(let data):
                newData = UpcomingDateModel(dateId: data.dateID,
                                                            dDay: data.dDay,
                                                            dateName: data.dateName,
                                                            month: data.month,
                                                            day: data.day,
                                                            startAt: data.startAt)
                if self.upcomingData.value != newData {
                    self.upcomingData.value = newData
                    self.updateSectionIndex.value = 0
                }
                self.totalFetchCount += 1
            case .requestErr:
                self.upcomingData.value = nil
                self.totalFetchCount += 1
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch upcoming date course")
                self.onFailNetwork.value = false
                return
            }
            self.checkLoadingStatus()
        }
    }
    
    func getBanner() {
        var newData: [BannerModel] = []
        self.onFailNetwork.value = false
        
        NetworkService.shared.mainService.getBanner() { response in
            switch response {
            case .success(let data):
                newData = data.advertisementDtoResList.map { BannerModel(advertisementId: $0.advertisementID, imageUrl: $0.thumbnail) }
                guard let last = newData.last, let first = newData.first else { return }
                newData.insert(last, at: 0)
                newData.append(first)
                
                if newData != self.bannerData.value {
                    self.bannerData.value = newData
                    self.updateSectionIndex.value = 2
                }
                self.totalFetchCount += 1
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch get banner data")
                self.onFailNetwork.value = true
                return
            }
            self.checkLoadingStatus()
        }
    }
    
    private func checkLoadingStatus() {
        // 모든 데이터 요청이 성공적으로 완료되었는지 확인
        if totalFetchCount != 0 && totalFetchCount % 5 == 0 {
            self.isAllLoaded?()
        }
    }
    
    func setLoading(_ loadingStatus: Bool) {
        self.onLoading.value = loadingStatus
    }
    
    func initProperty() {
        courseListId = ""
        courseListTitle = ""
        courseListLocation = ""
        courseListCost = ""
        count = 0
    }
    
    func sortCourseType(type: String, dateData: [DateCourseModel]) {
        if type == StringLiterals.Main.popular {
            if self.hotCourseData.value != dateData {
                self.hotCourseData.value = dateData
                self.updateSectionIndex.value = 1
            }
        } else {
            if self.newCourseData.value != dateData {
                self.newCourseData.value = dateData
                self.updateSectionIndex.value = 3
            }
        }
    }
    
}
