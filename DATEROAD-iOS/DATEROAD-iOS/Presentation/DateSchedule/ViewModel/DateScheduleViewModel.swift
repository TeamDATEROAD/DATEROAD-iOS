//
//  DateScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

class DateScheduleViewModel {
    var upcomingDateScheduleDummyData = DateScheduleModel(
        dateCards: [
        DateCardModel(dateID: 1, title: "성수동 당일치기 데이트 가볼까요?", date: "June 24", city: "건대/성수/왕십리", tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dDay: 3),
        DateCardModel(dateID: 2, title: "성수동 당일치기 데이트 가볼까요?", date: "June 24", city: "건대/성수/왕십리", tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dDay: 3),
        DateCardModel(dateID: 3, title: "성수동 당일치기 데이트 가볼까요?", date: "June 24", city: "건대/성수/왕십리", tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dDay: 3),
        DateCardModel(dateID: 4, title: "성수동 당일치기 데이트 가볼까요?", date: "June 24", city: "건대/성수/왕십리", tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dDay: 3)
        ]
    )
    
    var isMoreThanFiveSchedule : Bool {
        return (upcomingDateScheduleDummyData.dateCards.count >= 5)
    }
    
    var pastDateScheduleDummyData = DateScheduleModel(
        dateCards: [
            DateCardModel(courseID: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리"),
            DateCardModel(courseID: 2, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리"),
            DateCardModel(courseID: 3, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리")
        ]
    )
    

}
