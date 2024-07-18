//
//  AddScheduleTargetType.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import Foundation

import Moya

enum AddScheduleTargetType {
    case postAddSchedule(course: PostAddScheduleRequest)
}

extension AddScheduleTargetType: BaseTargetType {
   var utilPath: String {
       return "api/v1/"
   }
   
   var method: Moya.Method {
       switch self {
       case .postAddSchedule:
           return .post
       }
   }
    
    var path: String {
        switch self {
        case .postAddSchedule:
           return utilPath + "dates"
        }
    }
    
    var task: Task {
        switch self {
        case .postAddSchedule(let course):
            return .requestJSONEncodable(course)
        }
    }
    
    var headers: [String: String]? {
        return [
         "Authorization": Config.accessToken,
            "Content-Type": "application/json"
        ]
    }
}
