//
//  UsePointTargetType.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/18/24.
//

import Foundation

import Moya

enum UsePointTargetType {
    case postUsePoint(courseId: Int, request: PostUsePointRequest)
}


extension UsePointTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/courses"
    }
    
    var path: String {
        switch self {
        case .postUsePoint(let courseId, _):
            return utilPath+"/\(courseId)/date-access"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postUsePoint:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postUsePoint(_, let request):
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
