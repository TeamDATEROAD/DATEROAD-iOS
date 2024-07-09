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
        DateCardModel(courseID: 1, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리"),
        DateCardModel(courseID: 2, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리"),
        DateCardModel(courseID: 3, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리")
        ]
    )
    
    
    var pastDateScheduleDummyData = DateScheduleModel(
        dateCards: [
        DateCardModel(courseID: 1, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요? 이정도 어떠신지?", dateLocation: "건대/성수/왕십리"),
        DateCardModel(courseID: 2, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요? 이정도 어떠신지?", dateLocation: "건대/성수/왕십리"),
        DateCardModel(courseID: 3, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요? 이정도 어떠신지?", dateLocation: "건대/성수/왕십리")
        ]
    )

}
