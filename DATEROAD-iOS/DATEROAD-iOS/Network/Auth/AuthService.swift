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
    
    func deleteLogout(completion: @escaping (NetworkResult<EmptyResponse>) -> ())
    
    func postSignIn(requestBody: PostSignInRequest, completion: @escaping (NetworkResult<PostSignUpResponse>) -> ())
    
    func deleteWithdrawal(requestBody: DeleteWithdrawalRequest, completion: @escaping (NetworkResult<EmptyResponse>) -> ())
    
    func patchReissue(completion: @escaping (NetworkResult<PatchReissueResponse>) -> ())
    
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
    
    func deleteLogout(completion: @escaping (NetworkResult<EmptyResponse>) -> ()) {
        provider.request(.deleteLogout) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<EmptyResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postSignIn(requestBody : PostSignInRequest, completion: @escaping (NetworkResult<PostSignUpResponse>) -> ()) {
        provider.request(.postSignIn(requestBody: requestBody)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PostSignUpResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deleteWithdrawal(requestBody: DeleteWithdrawalRequest, completion: @escaping (NetworkResult<EmptyResponse>) -> ()) {
        provider.request(.deleteWithdrawal(requestBody: requestBody)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<EmptyResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchReissue(completion: @escaping (NetworkResult<PatchReissueResponse>) -> ()) {
        provider.request(.patchReissue) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PatchReissueResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
