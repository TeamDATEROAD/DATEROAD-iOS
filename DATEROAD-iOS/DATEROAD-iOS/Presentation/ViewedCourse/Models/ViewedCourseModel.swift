//
//  ViewedCourseModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

struct ViewedCourseModel {
    let courseThumbnail: String?
    let courseTitle: String?
    let courseLocation: String?
    let courseExpense: String?
    let courseTime: String?
    
    init(courseThumbnail: String?, courseTitle: String?, courseLocation: String?, courseExpense: String?, courseTime: String?) {
        self.courseThumbnail = courseThumbnail
        self.courseTitle = courseTitle
        self.courseLocation = courseLocation
        self.courseExpense = courseExpense
        self.courseTime = courseTime
    }
}
