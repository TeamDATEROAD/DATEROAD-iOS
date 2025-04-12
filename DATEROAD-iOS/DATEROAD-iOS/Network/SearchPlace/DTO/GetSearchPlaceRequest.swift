//
//  GetSearchPlaceRequest.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/2/25.
//

import Foundation

struct GetSearchPlaceRequest: Codable {
    
    let query: String                       // 질의어
    
    let categoryGroupCode: String?          // 카테고리 그룹 코드
    
    let x, y, rect, sort: String?           // X 좌표, Y 좌표, 결과 정렬 기준
    
    let radius, page, size: Int?            // 사각형 범위 내에서 제한 검색을 위한 좌표, 결과 페이지 번호, 한 페이지에 보여질 문서 수
    
    enum CodingKeys: String, CodingKey {
        
        case query, page, size, x, y, rect, sort, radius
        
        case categoryGroupCode = "category_group_code"
    }
    
    init(
        query: String,
        categoryGroupCode: String? = nil,
        x: String? = nil,
        y: String? = nil,
        rect: String? = nil,
        sort: String? = nil,
        radius: Int? = nil,
        page: Int? = nil,
        size: Int? = nil
    ) {
        self.query = query
        self.categoryGroupCode = categoryGroupCode
        self.x = x
        self.y = y
        self.rect = rect
        self.sort = sort
        self.radius = radius
        self.page = page
        self.size = size
    }
    
}


enum CategoryGroupCode: String, Codable {
    
    case MT1 = "대형마트"
    
    case CS2 = "편의점"
    
    case PS3 = "어린이집, 유치원"
    
    case SC4 = "학교"
    
    case AC5 = "학원"
    
    case PK6 = "주차장"
    
    case OL7 = "주유소, 충전소"
    
    case SW8 = "지하철역"
    
    case BK9 = "은행"
    
    case CT1 = "문화시설"
    
    case AG2 = "중개업소"
    
    case PO3 = "공공기관"
    
    case AT4 = "관광명소"
    
    case AD5 = "숙박"
    
    case FD6 = "음식점"
    
    case CE7 = "카페"
    
    case HP8 = "병원"
    
    case PM9 = "약국"
    
}

