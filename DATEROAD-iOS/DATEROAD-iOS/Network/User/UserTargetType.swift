//
//  UserTargetType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import Foundation

import Moya

enum UserTargetType {
    
    case getUserProfile
    
    case patchEditProfile(requestBody: PatchEditProfileRequest)
    
}

extension UserTargetType: BaseTargetType {
    
    var utilPath: String {
        return "api/v1/"
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile:
            return .get
        case .patchEditProfile:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .getUserProfile, .patchEditProfile:
            return utilPath + "users"
        }
    }
    
    var task: Task {
        switch self {
        case .getUserProfile:
            return .requestPlain
        case .patchEditProfile(let requestBody):
            var multipartData = [MultipartFormData]()
            
            let namePart = MultipartFormData(provider: .data(requestBody.name.data(using: .utf8)!), name: "name")
            multipartData.append(namePart)
            
            if let image = requestBody.image, let imageData = image.jpegData(compressionQuality: 1.0) {
                let imagePart = MultipartFormData(provider: .data(imageData), name: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(imagePart)
            }
            
            if let tagData = try? JSONSerialization.data(withJSONObject: requestBody.tags, options: []) {
                multipartData.append(MultipartFormData(provider: .data(tagData), name: "tags"))
            }
            
            let boolString = requestBody.isDefaultImage ? "true" : "false"
            
            // 문자열을 Data로 변환
            let boolData = boolString.data(using: .utf8)!
            
            // MultipartFormData 생성
            let boolPart = MultipartFormData(provider: .data(boolData), name: "isDefaultImage")
            multipartData.append(boolPart)
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: StringLiterals.Network.accessToken) ?? ""
        
        switch self {
        case .getUserProfile:
            let headers = HeaderType.headerWithToken(token: "Bearer " + token)
            return headers
        case .patchEditProfile:
            let headers = HeaderType.headerWithMultiPart(token: "Bearer " + token)
            return headers
        }
    }
    
}
