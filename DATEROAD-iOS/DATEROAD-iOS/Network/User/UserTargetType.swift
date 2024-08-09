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
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""

        switch self {
        case .getUserProfile:
            let headers = ["Content-Type" : "application/json", "Authorization" : "Bearer " + token]
            return headers
        case .patchEditProfile:
            let headers = ["Accept": "application/json",
                           "Content-Type" : "multipart/form-data",
                           "Authorization" : "Bearer " + token]
            return headers
        }
    }
}
