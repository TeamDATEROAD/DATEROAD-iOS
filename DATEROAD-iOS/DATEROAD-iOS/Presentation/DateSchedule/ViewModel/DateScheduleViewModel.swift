//
//  DateScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

final class DateScheduleViewModel: Serviceable {
    
    let updatePastDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    let updateUpcomingDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var upcomingDateScheduleData: ObservablePattern<[DateCardModel]> = ObservablePattern(nil)
    
    var pastDateScheduleData: ObservablePattern<[DateCardModel]> = ObservablePattern([])
    
    var currentIndex: ObservablePattern<Int> = ObservablePattern(0)
    
    var isSuccessGetPastDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetUpcomingDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isMoreThanFiveSchedule : Bool {
        return (upcomingDateScheduleData.value?.count ?? 0 >= 5)
    }
    
    var onPastScheduleLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onPastScheduleFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onUpcomingScheduleLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onUpcomingScheduleFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    init() {
        getUpcomingDateScheduleData()
    }
    
    // 지난 데이트 일정 (상세보기X)
    func getPastDateScheduleData() {
        self.isSuccessGetPastDateScheduleData.value = false
        self.setPastScheduleLoading()
        self.onPastScheduleFailNetwork.value = false
        
        NetworkService.shared.dateScheduleService.getDateSchdeule(time: "PAST") { response in
            switch response {
            case .success(let data):
                let dateScheduleInfo = data.dates.map { date in
                    let tagsModel: [TagsModel] = date.tags.map { tag in
                        TagsModel(tag: tag.tag)
                    }
                    return DateCardModel(dateID: date.dateID,
                                         title: date.title,
                                         date: date.date.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일") ?? "",
                                         city: date.city,
                                         tags: tagsModel,
                                         dDay: date.dDay)
                }
                
                if self.pastDateScheduleData.value != dateScheduleInfo {
                    self.pastDateScheduleData.value = dateScheduleInfo
                    self.updatePastDateScheduleData.value = true
                }
                
                self.isSuccessGetPastDateScheduleData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onPastScheduleFailNetwork.value = true
            }
        }
    }
    
    func setPastScheduleLoading() {
        guard let isSuccessGetPastDateScheduleData = self.isSuccessGetPastDateScheduleData.value else { return }
        self.onPastScheduleLoading.value = !isSuccessGetPastDateScheduleData
    }
    
    // 다가올 데이트 일정 (상세보기X)
    func getUpcomingDateScheduleData() {
        self.isSuccessGetUpcomingDateScheduleData.value = false
        self.setUpcomingScheduleLoading()
        self.onUpcomingScheduleFailNetwork.value = false
        
        NetworkService.shared.dateScheduleService.getDateSchdeule(time: "FUTURE") { response in
            switch response {
            case .success(let data):
                let dateScheduleInfo = data.dates.map { date in
                    let tagsModel: [TagsModel] = date.tags.map { tag in
                        TagsModel(tag: tag.tag)
                    }
                    return DateCardModel(dateID: date.dateID,
                                         title: date.title,
                                         date: (date.date).toReadableDate() ?? "",
                                         city: date.city ,
                                         tags: tagsModel,
                                         dDay: date.dDay)
                }
                let dateScheduleNum = data.dates.count
                AmplitudeManager.shared.setUserProperty(userProperties: [StringLiterals.Amplitude.UserProperty.dateScheduleNum : dateScheduleInfo.count])
                AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.viewDateSchedule)
                AmplitudeManager.shared.trackEventWithProperties(StringLiterals.Amplitude.EventName.countDateSchedule, properties: [StringLiterals.Amplitude.Property.dateScheduleNum : dateScheduleNum])
                
                if self.upcomingDateScheduleData.value != dateScheduleInfo {
                    self.upcomingDateScheduleData.value = dateScheduleInfo
                    self.updateUpcomingDateScheduleData.value = true
                }
                
                self.isSuccessGetUpcomingDateScheduleData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onUpcomingScheduleFailNetwork.value = true
            }
            self.setUpcomingScheduleLoading()
        }
    }
    
    func setUpcomingScheduleLoading() {
        guard let isSuccessGetUpcomingDateScheduleData = self.isSuccessGetUpcomingDateScheduleData.value else { return }
        self.onUpcomingScheduleLoading.value = !isSuccessGetUpcomingDateScheduleData
    }
    
}
