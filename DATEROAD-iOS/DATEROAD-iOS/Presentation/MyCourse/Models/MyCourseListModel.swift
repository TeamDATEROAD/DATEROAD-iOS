//
//  MyCourseListModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import Foundation

struct MyCourseListModel {
    let courses: [MyCourseModel]
    
    init(courses: [MyCourseModel]) {
        self.courses = courses
    }
}

struct MyCourseModel {
    let courseId: Int
    let thumbnail: String
    let title: String
    let city: String
    let cost: Int
    let duration: Float
    let like: Int
    
    init(courseId: Int, thumbnail: String, title: String, city: String, cost: Int, duration: Float, like: Int) {
        self.courseId = courseId
        self.thumbnail = thumbnail
        self.title = title
        self.city = city
        self.cost = cost
        self.duration = duration
        self.like = like
    }
}
