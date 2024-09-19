//
//  AddCourseTargetType.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/17/24.
//

import UIKit

import Moya


// MARK: - API Service Definition
enum AddCourseTargetType {
    case postAddCourse(course: [String: Any], tags: [[String: Any]], places: [[String: Any]], images: [UIImage])
}

extension AddCourseTargetType: BaseTargetType {
   var utilPath: String {
       return "api/v1/"
   }
   
   var method: Moya.Method {
       switch self {
       case .postAddCourse:
           return .post
       }
   }
    
    var path: String {
        switch self {
        case .postAddCourse:
           return utilPath + "courses"
        }
    }
    
    var task: Task {
        switch self {
        case let .postAddCourse(course, tags, places, images):
            var formData: [MultipartFormData] = []
            
            // Add course data
            if let courseData = try? JSONSerialization.data(withJSONObject: course, options: []) {
                formData.append(MultipartFormData(provider: .data(courseData), name: "course"))
            }
            
            // Add tags data
            if let tagsData = try? JSONSerialization.data(withJSONObject: tags, options: []) {
                formData.append(MultipartFormData(provider: .data(tagsData), name: "tags"))
            }
            
            // Add places data
            if let placesData = try? JSONSerialization.data(withJSONObject: places, options: []) {
                formData.append(MultipartFormData(provider: .data(placesData), name: "places"))
            }
            
            // Add images
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(MultipartFormData(provider: .data(imageData), name: "images", fileName: "image\(index).jpg", mimeType: "image/jpeg"))
                }
            }
            
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String : String]? {
       let token = UserDefaults.standard.string(forKey: StringLiterals.Network.accessToken) ?? ""
        let headers = HeaderType.headerWithAcceptToken(token: token)
        return headers
    }
}

