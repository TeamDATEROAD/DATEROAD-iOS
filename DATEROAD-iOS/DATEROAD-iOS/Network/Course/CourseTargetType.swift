//
//  CourseTargetType.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/16/24.
//

import Foundation

import Moya

enum CourseTargetType {
    case getCourseInfo(city: String, cost: Int?)
}

extension CourseTargetType: BaseTargetType {

    var utilPath: String {
        return "api/v1/"
    }

    var method: Moya.Method {
        switch self {
        case .getCourseInfo:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getCourseInfo:
            return utilPath + "courses"
        }
    }

    var parameter: [String : Any]? {
        switch self {
        case .getCourseInfo(let city, let cost):
            return ["city" : city , "cost" : cost ]
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
