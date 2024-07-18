//
//  UserTargetType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

import Moya

enum UserTargetType {
    case getUserProfile
}

extension UserTargetType: BaseTargetType {

    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUserProfile:
            return utilPath + "users"
        }
    }

    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let headers = ["Content-Type" : "application/json", "Authorization" : "Bearer " + token]
        return headers
    }
}
