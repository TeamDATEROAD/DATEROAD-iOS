//
//  CourseService.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/16/24.
//

import Foundation

import Moya

protocol CourseServiceProtocol {
    func getCourseInfo(city: String, cost: Int?, completion: @escaping (NetworkResult<GetCourseResponse>) -> ())

}


final class CourseService: BaseService, CourseServiceProtocol {
    
    let provider = MoyaProvider<CourseTargetType>(plugins: [MoyaLoggingPlugin()])

    func getCourseInfo(city: String, cost: Int?, completion: @escaping (NetworkResult<GetCourseResponse>) -> ()) {
        provider.request(.getCourseInfo(city: city, cost: cost)) { result in
      
            switch result {
            // 성공했다면 반환된 결과의 statusCode와 data를 가지고 유효한 데이터인지 검사해줍니다
            case .success(let response):
               // 유효한 데이터라면 디코딩까지 마친 그 데이터를 반환해줍니다
                let networkResult: NetworkResult<GetCourseResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
