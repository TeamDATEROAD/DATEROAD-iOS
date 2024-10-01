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
    
    case getBannerDetail(advertismentId: Int)
    
}

extension CourseDetailTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseDetailInfo, .getBannerDetail:
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
        case .getBannerDetail(let advertismentId):
            return utilPath + "advertisements/\(advertismentId)"
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
        let token = UserDefaults.standard.string(forKey: StringLiterals.Network.accessToken) ?? ""
        let headers = HeaderType.headerWithAcceptToken(token: token)
        return headers
    }
    
}
