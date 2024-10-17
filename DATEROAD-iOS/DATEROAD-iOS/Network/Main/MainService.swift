//
//  MainService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/16/24.
//

import Foundation

import Moya

protocol MainServiceProtocol {
    
    func getMainUserProfile(
        completion: @escaping (NetworkResult<GetMainUserProfileResponse>) -> ())
    
    func getFilteredDateCourse(sortBy: String,
                               completion: @escaping (NetworkResult<GetFilteredDateCourseResponse>) -> ())
    
    func getBanner(
        completion: @escaping (NetworkResult<GetBannerResponse>) -> ())
    
    func getUpcomingDate(completion: @escaping (NetworkResult<GetUpcomingDateResponse>) -> ())
    
}

final class MainService: BaseService, MainServiceProtocol {
    
    let provider = MoyaProvider<MainTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func getMainUserProfile(completion: @escaping (NetworkResult<GetMainUserProfileResponse>) -> ()) {
        provider.request(.getMainUserProfile) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetMainUserProfileResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getFilteredDateCourse(sortBy: String, completion: @escaping (NetworkResult<GetFilteredDateCourseResponse>) -> ()) {
        provider.request(.getFilteredDateCourse(sortBy: sortBy)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetFilteredDateCourseResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
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
