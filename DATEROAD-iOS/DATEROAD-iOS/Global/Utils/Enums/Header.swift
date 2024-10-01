//
//  Header.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 9/20/24.
//

import Foundation

enum HeaderType {
    
    static let basic = ["Content-Type" : "application/json"]
    
    static func headerWithToken(token: String) -> [String: String] {
        return ["Content-Type" : "application/json", "Authorization" : token]
    }
    
    static func headerWithAcceptToken(token: String) -> [String: String] {
        return ["accept": "application/json",
                "Content-Type" : "application/json",
                "Authorization" : "Bearer " + token]
    }
    
    static func headerWithMultiPart(token: String) -> [String: String] {
        return ["Accept": "application/json",
                "Content-Type" : "multipart/form-data",
                "Authorization" : token]
    }
    
}
