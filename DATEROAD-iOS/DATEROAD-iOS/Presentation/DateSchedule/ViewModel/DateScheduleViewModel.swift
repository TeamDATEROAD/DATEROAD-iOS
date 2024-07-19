//
//  DateScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

class DateScheduleViewModel {
    
    let dateScheduleService = DateScheduleService()
    
    var upcomingDateScheduleData: ObservablePattern<[DateCardModel]> = ObservablePattern(nil)
    
    var pastDateScheduleData: ObservablePattern<[DateCardModel]> = ObservablePattern(nil)
    
    var currentIndex: ObservablePattern<Int> = ObservablePattern(0)
    
    var isSuccessGetPastDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetUpcomingDateScheduleData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isMoreThanFiveSchedule : Bool {
        return (upcomingDateScheduleData.value?.count ?? 0 >= 5)
    }
    
    init() {
        getPastDateScheduleData()
        getUpcomingDateScheduleData()
    }
    
    func getPastDateScheduleData() {
        dateScheduleService.getDateSchdeule(time: "PAST") { response in
            switch response {
            case .success(let data):
                let dateScheduleInfo = data.dates.map { date in
                    let tagsModel: [TagsModel] = date.tags.map { tag in
                        TagsModel(tag: tag.tag)
                    }
                    return DateCardModel(dateID: date.dateID, title: date.title, date: date.date, city: date.city, tags: tagsModel, dDay: date.dDay)
                }
                self.pastDateScheduleData.value = dateScheduleInfo
                self.isSuccessGetPastDateScheduleData.value = true
                
            case .requestErr:
                print("requestError")
            case .decodedErr:
                print("decodedError")
            case .pathErr:
                print("pathError")
            case .serverErr:
                print("serverError")
            case .networkFail:
                print("networkFail")
            default:
                print("데이터 없이 성공할때")
            }
        }
    }
    
    func getUpcomingDateScheduleData() {
        dateScheduleService.getDateSchdeule(time: "FUTURE") { response in
            switch response {
            case .success(let data):
                let dateScheduleInfo = data.dates.map { date in
                    let tagsModel: [TagsModel] = date.tags.map { tag in
                        TagsModel(tag: tag.tag)
                    }
                    return DateCardModel(dateID: date.dateID, title: date.title, date: (date.date).toReadableDate() ?? "", city: date.city, tags: tagsModel, dDay: date.dDay)
                }
                print("🍎🍎🍎🍎")
                self.upcomingDateScheduleData.value = dateScheduleInfo
                self.isSuccessGetUpcomingDateScheduleData.value = true
            case .requestErr:
                print("requestError")
            case .decodedErr:
                print("decodedError")
            case .pathErr:
                print("pathError")
            case .serverErr:
                print("serverError")
            case .networkFail:
                print("networkFail")
            }
        }
    }


}
