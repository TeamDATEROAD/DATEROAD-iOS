//
//  SearchPlaceTargetType.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/3/25.
//

import Foundation

import Moya

enum SearchPlaceTargetType {
    
    case getSearchPlace(GetSearchPlaceRequest)
    
}


extension SearchPlaceTargetType: BaseTargetType {
    
    var utilPath: String {
        return ""
    }

    var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.kakaoSearchPlaceBaseURL) as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨KAKAO_SEARCH_PLACE_BASE_URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .getSearchPlace(let request):
            return request.toDictionary()
        }
    }
    
    var task: Task {
        if let parameter = parameter {
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var path: String {
        return "keyword.json"
    }

    
    var headers: [String : String]? {
        let header = HeaderType.hearderWithRestAPIKey(key: Config.kakaoRestAPIKey)
        return header
    }
    
}
