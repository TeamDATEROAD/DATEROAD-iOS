//
//  MyCourseListModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import Foundation

struct MyCourseListModel: Equatable  {
    
    let courses: [MyCourseModel]
    
    init(courses: [MyCourseModel]) {
        self.courses = courses
    }
    
}

struct MyCourseModel: Equatable  {
    
    let courseId: Int
    
    let thumbnail: String
    
    let title: String
    
    let city: String
    
    let cost: String
    
    let duration: String
    
    let like: Int
    
    init(courseId: Int, thumbnail: String, title: String, city: String, cost: String, duration: String, like: Int) {
        self.courseId = courseId
        self.thumbnail = thumbnail
        self.title = title
        self.city = city
        self.cost = cost
        self.duration = duration
        self.like = like
    }
    
}

// ViewedCoursesModel 싱글톤
class ViewedCoursesManager {
    static let shared = ViewedCoursesManager()
    var viewedCoursesModel: [MyCourseModel] = []
    
    private init() {}
}

// BroughtViewedCoursesModel 싱글톤
class BroughtViewedCoursesManager {
    static let shared = BroughtViewedCoursesManager()
    var broughtViewedCoursesModel: [MyCourseModel] = []
    
    private init() {}
}

// MyRegisterCoursesManager 싱글톤
class MyRegisterCoursesManager {
    static let shared = MyRegisterCoursesManager()
    var myRegisterCoursesModel: [MyCourseModel] = []
    
    private init() {}
}
