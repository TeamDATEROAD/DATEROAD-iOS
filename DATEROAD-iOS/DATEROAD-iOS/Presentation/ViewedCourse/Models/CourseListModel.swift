//
//  MyCourseListModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import Foundation

struct MyCourseListModel {
    let courseID: Int?
    let courseLike: Int?
    let courseThumbnail: String?
    let courseTitle: String?
    let courseLocation: String?
    let courseExpense: String?
    let courseTime: String?
    
    init(courseID:
         Int?, courseLike: Int?, courseThumbnail: String?, courseTitle: String?, courseLocation: String?, courseExpense: String?, courseTime: String?) {
        self.courseID = courseID
        self.courseLike = courseLike
        self.courseThumbnail = courseThumbnail
        self.courseTitle = courseTitle
        self.courseLocation = courseLocation
        self.courseExpense = courseExpense
        self.courseTime = courseTime
    }
}
