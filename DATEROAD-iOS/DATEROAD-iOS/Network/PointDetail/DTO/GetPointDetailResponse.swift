//
//  GetPointDetailResponse.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

// MARK: - GetPointDetailResponse
struct GetPointDetailResponse: Codable {
    let gained, used: Points
}

// MARK: - Points
struct Points: Codable {
    let points: [Point]
}

// MARK: - Point
struct Point: Codable {
    let point: Int
    let description, createdAt: String
}
