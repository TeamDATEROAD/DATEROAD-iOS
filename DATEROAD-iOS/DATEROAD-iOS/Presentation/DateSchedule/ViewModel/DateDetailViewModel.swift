//
//  DateDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

class DateDetailViewModel {
   
    var upcomingDateDetailDummyData = DateDetailModel(
        dateID: 1,
        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
        startAt: "12:00",
        city: "건대/성수/왕십리",
        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
        date: "June 24",
        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,           sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1)]
    )
    
    
    var pastDateDetailDummyData = DateDetailModel(
        dateID: 1,
        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
        startAt: "12:00",
        city: "건대/성수/왕십리",
        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
        date: "June 24",
        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,           sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1)]
    )
    
    func shareToKaKao() {
        
    }
}

