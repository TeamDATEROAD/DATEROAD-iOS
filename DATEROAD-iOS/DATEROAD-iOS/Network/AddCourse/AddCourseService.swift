//
//  AddCourseService.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/17/24.
//

import UIKit

import Moya

protocol AddCourseServiceProtocol {
    func createCourse(course: [String: Any], tags: [[String: Any]], places: [[String: Any]], images: [UIImage], completion: @escaping (NetworkResult<PostAddCourseResponse>) -> Void)
}

final class AddCourseService: BaseService, AddCourseServiceProtocol {
    
    let provider = MoyaProvider<AddCourseTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func createCourse(course: [String: Any], tags: [[String: Any]], places: [[String: Any]], images: [UIImage], completion: @escaping (NetworkResult<PostAddCourseResponse>) -> Void) {
        provider.request(.createCourse(course: course, tags: tags, places: places, images: images)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<PostAddCourseResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
   
}
