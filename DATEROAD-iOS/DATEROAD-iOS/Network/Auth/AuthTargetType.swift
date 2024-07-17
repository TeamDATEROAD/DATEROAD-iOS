//
//  AuthTargetType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/17/24.
//

import Foundation

import Moya

enum AuthTargetType {
    case postSignUp(requestBody: PostSignUpRequest)
}

extension AuthTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/users"
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return utilPath + "/signup"
        }
    }

    var task: Task {
        switch self {
        case .postSignUp(let requestBody):
            var multipartData = [MultipartFormData]()
            
            // Add userSignUpReq as JSON data
            if let jsonData = try? JSONEncoder().encode(requestBody.userSignUpReq) {
                let jsonPart = MultipartFormData(provider: .data(jsonData), name: "userSignUpReq", mimeType: "application/json")
                multipartData.append(jsonPart)
            }
            
            // Add image if it exists
            if let image = requestBody.image, let imageData = image.jpegData(compressionQuality: 1.0) {
                let imagePart = MultipartFormData(provider: .data(imageData), name: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(imagePart)
            }
            
            // Add tags as separate parts
            for tag in requestBody.tag {
                if let tagData = tag.data(using: .utf8) {
                    let tagPart = MultipartFormData(provider: .data(tagData), name: "tag")
                    multipartData.append(tagPart)
                }
            }
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postSignUp(_):
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
            let headers = ["accept": "application/json",
                           "Content-Type" : "multipart/form-data",
                           "Authorization" : token]
            return headers
        }
    }
    
}
