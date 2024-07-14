//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    var pointDummyData: PointModel = PointModel(gained: [], used: [])
    
    var gainedDummyData: [PointDetailModel] = []
    
    var usedDummyData: [PointDetailModel] = []
    
//    var pointDummyData = PointModel(
//        gained: [PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//                 PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//                 PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//                 PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//                 PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4.")],
//        used: [PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//               PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//               PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//               PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
//               PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4.")])

    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(false)
    
    init () {
        changeSegment(segmentIndex: 0)
        fetchData()
    }
    
    func changeSegment(segmentIndex: Int) {
        isEarnedPointHidden.value = segmentIndex != 0
    }
    
    func fetchData() {
        self.pointDummyData = PointModel(
            gained: [PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                     PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                     PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                     PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                     PointDetailModel(sign: "+", point: 100, description: "코스 등록하기", createAt: "2024.7.4.")],
            used: [])
        self.gainedDummyData = self.pointDummyData.gained
        self.usedDummyData = self.pointDummyData.used
    }
}

