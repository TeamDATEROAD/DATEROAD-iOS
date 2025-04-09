//
//  GetSearchPlaceResponse.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/2/25.
//

import Foundation

// MARK: - GetSearchPlaceResponse

struct GetSearchPlaceResponse: Codable {
    
    let documents: [Document]
    
    let meta: Meta
    
}

// MARK: - Document

struct Document: Codable {

    let id, placeName, categoryName: String

    let categoryGroupCode, categoryGroupName, phone: String

    let addressName, roadAddressName, x, y: String
    
    let distance, placeURL: String


    enum CodingKeys: String, CodingKey {

        case addressName = "address_name"

        case categoryGroupCode = "category_group_code"

        case categoryGroupName = "category_group_name"

        case categoryName = "category_name"

        case distance, id, phone

        case placeName = "place_name"

        case placeURL = "place_url"

        case roadAddressName = "road_address_name"

        case x, y

    }
}


// MARK: - Meta

struct Meta: Codable {
    
    let totalCount, pageableCount: Int      // 결과 수, 노출 가능 문서 수
    
    let isEnd: Bool                         // 현재 페이지가 마지막 페이지인지 여부
    
    let sameName: SameName                  // 질의어의 지역 및 키워드 분석 정보
        
    enum CodingKeys: String, CodingKey {
        
        case isEnd = "is_end"
        
        case pageableCount = "pageable_count"
        
        case sameName = "same_name"
        
        case totalCount = "total_count"
    }
    
}


// MARK: - SameName

struct SameName: Codable {
    
    let region: [String]                    // 질의어에서 인식된 지역의 목록

    let keyword, selectedRegion: String     // 질의어에서 지역 정보를 제외한 키워드, 인식된 지역 목록 중, 현재 검색에 사용된 지역 정보
    
    enum CodingKeys: String, CodingKey {
        
        case keyword, region
        
        case selectedRegion = "selected_region"
        
    }
    
}
