//
//  DateScheduleModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import Foundation

struct DateCardModel: Equatable {
    
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
    
    static var emptyModel: DateCardModel {
        return DateCardModel(dateID: 0, title: "", date: "", city: "", tags: [], dDay: 0)
    }
    
}

struct TagsModel: Equatable {
    
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

struct DateDetailModel: Equatable {
    
    let dateID: Int
    
    let title: String
    
    let startAt: String
    
    let city: String
    
    let tags: [TagsModel]
    
    let date: String
    
    let places: [DatePlaceModel]
    
    let dDay: Int
    
    init(dateID: Int, title: String, startAt: String, city: String, tags: [TagsModel], date: String, places: [DatePlaceModel], dDay: Int) {
        self.dateID = dateID
        self.title = title
        self.startAt = startAt
        self.city = city
        self.tags = tags
        self.date = date
        self.places = places
        self.dDay = dDay
    }
    
}

struct DatePlaceModel: Equatable {
    
    let name: String
    
    let duration: String
    
    let sequence: Int
    
    init(name: String, duration: String, sequence: Int) {
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
