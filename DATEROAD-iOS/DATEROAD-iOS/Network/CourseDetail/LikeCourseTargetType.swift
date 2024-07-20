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
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let headers = ["accept": "application/json",
                       "Content-Type" : "application/json", "Authorization" : "Bearer " + token]
        return headers
    }
}
