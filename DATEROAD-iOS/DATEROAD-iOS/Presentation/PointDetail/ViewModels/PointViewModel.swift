//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    var pointDummyData: PointModel = PointModel(gained: [],
                                                used: [PointDetailModel(sign: "-", point: 100, description: "코스 열람하기", createAt: "2024.7.4."),
                                                       PointDetailModel(sign: "-", point: 100, description: "코스 열람하기", createAt: "2024.7.4."),
                                                       PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                                                       PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4."),
                                                       PointDetailModel(sign: "-", point: 100, description: "코스 등록하기", createAt: "2024.7.4.")])
    
    var gainedDummyData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var usedDummyData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var nowPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(false)
    
    init () {
        fetchData()
        changeSegment(segmentIndex: 0)
    }
    
    func fetchData() {
        self.gainedDummyData.value = self.pointDummyData.gained
        self.usedDummyData.value = self.pointDummyData.used
    }
    
    func changeSegment(segmentIndex: Int) {
        isEarnedPointHidden.value = segmentIndex != 0
        updateData(nowEarnedPointHidden: isEarnedPointHidden.value ?? false)
    }
    
    func updateData(nowEarnedPointHidden: Bool) {
        if nowEarnedPointHidden {
            nowPointData.value = usedDummyData.value
        } else {
            nowPointData.value = gainedDummyData.value
        }
    }

}

