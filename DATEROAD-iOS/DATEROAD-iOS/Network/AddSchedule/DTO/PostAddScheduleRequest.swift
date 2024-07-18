//
//  PostAddScheduleRequest.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import Foundation

// MARK: - PostAddScheduleRequest
struct PostAddScheduleRequest: Codable {
    let title, date, startAt: String
    let tags: [PostAddScheduleTag]
    let country, city: String
    let places: [PostAddSchedulePlace]
}

// MARK: - Place
struct PostAddSchedulePlace: Codable {
    let title: String
    let duration: Float
    let sequence: Int
}

// MARK: - Tag
struct PostAddScheduleTag: Codable {
    let tag: String
}

