//
//  PointDetailService.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/17/24.
//

import Foundation

import Moya

protocol PointDetailServiceProtocol {
    
    func getPointDetail(completion: @escaping (NetworkResult<GetPointDetailResponse>) -> Void)
    
    func postPoint(completion: @escaping (NetworkResult<EmptyResponse>) -> ())
    
}

final class PointDetailService: BaseService, PointDetailServiceProtocol {
    
    let pointDetailProvider = MoyaProvider<PointDetailTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func getPointDetail(completion: @escaping (NetworkResult<GetPointDetailResponse>) -> Void) {
        pointDetailProvider.request(.getPointDetail) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetPointDetailResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postPoint(completion: @escaping (NetworkResult<EmptyResponse>) -> Void) {
        pointDetailProvider.request(.postPoint) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<EmptyResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
