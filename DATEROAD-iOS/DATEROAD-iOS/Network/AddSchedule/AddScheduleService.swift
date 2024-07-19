//
//  AddScheduleService.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import Moya

protocol AddScheduleServiceProtocol {
   func postAddSchedule(course: PostAddScheduleRequest, completion: @escaping (NetworkResult<EmptyResponse>) -> Void)
}

final class AddScheduleService: BaseService, AddScheduleServiceProtocol {
   
   let provider = MoyaProvider<AddScheduleTargetType>(plugins: [MoyaLoggingPlugin()])
   
   func postAddSchedule(course: PostAddScheduleRequest, completion: @escaping (NetworkResult<EmptyResponse>) -> Void) {
      provider.request(.postAddSchedule(course: course)) { result in
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

