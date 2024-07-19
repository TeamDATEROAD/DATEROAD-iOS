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
            var params: [String: Any] = ["city": city]
            if let cost = cost {
                params["cost"] = cost
            }
            return params
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
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let headers = ["accept": "application/json",
                       "Content-Type" : "application/json", "Authorization" : "Bearer " + token]
        return headers
    }
    
}
