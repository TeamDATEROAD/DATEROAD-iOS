//
//  GetFilteredDateCourseResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

struct GetFilteredDateCourseResponse: Codable {
    let courses: [Course]
}

struct Course: Codable {
    let courseID: Int
    let thumbnail, title, city: String
    let like, cost, duration: Int

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case thumbnail, title, city, like, cost, duration
    }
}
