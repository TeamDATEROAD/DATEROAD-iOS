//
//  AuthService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/17/24.
//

import Foundation

import Moya

protocol AuthServiceProtocol {
    func postSignUp(requestBody: PostSignUpRequest, completion: @escaping (NetworkResult<PostSignUpResponse>) -> ())
    func getDoubleCheck(name: String, completion: @escaping (NetworkResult<EmptyResponse>) -> ())
}

final class AuthService: BaseService, AuthServiceProtocol {
    
    let provider = MoyaProvider<AuthTargetType>(plugins: [MoyaLoggingPlugin()])

    func postSignUp(requestBody : PostSignUpRequest, completion: @escaping (NetworkResult<PostSignUpResponse>) -> ()) {
        provider.request(.postSignUp(requestBody: requestBody)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PostSignUpResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getDoubleCheck(name: String, completion: @escaping (NetworkResult<EmptyResponse>) -> ()) {
        provider.request(.getDoubleCheck(name: name)) { result in
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
