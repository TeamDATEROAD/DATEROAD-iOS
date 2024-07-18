//
//  GetUpcomingDateResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

// MARK: - Welcome
struct GetUpcomingDateResponse: Codable {
    let dateID, dDay: Int
    let dateName: String
    let month, day: Int
    let startAt: String

    enum CodingKeys: String, CodingKey {
        case dateID = "dateId"
        case dDay, dateName, month, day, startAt
    }
}
