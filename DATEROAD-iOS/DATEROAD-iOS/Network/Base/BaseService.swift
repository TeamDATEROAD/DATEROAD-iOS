//
//  BaseService.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/15/24.
//

import Foundation

class BaseService {
    
    func judgeStatus<T: Codable>(statusCode: Int, data: Data) -> NetworkResult<T> {
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, responseType: T.self, statusCode: statusCode)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
   func isValidData<T: Codable>(data: Data, responseType: T.Type, statusCode: Int) -> NetworkResult<T> {
      let decoder = JSONDecoder()
      if data.isEmpty {
         if T.self == EmptyResponse.self {
            return .success(EmptyResponse() as! T)
         } else {
            print("⛔️ Expected \(T.self) but received empty response ⛔️")
            return .decodedErr
         }
      }
      
      guard let decodedData = try? decoder.decode(T.self, from: data) else {
         print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
         return .decodedErr
      }
      
      return .success(decodedData)
   }
}
