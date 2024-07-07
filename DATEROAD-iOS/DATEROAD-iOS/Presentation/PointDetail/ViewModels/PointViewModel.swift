//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    var pointUserDummyData = PointUserModel(userName: "호은", totalPoint: 200)
    
    var earnedPointDummyData = [
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "+", pointAmount: 100, pointDescription: "코스 등록하기", pointDate: "2024.7.4.")
    ]
    
    var usedPointDummyData = [
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4."),
        PointModel(pointSign: "-", pointAmount: 50, pointDescription: "코스 열람하기", pointDate: "2024.7.4.")
    ]
    
    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(false)
    
    func changeSegment(segmentIndex: Int) {
        isEarnedPointHidden.value = segmentIndex != 0
    }
    
}

