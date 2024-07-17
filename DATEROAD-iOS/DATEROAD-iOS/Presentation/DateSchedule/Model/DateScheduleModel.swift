//
//  DateScheduleModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

struct DateCardModel {
    let dateID: Int
    let title: String
    let date: String
    let city: String
    let tags: [TagsModel]
    let dDay: Int
    
    init(dateID: Int, title: String, date: String, city: String, tags: [TagsModel], dDay: Int) {
        self.dateID = dateID
        self.title = title
        self.date = date
        self.city = city
        self.tags = tags
        self.dDay = dDay
    }
}

struct TagsModel {
    let tag: String
    
    init(tag: String) {
        self.tag = tag
    }
}

struct DateScheduleModel {
    let dateCards: [DateCardModel]
    
    init(dateCards: [DateCardModel]) {
        self.dateCards = dateCards
    }
}

struct DateDetailModel {
    let dateID: Int
    let title: String
    let startAt: String
    let city: String
    let tags: [String]
    let date: String
    let places: [DatePlaceModel]
    
    init(dateID: Int, title: String, startAt: String, city: String, tags: [String], date: String, places: [DatePlaceModel]) {
        self.dateID = dateID
        self.title = title
        self.startAt = startAt
        self.city = city
        self.tags = tags
        self.date = date
        self.places = places
    }
}

struct DatePlaceModel {
    let name: String
    let duration: Float
    let sequence: Int
    
    init(name: String, duration: Float, sequence: Int) {
        self.name = name
        self.duration = duration
        self.sequence = sequence
    }
}


struct KakaoPlaceModel {
    let name: String?
    let duration: Float?
    
    init(name: String?, duration: Float?) {
        self.name = name
        self.duration = duration
    }
}

