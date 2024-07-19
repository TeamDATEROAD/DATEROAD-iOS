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
        return "api/v1/"
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
            return utilPath+"courses/\(courseId)"
        case .deleteCourse(let courseId):
            return utilPath+"courses/\(courseId)"
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
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let headers = ["accept": "application/json",
                       "Content-Type" : "application/json", "Authorization" : "Bearer " + token]
        return headers
    }
    
}
