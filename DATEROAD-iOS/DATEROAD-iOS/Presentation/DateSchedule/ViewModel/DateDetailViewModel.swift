//
//  DateDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

class DateDetailViewModel {
    var upcomingDateCardDummyData =
        DateCardModel(courseID: 1, bgColor: 1, dateCalendar: "June 24", dDay: 3, tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"], dateTitle: "성수동 당일치기 데이트 가볼까요?", dateLocation: "건대/성수/왕십리")
    
    var upcomingDateDetailDummyData = DateDetailModel(
        places: [DatePlacesModel(title: "성수미술관 성수점", duration: 2),
                 DatePlacesModel(title: "성수미술관 성수점", duration: 2),
                 DatePlacesModel(title: "성수미술관 성수점", duration: 2),
                 DatePlacesModel(title: "성수미술관 성수점", duration: 2),
                 DatePlacesModel(title: "성수미술관 성수점", duration: 2),
                 DatePlacesModel(title: "성수미술관 성수점", duration: 2)]
    )
}

