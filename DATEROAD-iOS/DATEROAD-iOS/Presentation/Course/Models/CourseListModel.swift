//
//  CourseModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

struct CourseListModel {
    
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
    
}

extension CourseListModel {
    
    static let courseContents: [CourseListModel] = []
    
}
