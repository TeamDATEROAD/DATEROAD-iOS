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


// MARK: - PostAddCoursTag

struct PostAddCourseTag {
    var tags: [[String: Any]] = []
    
    struct Tag {
        let tag: String
        
        func toDictionary() -> [String: Any] {
            return ["tag": tag]
        }
    }
    
    mutating func addTags(from selectedTagData: [String]) {
        self.tags = selectedTagData.map { Tag(tag: $0).toDictionary() }
    }
}

//struct PostAddCourseTag: Codable {
//    var tags: [Tag] = []
//    
//    struct Tag: Codable {
//        let tag: String
//        
//        func toDictionary() -> [String: Any] {
//            return ["tag": tag]
//        }
//        
//        init(tag: String) {
//            self.tag = tag
//        }
//        
//        init(from dictionary: [String: Any]) throws {
//            guard let tag = dictionary["tag"] as? String else {
//                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing tag"])
//            }
//            self.tag = tag
//        }
//    }
//    
//    mutating func addTags(from selectedTagData: [String]) {
//        self.tags = selectedTagData.map { Tag(tag: $0) }
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case tags
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.tags = try container.decode([Tag].self, forKey: .tags)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(tags, forKey: .tags)
//    }
//}


//struct PostAddCoursePlaceRequest: Codable {
//   let places: [PostAddCoursePlace]
//}

//struct PostAddCoursePlace: Codable {
//   let title: String
//   let duration: Float
//   let sequence: Int
//}

struct PostAddCoursePlace {
    let title: String
    let duration: Float
    let sequence: Int
    
    func toDictionary() -> [String: Any] {
        return ["title": title, "duration": duration, "sequence": sequence]
    }
}

