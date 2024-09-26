//
//  PointDetailTargetType.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

import Moya

enum PointDetailTargetType {
    case getPointDetail
}

extension PointDetailTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getPointDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPointDetail:
            return utilPath + "points"
        }
    }
    
    var task: Task {
        switch self {
        case .getPointDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: StringLiterals.Network.accessToken) ?? ""
        let headers = HeaderType.headerWithToken(token: "Bearer " + token)
        return headers
    }
}
