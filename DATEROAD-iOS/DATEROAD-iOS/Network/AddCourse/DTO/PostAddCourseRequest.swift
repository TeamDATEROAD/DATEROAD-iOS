//
//  PostAddCourseRequest.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/17/24.
//

import Foundation

struct PostAddCourse: Codable {
   let title: String
   let date: String
   let startAt: String
   let country: String
   let city: String
   let description: String
   let cost: Int
   
   enum CodingKeys: String, CodingKey {
      case title
      case date
      case startAt = "startAt"
      case country
      case city
      case description
      case cost
   }
   
   func toDictionary() -> [String: Any] {
      return [
         "title": self.title,
         "date": self.date,
         "startAt": self.startAt,
         "country": self.country,
         "city": self.city,
         "description": self.description,
         "cost": self.cost
      ]
   }
}

struct PostAddCourseTag {
   var tags: [[String: Any]] = []
   
   struct Tag {
      let tag: String
      
      func toDictionary() -> [String: Any] {
         return ["tag": tag]
      }
   }
   
   mutating func addTag(_ tag: Tag) {
      tags.append(tag.toDictionary())
   }
}

struct PostAddCoursePlace: Codable {
   let title: String
   let duration: Float
   let sequence: Int
   
   func toDictionary() -> [String: Any] {
      return [
         "title": self.title,
         "duration": self.duration,
         "sequence": self.sequence
      ]
   }
}


