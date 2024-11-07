//
//  PointViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import Foundation

final class PointViewModel: Serviceable {
    
    private var currentGainedPointData: [PointDetailModel] = []
    
    private var currentUsedPointData: [PointDetailModel] = []
    
    let updateGainedPointData: ObservablePattern<Bool> = ObservablePattern(false)
    
    let updateUsedPointData: ObservablePattern<Bool> = ObservablePattern(false)
    
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
                let newGainedPointInfo = data.gained.points.map {
                    PointDetailModel(sign: "+", point: $0.point, description: $0.description, createdAt: $0.createdAt)
                }
                let newUsedPointInfo = data.used.points.map {
                    PointDetailModel(sign: "-",
                                     point: $0.point,
                                     description: $0.description,
                                     createdAt: $0.createdAt)
                }
                
                // 포인트 획득내역 기존 데이터와 비교
                if self.currentGainedPointData != newGainedPointInfo {
                    self.currentGainedPointData = newGainedPointInfo
                    self.gainedPointData.value = newGainedPointInfo
                    self.updateGainedPointData.value = true
                }
                
                // 포인트 사용내역 기존 데이터와 비교
                if self.currentUsedPointData != newUsedPointInfo {
                    self.currentUsedPointData = newUsedPointInfo
                    self.usedPointData.value = newUsedPointInfo
                    self.updateUsedPointData.value = true
                }
                
                self.updateData(nowEarnedPointHidden: nowEarnedPointHidden)
                self.isSuccessGetPointInfo.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onFailNetwork.value = true
                return
            }
        }
    }
    
    func setPointDetailLoading() {
        guard let isSuccessGetPointInfo = self.isSuccessGetPointInfo.value else { return }
        self.onLoading.value = !isSuccessGetPointInfo
    }
    
}
