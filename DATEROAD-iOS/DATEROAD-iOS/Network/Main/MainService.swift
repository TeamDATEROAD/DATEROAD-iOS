//
//  MainService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

import Moya

protocol MainServiceProtocol {
    func getUserProfile(
                        completion: @escaping (NetworkResult<GetUserProfileResponse>) -> ())
    func getBanner(
                   completion: @escaping (NetworkResult<GetBannerResponse>) -> ())
    func getUpcomingDate(completion: @escaping (NetworkResult<GetUpcomingDateResponse>) -> ())
}

final class MainService: BaseService, MainServiceProtocol {
    
    let provider = MoyaProvider<MainTargetType>(plugins: [MoyaLoggingPlugin()])

    func getUserProfile(completion: @escaping (NetworkResult<GetUserProfileResponse>) -> ()) {
        provider.request(.getUserProfile) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetUserProfileResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data) 
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func getBanner(completion: @escaping (NetworkResult<GetBannerResponse>) -> ()) {
        provider.request(.getBanner) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetBannerResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getUpcomingDate(completion: @escaping (NetworkResult<GetUpcomingDateResponse>) -> ()) {
        provider.request(.getUpcomingDate) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetUpcomingDateResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
