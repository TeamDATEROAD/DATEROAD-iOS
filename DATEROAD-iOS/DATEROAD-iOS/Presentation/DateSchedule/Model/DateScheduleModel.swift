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
