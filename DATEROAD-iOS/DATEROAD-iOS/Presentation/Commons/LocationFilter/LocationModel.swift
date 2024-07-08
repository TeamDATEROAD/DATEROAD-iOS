//
//  LocationModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

struct LocationModel {
    let counrty: String?
}



extension LocationModel {
    static func countryData() -> [LocationModel] {
        return [
            LocationModel(counrty: "서울"),
            LocationModel(counrty: "경기"),
            LocationModel(counrty: "인천")
        ]
    }
    
    static func cityData() -> [LocationModel] {
        return [
            LocationModel(counrty: "서울 전체"),
            LocationModel(counrty: "강남/서초"),
            LocationModel(counrty: "잠실/송파/강동"),
            LocationModel(counrty: "건대/성수/왕십리"),
            LocationModel(counrty: "종로/중구"),
            LocationModel(counrty: "홍대/합정/마포"),
            LocationModel(counrty: "영등포/여의도"),
            LocationModel(counrty: "용산/이태원/한남"),
            LocationModel(counrty: "양천/강서"),
            LocationModel(counrty: "성북/노원/여의도"),
            LocationModel(counrty: "구로/관악/동작")
        ]
    }

}


