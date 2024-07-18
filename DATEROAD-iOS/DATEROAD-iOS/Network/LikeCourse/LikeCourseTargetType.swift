//
//  LikeCourseTargetType.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/18/24.
//

import Foundation

import Moya

enum LikeCourseTargetType {
    case postLikeCourse(courseId: Int)
}

extension LikeCourseTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/courses/"
    }
    
    var method: Moya.Method {
        switch self {
        case .postLikeCourse:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .postLikeCourse(let courseId):
            return utilPath + "\(courseId)/bookmark/likes"
        }
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    
}
