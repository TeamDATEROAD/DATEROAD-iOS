//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    let pointDetailService = PointDetailService()
    
    var gainedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var usedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isSuccessGetPointInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var nowPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(false)
    
    init () {
        getPointDetail()
        changeSegment(segmentIndex: 0)
    }
    
//    func fetchData() {
//        self.gainedDummyData.value = self.pointDummyData.gained
//        self.usedDummyData.value = self.pointDummyData.used
//    }
    
    func changeSegment(segmentIndex: Int) {
        isEarnedPointHidden.value = segmentIndex != 0
        updateData(nowEarnedPointHidden: isEarnedPointHidden.value ?? false)
    }
    
    func updateData(nowEarnedPointHidden: Bool) {
        if nowEarnedPointHidden {
            nowPointData.value = usedPointData.value
        } else {
            nowPointData.value = gainedPointData.value
        }
    }
    
    func getPointDetail() {
        NetworkService.shared.pointDetailService.getPointDetail() { response in
            switch response {
            case .success(let data):
                let pointGainedInfo = data.gained.map {
                    PointDetailModel(sign: "+", point: $0.point, description: $0.description, createAt: $0.createAt)
                }
                let pointUsedInfo = data.used.map {
                    PointDetailModel(sign: "-", point: $0.point, description: $0.description, createAt: $0.createAt)
                }
                self.gainedPointData.value = pointGainedInfo
                self.usedPointData.value = pointUsedInfo
//                print(pointGainedInfo, pointUsedInfo)
//                self.isSuccessGetPointInfo.value = true
            case .requestErr:
                 print("requestError")
             case .decodedErr:
                 print("decodedError")
             case .pathErr:
                 print("pathError")
             case .serverErr:
                 print("serverError")
             case .networkFail:
                 print("networkFail")
            }
        }

    }

}
