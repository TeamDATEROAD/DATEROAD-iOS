//
//  CourseDetailTargetType.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation

import Moya

enum CourseDetailTargetType {
    case getCourseDetailInfo(courseId: Int)
    case deleteCourse(courseId: Int)
}

extension CourseDetailTargetType: BaseTargetType {
    
    var utilPath: String {
        return "/api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseDetailInfo:
            return .get
        case .deleteCourse:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getCourseDetailInfo(let courseId):
            return "api/v1/courses/\(courseId)"
        case .deleteCourse(let courseId):
            return "api/v1/courses/\(courseId)"
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        default:
                .none
        }
    }
    
    var task: Task {
        if let parameter = parameter {
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let headers = ["Content-Type" : "application/json",
                       "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0IiwiaWF0IjoxNzIxMDY2MDA2LCJleHAiOjE3MjM0ODUxMDZ9.-3xRrDlDixBsHKH7sUMjcYkHT8ry5f3STuwmL27abF8"]
        return headers
    }
    
}
