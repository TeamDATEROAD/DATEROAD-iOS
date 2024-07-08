//
//  DateScheduleModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

struct DateCardModel {
    let courseID: Int?
    let bgColor: Int?
    let dateCalendar: String?
    let dDay: Int?
    let tags: [String?]
    let dateTitle: String?
    let dateLocation: String?
    
    init(courseID: Int?, bgColor: Int?, dateCalendar: String?, dDay: Int?, tags: [String?], dateTitle: String?, dateLocation: String?) {
        self.courseID = courseID
        self.bgColor = bgColor
        self.dateCalendar = dateCalendar
        self.dDay = dDay
        self.tags = tags
        self.dateTitle = dateTitle
        self.dateLocation = dateLocation
    }
}

struct DateScheduleModel {
    let dateCards: [DateCardModel]
    
    init(dateCards: [DateCardModel]) {
        self.dateCards = dateCards
    }
}

struct DateDetailModel {
    let places: [DatePlacesModel]
    
    init(places: [DatePlacesModel]) {
        self.places = places
    }
}

struct DatePlacesModel {
    let title: String?
    let duration: Float?
    
    init(title: String?, duration: Float?) {
        self.title = title
        self.duration = duration
    }
}
