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
    case postSignIn(requestBody: PostSignInRequest)
}

extension AuthTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/users"
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp, .postSignIn:
            return .post
        case .getDoubleCheck:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return utilPath + "/signup"
        case .getDoubleCheck:
            return utilPath + "/check"
        case .deleteLogout:
            return utilPath + "/logout"
        case .postSignIn:
            return utilPath + "/signin"
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
            
            if let tagData = try? JSONSerialization.data(withJSONObject: requestBody.tag, options: []) {
                multipartData.append(MultipartFormData(provider: .data(tagData), name: "tag"))
            }
            
            return .uploadMultipart(multipartData)
            
        case .getDoubleCheck:
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
        case .postSignUp:
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
            let headers = ["Accept": "application/json",
                           "Content-Type" : "multipart/form-data",
                           "Authorization" : token]
            return headers
        case .postSignIn:
            let token = UserDefaults.standard.string(forKey: "Token") ?? ""
            let headers = ["Content-Type" : "application/json", "Authorization" : token]
            return headers
        default:
            let headers = ["Content-Type" : "application/json"]
            return headers
        }
    }
    
}
