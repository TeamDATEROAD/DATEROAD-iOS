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
    let tags: [Tag]
    let country, city: String
    let places: [Place]
}

// MARK: - Place
struct Place: Codable {
    let title: String
    let duration: Float
    let sequence: Int
}

// MARK: - Tag
struct Tag: Codable {
    let tag: String
}

