//
//  CourseDetailService.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation

import Moya

protocol CourseDetailServiceProtocol {
    
    func getCourseDetailInfo(courseId: Int, completion: @escaping (NetworkResult<GetCourseDetailResponse>) -> ())
    
    func deleteCourse(courseId: Int, completion: @escaping (Bool) -> Void)
    
    func getBannerDetailInfo(advertismentId: Int, completion: @escaping (NetworkResult<GetBannerDetailResponse>) -> ())
    
}

final class CourseDetailService: BaseService, CourseDetailServiceProtocol {
    
    let provider = MoyaProvider<CourseDetailTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func getCourseDetailInfo(courseId: Int, completion: @escaping (NetworkResult<GetCourseDetailResponse>) -> ()) {
        provider.request(.getCourseDetailInfo(courseId: courseId)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetCourseDetailResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deleteCourse(courseId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.deleteCourse(courseId: courseId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let err):
                print("Error deleting course: \(err.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getBannerDetailInfo(advertismentId: Int, completion: @escaping (NetworkResult<GetBannerDetailResponse>) -> ()) {
        provider.request(.getBannerDetail(advertismentId: advertismentId)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<GetBannerDetailResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
