//
//  DateDetailViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import KakaoSDKShare
import KakaoSDKTemplate
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class DateDetailViewModel: Serviceable {
    
    private var currentDateDetailData: DateDetailModel?
    
    let updateDateDetailData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var type: ObservablePattern<NetworkType> = ObservablePattern(nil)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var userName : String = UserDefaults.standard.string(forKey: StringLiterals.Network.userName) ?? ""
    
    let dateScheduleService = DateScheduleService()
    
    var dateDetailData: ObservablePattern<DateDetailModel> = ObservablePattern(nil)
    
    var isSuccessGetDateDetailData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessDeleteDateScheduleData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onDeleteDateDetailLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onDateDetailLoading: ObservablePattern<Bool> = ObservablePattern(true)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var kakaoShareInfo: [String: String] = [:]
    
    var kakaoPlacesInfo : [KakaoPlaceModel] = []
    
    var maxPlaces : Int {
        return min(dateDetailData.value?.places.count ?? 0, 5)
    }
    
    var isMoreThanFiveSchedule : Bool {
        return (dateDetailData.value?.places.count ?? 0 >= 5)
    }
    
    var dateCourseNum : Int = 0
    
    var dateTotalDuration : Float = 0
    
}

extension DateDetailViewModel {
    
    // '지난 데이트 상세보기' or '다가올 데이트 상세보기' 데이터 .get
    func getDateDetailData(dateID: Int) {
        self.isSuccessGetDateDetailData.value = false
        self.setDateDetailLoading()
        self.onFailNetwork.value = false
        
        NetworkService.shared.dateScheduleService.getDateDetail(dateID: dateID) { response in
            switch response {
            case .success(let data):
                let tagsInfo: [TagsModel] = data.tags.map { tag in
                    TagsModel(tag: tag.tag)
                }
                
                let datePlaceInfo: [DatePlaceModel] = data.places.map { place in
                    DatePlaceModel(name: place.title, duration: (place.duration).formatFloatTime(), sequence: place.sequence)
                }
                
                let newDateDetailData = DateDetailModel(dateID: data.dateID,
                                                        title: data.title,
                                                        startAt: data.startAt,
                                                        city: data.city,
                                                        tags: tagsInfo,
                                                        date: data.date.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일") ?? "",
                                                        places: datePlaceInfo,
                                                        dDay: data.dDay)
                
                // 기존 데이터와 비교 이후 동작
                if self.currentDateDetailData != newDateDetailData {
                    self.currentDateDetailData = newDateDetailData
                    self.dateDetailData.value = newDateDetailData
                    self.dateCourseNum = newDateDetailData.places.count
                    self.dateTotalDuration = datePlaceInfo.map { Float($0.duration) ?? 0 }.reduce(0, +)
                    self.updateDateDetailData.value = true
                }
                
                self.isSuccessGetDateDetailData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.type.value = NetworkType.getDateDetail
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onFailNetwork.value = true
            }
        }
    }
    
    func setDateDetailLoading() {
        guard let isSuccessGetDateDetailData = self.isSuccessGetDateDetailData.value else { return }
        self.onDateDetailLoading.value = !isSuccessGetDateDetailData
    }
    
    func deleteDateSchdeuleData(dateID: Int) {
        self.onFailNetwork.value = false
        self.setDateDetailLoading()
        
        NetworkService.shared.dateScheduleService.deleteDateSchedule(dateID: dateID) { response in
            switch response {
            case .success:
                self.isSuccessDeleteDateScheduleData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.type.value = NetworkType.deleteDateSchedule
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onFailNetwork.value = true
            }
        }
    }
    
    func setTempArgs() {
        kakaoShareInfo[StringLiterals.Network.userName] = userName
        kakaoShareInfo["startAt"] = dateDetailData.value?.startAt
        switch dateDetailData.value?.places.count ?? 0 <= 5 {
        case true:
            for i in 0...maxPlaces-1 {
                kakaoShareInfo["name\(i+1)"] = dateDetailData.value?.places[i].name
                kakaoShareInfo["duration\(i+1)"] = "\(dateDetailData.value?.places[i].duration ?? "") 시간"
            }
            for _ in maxPlaces...5 {
                kakaoPlacesInfo.append(KakaoPlaceModel(name: nil, duration: nil))
            }
        case false:
            for i in 0...4 {
                kakaoShareInfo["name\(i+1)"] = dateDetailData.value?.places[i].name
                kakaoShareInfo["duration\(i+1)"] = "\(dateDetailData.value?.places[i].duration ?? "") 시간"
            }
        }
    }
    
    func shareToKakao(context: UIViewController) {
        if !AuthApi.hasToken() {
            // Generate Redirect URI
            let redirectURI = "kakao\(Config.kakaoNativeAppKey)://oauth"
            // Redirect to Kakao login page
            let loginUrl = "https://kauth.kakao.com/oauth/authorize?client_id=\(Config.kakaoNativeAppKey)&redirect_uri=\(redirectURI)&response_type=code"
            let webVC = DRWebViewController(urlString: loginUrl)
            context.present(webVC, animated: true, completion: nil)
            return
        }
        
        let templateId: Int64 = 109999
        setTempArgs()
        
        // Check if KakaoTalk is installed
        if ShareApi.isKakaoTalkSharingAvailable() {
            ShareApi.shared.shareCustom(
                templateId: templateId,
                templateArgs: kakaoShareInfo) {(sharingResult, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("shareCustom() success.")
                        if let sharingResult = sharingResult {
                            UIApplication.shared.open(sharingResult.url, options: [:], completionHandler: nil)
                        }
                    }
                }
        } else {
            if let sharingResult = ShareApi.shared.makeCustomUrl(templateId: templateId, templateArgs: kakaoShareInfo) {
                print("makeCustomURL success")
                let webVC = DRWebViewController(urlString: sharingResult.absoluteString)
                context.present(webVC, animated: true, completion: nil)
            } else {
                let error = NSError(domain: "CustomURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create custom URL"])
                print(error)
            }
        }
    }
    
}
