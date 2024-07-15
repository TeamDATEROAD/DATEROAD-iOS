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

    private var myCourseProvider = MoyaProvider<MyCourseAPI>(plugins: [MoyaLoggingPlugin()])

}

extension MyCourseService {
    func getViewedCourse(completion: (@escaping (NetworkResult<MyCourseListDTO>) -> Void)) {
        myCourseProvider.request(.viewedCourse) {
            result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<MyCourseListDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
            case .failure(_):
                completion(NetworkResult.networkFail)
            }
        }
    }
    
    func getMyRegisterCourse(completion: (@escaping (NetworkResult<MyCourseListDTO>) -> Void)) {
        myCourseProvider.request(.myRegisterCourse) {
            result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<MyCourseListDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
            case .failure(_):
                completion(NetworkResult.networkFail)
            }
        }
    }
    
}
