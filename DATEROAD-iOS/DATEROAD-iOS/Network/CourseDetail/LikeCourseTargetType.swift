//
//  LikeCourseTargetType.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/19/24.
//

import Foundation

import Moya

enum LikeCourseTargetType {
    case postLikeCourse(courseId: Int)
    case deleteLikeCourse(courseId: Int)
}


extension LikeCourseTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/courses"
    }
    
    var path: String {
        switch self {
        case .postLikeCourse(let courseId):
            return utilPath+"/\(courseId)/likes"
        case .deleteLikeCourse(let courseId):
            return utilPath+"/\(courseId)/likes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLikeCourse:
            return .post
        case .deleteLikeCourse:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .postLikeCourse(let request):
            return .requestJSONEncodable(request)
        case .deleteLikeCourse(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0IiwiaWF0IjoxNzIxMDY2MDA2LCJleHAiOjE3MjM0ODUxMDZ9.-3xRrDlDixBsHKH7sUMjcYkHT8ry5f3STuwmL27abF8"
        ]
    }
}
