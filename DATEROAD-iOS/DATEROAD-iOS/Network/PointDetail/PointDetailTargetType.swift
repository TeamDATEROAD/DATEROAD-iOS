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
    
    case postPoint
    
}

extension PointDetailTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getPointDetail:
            return .get
            
        case .postPoint:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getPointDetail, .postPoint:
            return utilPath + "points"
        }
    }
    
    var task: Task {
        switch self {
        case .getPointDetail, .postPoint:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaultsManager.shared.accessToken
        let headers = HeaderType.headerWithToken(token: "Bearer " + token)
        return headers
    }
    
}
