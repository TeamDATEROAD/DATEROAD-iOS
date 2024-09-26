//
//  GetCourseFilterResponse.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/16/24.
//

import Foundation

struct GetCourseResponse: Codable {
    let courses: [CorseFilterList]
}


struct CorseFilterList: Codable {
    let courseID: Int
    let thumbnail, city, title: String
    let duration: Float
    let like, cost: Int

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case thumbnail, city, title, like, cost, duration
    }
}

extension CorseFilterList {
    func toCourseModel() -> CourseListModel {
        return CourseListModel(courseId: self.courseID, thumbnail: self.thumbnail, location: self.city, title: self.title, cost: self.cost, time: self.duration, like: self.like
        )
    }
}
