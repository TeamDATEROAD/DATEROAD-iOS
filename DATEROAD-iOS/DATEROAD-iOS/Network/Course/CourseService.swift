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
       // 도메인에 맞게 작성한 요청서 즉, TransferTargetType 정보에 기반하여 요청을 보냅니다
       // 그리고 그 결과를 NetworkResult 타입으로 반환해줍니다
        provider.request(.getCourseInfo(city: city, cost: cost)) { result in
           // 이 단계에서는 서버 통신 자체가 올바르게 되었는지 확인합니다
           // success 라면 통신이 잘 된 것이고, failure이라면 네트워크에 문제가 있는 거겠죠!
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
