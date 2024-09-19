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
    case deleteLogout
    case postSignIn(requestBody: PostSignInRequest)
    case deleteWithdrawal(requestBody: DeleteWithdrawalRequest)
    case patchReissue
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
        case .deleteLogout, .deleteWithdrawal:
            return .delete
        case .patchReissue:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return utilPath + "/signup"
        case .getDoubleCheck:
            return utilPath + "/check"
        case .deleteLogout:
            return utilPath + "/signout"
        case .postSignIn:
            return utilPath + "/signin"
        case .deleteWithdrawal:
            return utilPath + "/withdraw"
        case .patchReissue:
            return utilPath + "/reissue"
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
            
        case .postSignIn(let requstBody):
            return .requestJSONEncodable(requstBody)
        case .deleteWithdrawal(let requestBody):
            return .requestJSONEncodable(requestBody)
        default:
            return .requestPlain
            
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
            let token = UserDefaults.standard.string(forKey: StringLiterals.Network.token) ?? ""
            let headers = HeaderType.headerWithMultiPart(token: token)
            return headers
        case .deleteLogout, .deleteWithdrawal:
            let token = UserDefaults.standard.string(forKey: StringLiterals.Network.accessToken) ?? ""
            let headers = HeaderType.headerWithToken(token: "Bearer " + token)
            return headers
        case .postSignIn:
            let token = UserDefaults.standard.string(forKey: StringLiterals.Network.token) ?? ""
            let headers = HeaderType.headerWithToken(token: token)
            return headers
        case .patchReissue:
            let token = UserDefaults.standard.string(forKey: StringLiterals.Network.refreshToken) ?? ""
            let headers = HeaderType.headerWithToken(token: token)
            return headers
        default:
            let headers = HeaderType.basic
            return headers
        }
    }
    
}
