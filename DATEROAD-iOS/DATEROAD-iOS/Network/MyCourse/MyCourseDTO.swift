//
//  MyCourseDTO.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/16/24.
//

import Foundation

// MARK: - Welcome
struct MyCourseListDTO: Codable {
    let courses: [MyCourseDTO]
}

// MARK: - Course
struct MyCourseDTO: Codable {
    let courseID: Int
    let thumbnail: String
    let city, title: String
    let like, cost: Int
    let duration: Float

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case thumbnail, city, title, like, cost, duration
    }
}
