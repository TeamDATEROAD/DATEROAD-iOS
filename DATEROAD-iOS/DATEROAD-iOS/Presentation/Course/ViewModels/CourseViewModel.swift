//
//  CourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import Foundation

final class CourseViewModel {
    
    var priceData: [String] = []
    
    var courseData: [String] = []
    
    init() {
        fetchPriceData()
    }
}

extension CourseViewModel {
    
    func fetchPriceData() {
        priceData = Price.allCases.map { $0.priceTitle }
    }
}
