//
//  GetCourseDetailResponse.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation

struct GetCourseDetailResponse: Codable {
    let courseID: Int
    let images: [Image]
    let like: Int
    let totalTime: Double
    let date, city, title, description: String
    let startAt: String
    let places: [GetCourseDetailPlace]
    let totalCost: Int
    let tags: [GetCourseDetailTag]
    let isAccess: Bool
    let free, totalPoint: Int
    let isCourseMine, isUserLiked: Bool

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case images, like, totalTime, date, city, title, description, startAt, places, totalCost, tags, isAccess, free, totalPoint, isCourseMine, isUserLiked
    }
}

// MARK: - Image
struct Image: Codable {
    let imageURL: String
    let sequence: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case sequence
    }
}

// MARK: - Place
struct GetCourseDetailPlace: Codable {
    let sequence: Int
    let title: String
    let duration: Double
}

// MARK: - Tag
struct GetCourseDetailTag: Codable {
    let tag: String
}
