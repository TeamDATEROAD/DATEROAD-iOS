//
//  MainTargetType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

import Moya

enum MainTargetType {
    case getUserProfile
    case getFilteredDateCourse(sortBy: String)
    case getBanner
    case getUpcomingDate
}

extension MainTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile, .getFilteredDateCourse, .getBanner, .getUpcomingDate:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUserProfile:
            return utilPath + "users/main"
        case .getFilteredDateCourse:
            return utilPath + "courses/sort"
        case .getBanner:
            return utilPath + "advertisements"
        case .getUpcomingDate:
            return utilPath + "dates/nearest"
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .getFilteredDateCourse(let sortBy):
            return ["sortBy" : sortBy]
        default:
            return .none
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