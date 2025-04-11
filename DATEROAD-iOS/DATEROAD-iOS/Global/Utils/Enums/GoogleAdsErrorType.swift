//
//  GoogleAdsErrorType.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/8/25.
//

import UIKit

enum GoogleAdsErrorType: Int, Error {
    
    case noFill = 1 /// 5개 제한
    
    case networkErr = 2 /// 네트워크 에러

    case alreadyUsed = 18 /// 다음 광고를 너무 빨리 요청했을 때
    
    case defaultErr = -1 /// 나머지 에러
    
    init(from error: NSError) {
        if error.domain == NSURLErrorDomain && error.code == -1009 {
            self = .networkErr
        } else {
            self = GoogleAdsErrorType(rawValue: error.code) ?? .defaultErr
        }
    }
    
    var alertTitle: String {
        switch self {
        case .noFill, .networkErr, .alreadyUsed, .defaultErr:
            return StringLiterals.Alert.adFailTitle
        }
    }
    
    var alertMessage: String? {
        switch self {
        case .noFill:
            return StringLiterals.Alert.adLimitMessage
        case .networkErr:
            return StringLiterals.Alert.adFailNetworkMessage
        case .alreadyUsed:
            return StringLiterals.Alert.adFailWaitMessage
        case .defaultErr:
            return nil
        }
    }
    
}
