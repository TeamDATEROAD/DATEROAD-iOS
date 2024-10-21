//
//  PostUsePointRequest.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/18/24.
//

import Foundation

struct PostUsePointRequest: Codable {
    
    var point: Int
    
    var type: String
    
    var description: String
    
}

struct PostUsePointResponse: Codable {}
