//
//  UserService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

import Moya

protocol UserServiceProtocol {
    func getUserProfile(completion: @escaping (NetworkResult<GetUserProfileResponse>) -> ())
}

final class UserService: BaseService, UserServiceProtocol {
    
    let provider = MoyaProvider<UserTargetType>(plugins: [MoyaLoggingPlugin()])
    
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
}
