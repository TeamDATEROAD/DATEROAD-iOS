//
//  GetDateDetailResponse.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

// MARK: - GetDateDetailResponse

struct GetDateDetailResponse: Codable {
    
    let dateID: Int
    
    let title, startAt, city: String
    
    let tags: [Tag]
    
    let date: String
    
    let places: [Place]
    
    let dDay: Int
    
    enum CodingKeys: String, CodingKey {
        
        case dateID = "dateId"
        
        case title, startAt, city, tags, date, places, dDay
        
    }
    
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
