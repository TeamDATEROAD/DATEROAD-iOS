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
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let headers = ["accept": "application/json",
                       "Content-Type" : "application/json", "Authorization" : "Bearer " + token]
        return headers
    }
}
