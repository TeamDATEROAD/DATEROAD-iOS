//
//  PostAddScheduleRequest.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import Foundation

struct PostAddScheduleRequest2: Codable {
    
    var dateName: String = ""
    var date: String = ""
    var startAt: String = ""
    
    var tags: [PostAddScheduleTag] = []
    
    var country: String = ""
    var city: String = ""
    
    var places: [PostAddSchedulePlace] = []
    
}

// MARK: - PostAddScheduleRequest

struct PostAddScheduleRequest: Codable {
    
    let title, date, startAt: String
    
    let tags: [PostAddScheduleTag]
    
    let country, city: String
    
    let places: [PostAddSchedulePlace]
    
}


// MARK: - PostAddScheduleTag

struct PostAddScheduleTag: Codable {
    
    let tag: String
    
}


// MARK: - PostAddSchedulePlace

struct PostAddSchedulePlace: Codable {
    
    let title: String
    
    let duration: Float
    
    let sequence: Int
    
}
