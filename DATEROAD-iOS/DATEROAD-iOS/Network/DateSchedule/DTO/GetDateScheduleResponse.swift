//
//  GetDateScheduleResponse.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

// MARK: - Welcome

struct GetDateScheduleResponse: Codable {
    
    let dates: [DateCard]
    
}


// MARK: - DateElement

struct DateCard: Codable {
    
    let dateID: Int
    
    let title, date, city: String
    
    let tags: [TagCard]
    
    let dDay: Int
    
    enum CodingKeys: String, CodingKey {
        
        case dateID = "dateId"
        
        case title, date, city, tags, dDay
        
    }
    
}


// MARK: - Tag

struct TagCard: Codable {
    
    let tag: String
    
}
