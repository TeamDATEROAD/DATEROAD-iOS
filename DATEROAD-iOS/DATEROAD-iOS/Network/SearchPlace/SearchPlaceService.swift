//
//  SearchPlaceService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/3/25.
//

import Foundation

import Moya

protocol SearchPlaceServiceProtocol {
    
    func getSearchPlace(_ request: GetSearchPlaceRequest, completion: @escaping (NetworkResult<GetSearchPlaceResponse>) -> ())
    
}

final class SearchPlaceService: BaseService, SearchPlaceServiceProtocol {
    
    let provider = MoyaProvider<SearchPlaceTargetType>(plugins: [MoyaLoggingPlugin()])

    func getSearchPlace(_ request: GetSearchPlaceRequest, completion: @escaping (NetworkResult<GetSearchPlaceResponse>) -> ()) {
        provider.request(.getSearchPlace(request)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetSearchPlaceResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
