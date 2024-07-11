//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    var pointDummyData = PointModel(
        gained: [PointDetailModel(sign: "+", point: 50, description: "코스 열람하기", createAt: "2024.7.4."),
                 PointDetailModel(sign: "+", point: 50, description: "코스 열람하기", createAt: "2024.7.4."),
                 PointDetailModel(sign: "+", point: 50, description: "코스 열람하기", createAt: "2024.7.4."),
                 PointDetailModel(sign: "+", point: 50, description: "코스 열람하기", createAt: "2024.7.4."),
                 PointDetailModel(sign: "+", point: 50, description: "코스 열람하기", createAt: "2024.7.4.")],
        used: [])

    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(false)
    
    func changeSegment(segmentIndex: Int) {
        isEarnedPointHidden.value = segmentIndex != 0
    }
    
}

