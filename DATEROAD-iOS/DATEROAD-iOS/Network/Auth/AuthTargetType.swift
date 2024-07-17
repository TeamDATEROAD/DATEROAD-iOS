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
    case getDoubleCheck(name: String)
}

extension AuthTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/users"
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp:
            return .post
        case .getDoubleCheck(let name):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return utilPath + "/signup"
        case .getDoubleCheck(let name):
            return utilPath + "/check"
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
//            for tag in requestBody.tag {
//                if let tagData = tag.data(using: .utf8) {
//                    let tagPart = MultipartFormData(provider: .data(tagData), name: "tag")
//                    multipartData.append(tagPart)
//                }
//            }
            
            if let tagData = try? JSONSerialization.data(withJSONObject: requestBody.tag, options: []) {
                multipartData.append(MultipartFormData(provider: .data(tagData), name: "tag"))
            }
            
            return .uploadMultipart(multipartData)
            
        case .getDoubleCheck(let name):
            if let parameter = parameter {
                return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .getDoubleCheck(let name):
            return ["name" : name]
        default:
            return .none
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postSignUp(_):
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
            let headers = ["Accept": "application/json",
                           "Content-Type" : "multipart/form-data",
                           "Authorization" : token]
            return headers
        default:
            let headers = ["Content-Type" : "application/json"]
            return headers
        }
    }
    
}
