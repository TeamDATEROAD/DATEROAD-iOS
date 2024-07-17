//
//  DateScheduleTargetType.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

import Moya

enum DateScheduleTargetType {
    case getDateSchedule(time: String)
    case getDateDetail(dateID: Int)
    case deleteDate(dateID: Int)
}

extension DateScheduleTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getDateSchedule, .getDateDetail:
            return .get
        case .deleteDate:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getDateSchedule:
            return utilPath + "dates"
        case .getDateDetail(let dateID):
            return utilPath + "dates/\(dateID)"
        case .deleteDate(let dateID):
            return utilPath + "dates/\(dateID)"
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .getDateSchedule(let time):
            return ["time" : time]
        case .getDateDetail(let dateID):
            return ["dateId" : dateID]
        case .deleteDate(let dateID):
            return ["dateId" : dateID]
        }
    }

    var task: Task {
        if let parameter = parameter {
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
}
