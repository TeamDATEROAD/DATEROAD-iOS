//
//  LikeCourseService.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/19/24.
//

import Foundation

import Moya

protocol LikeCourseServiceProtocol {
    func likeCourse(courseId: Int, completion: @escaping (Bool) -> Void)
    func deleteLikeCourse(courseId: Int, completion: @escaping (Bool) -> Void)
}

final class LikeCourseService: BaseService, LikeCourseServiceProtocol {
   
    
    
    let provider = MoyaProvider<LikeCourseTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func likeCourse(courseId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.postLikeCourse(courseId: courseId)) { result in
            switch result {
            case .success(let response):
//                let networkResult: NetworkResult<EmptyResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
//                completion(networkResult)
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
    
    func deleteLikeCourse(courseId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.deleteLikeCourse(courseId: courseId)) { result in
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
    
 
}
