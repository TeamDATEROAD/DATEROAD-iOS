//
//  DateScheduleService.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

import Moya

protocol DateScheduleServiceProtocol {
    func getDateSchdeule(time: String, completion: @escaping (NetworkResult<GetDateScheduleResponse>) -> Void)
    func getDateDetail(dateID: Int, completion: @escaping (NetworkResult<GetDateDetailResponse>) -> Void)
    func deleteDateSchedule(dateID: Int, completion: @escaping (NetworkResult<DeleteDateScheduleResponse>) -> Void)
}

final class DateScheduleService: BaseService, DateScheduleServiceProtocol {
    let dateScheduleProvider = MoyaProvider<DateScheduleTargetType>(plugins: [MoyaLoggingPlugin()])

    func getDateSchdeule(time: String, completion: @escaping (NetworkResult<GetDateScheduleResponse>) -> Void) {
        dateScheduleProvider.request(.getDateSchedule(time: time)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetDateScheduleResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getDateDetail(dateID: Int, completion: @escaping (NetworkResult<GetDateDetailResponse>) -> Void) {
        dateScheduleProvider.request(.getDateDetail(dateID: dateID)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetDateDetailResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deleteDateSchedule(dateID: Int, completion: @escaping (NetworkResult<DeleteDateScheduleResponse>) -> Void) {
        dateScheduleProvider.request(.deleteDateSchedule(dateID: dateID)) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
