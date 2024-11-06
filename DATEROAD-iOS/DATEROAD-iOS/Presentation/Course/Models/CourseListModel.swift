//
//  CourseModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

struct CourseListModel: Equatable {
    
    let courseId: Int?
    
    let thumbnail: String?
    
    let location: String?
    
    let title: String?
    
    let cost: Int?
    
    let time: Float?
    
    let like: Int?
    
    init(courseId: Int?, thumbnail: String, location: String?, title: String?, cost: Int?, time: Float?, like: Int?) {
        self.courseId = courseId
        self.thumbnail = thumbnail
        self.location = location
        self.title = title
        self.cost = cost
        self.time = time
        self.like = like
    }
    
    static func == (lhs: CourseListModel, rhs: CourseListModel) -> Bool {
        return lhs.courseId == rhs.courseId &&
               lhs.thumbnail == rhs.thumbnail &&
               lhs.location == rhs.location &&
               lhs.title == rhs.title &&
               lhs.cost == rhs.cost &&
               lhs.time == rhs.time &&
               lhs.like == rhs.like
    }
    
}

extension CourseListModel {
    
    static let courseContents: [CourseListModel] = []
    
}
