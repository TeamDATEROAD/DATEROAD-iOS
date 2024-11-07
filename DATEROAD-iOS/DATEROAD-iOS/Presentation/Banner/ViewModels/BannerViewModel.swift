//
//  BannerViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/6/24.
//

import UIKit

final class BannerViewModel: Serviceable {
    
    let updateBannerDetailData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var currentPage: ObservablePattern<Int> = ObservablePattern(0)
    
    var bannerDetailData: ObservablePattern<BannerDetailModel?> = ObservablePattern(nil)
    
    var isUpdate: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var imageData: ObservablePattern<[ThumbnailModel]> = ObservablePattern(nil)
    
    var mainContentsData: ObservablePattern<MainContentsModel> = ObservablePattern(nil)
    
    let bannerSectionData: [BannerDetailSection] = BannerDetailSection.dataSource
    
    var isSuccessGetBannerData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var bannerHeaderData: ObservablePattern<BannerHeaderModel> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var advertisementId: Int = 0
    
    var bannerDetailTitle: String = ""
    
    
    init(advertisementId: Int) {
        self.advertisementId = advertisementId
    }
    
    func didSwipeImage(to index: Int) {
        currentPage.value = index
    }
    
}

extension BannerViewModel {
    
    func getBannerDetail() {
        self.isSuccessGetBannerData.value = false
        self.setBannerDetailLoading()
        self.onFailNetwork.value = false
        
        NetworkService.shared.courseDetailService.getBannerDetailInfo(advertismentId: self.advertisementId){ response in
            switch response {
            case .success(let data):
                let newBannerDetailModel = BannerDetailModel(data: data)
                
                if self.bannerDetailData.value != newBannerDetailModel {
                    self.bannerDetailData.value = newBannerDetailModel
                    
                    self.imageData.value = newBannerDetailModel.images
                    self.bannerHeaderData.value = newBannerDetailModel.headerData
                    self.bannerDetailTitle = newBannerDetailModel.title
                    self.mainContentsData.value = newBannerDetailModel.mainContents
                    self.updateBannerDetailData.value = true
                }
                
                self.isSuccessGetBannerData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onFailNetwork.value = true
                print("Failed to fetch banner detail data")
            }
        }
    }
    
    func setBannerDetailLoading() {
        guard let isSuccessGetBannerData = self.isSuccessGetBannerData.value else { return }
        self.onLoading.value = !isSuccessGetBannerData
    }
    
}
