//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel {
    
    var userName: String
    
    var totalPoint: Int
    
    let pointDetailService = PointDetailService()
    
    var gainedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var usedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isSuccessGetPointInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var nowPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(nil)
   
   var isChange: ObservablePattern<Bool> = ObservablePattern(nil)
    
    init (userName: String, totalPoint: Int) {
        self.userName = userName
        self.totalPoint = totalPoint
//        updateData(nowEarnedPointHidden: false)
//        changeSegment(segmentIndex: 0)
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
//        nowPointData.value = gainedPointData.value
        if nowEarnedPointHidden {
            nowPointData.value = usedPointData.value
        } else {
            nowPointData.value = gainedPointData.value
        }
    }
    
    func getPointDetail(nowEarnedPointHidden: Bool) {
        NetworkService.shared.pointDetailService.getPointDetail() { response in
            switch response {
            case .success(let data):
                let pointGainedInfo = data.gained.points.map {
                    PointDetailModel(sign: "+", point: $0.point, description: $0.description, createdAt: $0.createdAt)
                }
                let pointUsedInfo = data.used.points.map {
                    PointDetailModel(sign: "-", point: $0.point, description: $0.description, createdAt: $0.createdAt)
                }
                self.gainedPointData.value = pointGainedInfo
                self.usedPointData.value = pointUsedInfo
                self.updateData(nowEarnedPointHidden: nowEarnedPointHidden)
                self.isSuccessGetPointInfo.value = true
               self.isChange.value = true
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
