//
//  ViewedCourseService.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/16/24.
//

import Foundation

import Moya

class MyCourseService: BaseService {
    static let shared = MyCourseService()

    private var movieProvider = MoyaProvider<MyCourseAPI>(plugins: [MoyaLoggingPlugin()])

}

extension MyCourseService {
    
}
