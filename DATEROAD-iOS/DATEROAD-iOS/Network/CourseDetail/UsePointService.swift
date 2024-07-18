//
//  UsePointService.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/18/24.
//

//  UsePointService.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/18/24.
//

import Foundation

import Moya

protocol UsePointServiceProtocol {
    func postUsePoint(courseId: Int, request: PostUsePointRequest, completion: @escaping (NetworkResult<PostUsePointResponse>) -> Void)
}

final class UsePointService: BaseService, UsePointServiceProtocol {
    
    let provider = MoyaProvider<UsePointTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func postUsePoint(courseId: Int, request: PostUsePointRequest, completion: @escaping (NetworkResult<PostUsePointResponse>) -> Void) {
        provider.request(.postUsePoint(courseId: courseId, request: request)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PostUsePointResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
}
