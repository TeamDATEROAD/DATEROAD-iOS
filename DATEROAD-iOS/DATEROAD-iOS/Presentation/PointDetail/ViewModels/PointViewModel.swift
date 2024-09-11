//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel: Serviceable {
    
    var userName: String
    
    var totalPoint: Int
    
    let pointDetailService = PointDetailService()
    
    var gainedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var usedPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isSuccessGetPointInfo: ObservablePattern<Bool> = ObservablePattern(false)
    
    var nowPointData: ObservablePattern<[PointDetailModel]> = ObservablePattern([])
    
    var isEarnedPointHidden : ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)

    var onLoading: ObservablePattern<Bool> = ObservablePattern(nil)

    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(nil)
    
    init (userName: String, totalPoint: Int) {
        self.userName = userName
        self.totalPoint = totalPoint
    }
    
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
        self.isSuccessGetPointInfo.value = false
        self.onFailNetwork.value = false
        self.setPointDetailLoading()
        
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
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            case .serverErr:
                self.onFailNetwork.value = true
             default:
                print("포인트내역 에러")
                self.onFailNetwork.value = true //TODO: - 확인
                return
            }
        }
    }
    
    func setPointDetailLoading() {
          guard let isSuccessGetPointInfo = self.isSuccessGetPointInfo.value else { return }
          self.onLoading.value = !isSuccessGetPointInfo
      }

}
