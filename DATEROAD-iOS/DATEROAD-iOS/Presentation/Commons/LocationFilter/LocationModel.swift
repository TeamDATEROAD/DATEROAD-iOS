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
}


