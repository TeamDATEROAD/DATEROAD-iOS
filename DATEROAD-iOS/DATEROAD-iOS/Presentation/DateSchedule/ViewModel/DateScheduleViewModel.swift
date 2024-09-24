//
//  DateScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

final class DateScheduleViewModel: Serviceable {
    
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
                    return DateCardModel(dateID: date.dateID, title: date.title, date: date.date.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일") ?? "", city: date.city, tags: tagsModel, dDay: date.dDay)
                }
                
                self.pastDateScheduleData.value = dateScheduleInfo
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
                    return DateCardModel(dateID: date.dateID, title: date.title, date: (date.date).toReadableDate() ?? "", city: date.city , tags: tagsModel, dDay: date.dDay)
                }
                
                AmplitudeManager.shared.setUserProperty(userProperties: [StringLiterals.Amplitude.UserProperty.dateScheduleNum : dateScheduleInfo.count])
                self.upcomingDateScheduleData.value = dateScheduleInfo
                self.isSuccessGetUpcomingDateScheduleData.value = true
                print("🍎🍎뷰모델 서버통신 성공🍎🍎", self.isSuccessGetUpcomingDateScheduleData.value)
            case .serverErr:
                self.onUpcomingScheduleFailNetwork.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.isSuccessGetUpcomingDateScheduleData.value = false
                print("false?")
            }
            self.setUpcomingScheduleLoading()
        }
    }
    
    func setUpcomingScheduleLoading() {
        guard let isSuccessGetUpcomingDateScheduleData = self.isSuccessGetUpcomingDateScheduleData.value else { return }
        self.onUpcomingScheduleLoading.value = !isSuccessGetUpcomingDateScheduleData
     }

}
