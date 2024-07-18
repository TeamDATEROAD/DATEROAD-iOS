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
}

final class PointDetailService: BaseService, PointDetailServiceProtocol {
    
    let pointDetailProvider = MoyaProvider<PointDetailTargetType>(plugins: [MoyaLoggingPlugin()])
        
    func getPointDetail(completion: @escaping (NetworkResult<GetPointDetailResponse>) -> Void) {
        pointDetailProvider.request(.getPointDetail) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<GetPointDetailResponse> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
