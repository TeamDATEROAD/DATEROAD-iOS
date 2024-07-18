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

class DateDetailViewModel {
   
//
//    var upcomingDateDetailDummyData = DateDetailModel(
//        dateID: 1,
//        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
//        startAt: "12:00",
//        city: "건대/성수/왕십리",
//        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
//        date: "June 24",
//        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,           sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1)]
//    )
//    
//    
//    var pastDateDetailDummyData = DateDetailModel(
//        dateID: 1,
//        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
//        startAt: "12:00",
//        city: "건대/성수/왕십리",
//        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
//        date: "June 24",
//        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,
//                     sequence: 1),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 2),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 3),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 4),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 5),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 6),
//                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 7)]
//    )
    
    init(dateID: Int) {
        getDateDetailData(dateID: dateID)
    }
    
    var emptyDateDetailData = DateDetailModel(dateID: 0, title: "", startAt: "", city: "", tags: [], date: "", places: [], dDay: 0)
    
    var userName : String = "수민"
    
    let dateScheduleService = DateScheduleService()
    
    var dateDetailData: ObservablePattern<DateDetailModel> = ObservablePattern(nil)
    
    var isSuccessGetDateDetailData: ObservablePattern<Bool> = ObservablePattern(nil)
    
    func getDateDetailData(dateID: Int) {
        dateScheduleService.getDateDetail(dateID: dateID) { response in
            switch response {
            case .success(let data):
                let tagsInfo: [TagsModel] = data.tags.map { tag in
                    TagsModel(tag: tag.tag)
                }
                let datePlaceInfo: [DatePlaceModel] = data.places.map { place in
                    DatePlaceModel(name: place.title, duration: (place.duration).formatFloatTime(), sequence: place.sequence)
                }
                self.dateDetailData.value = DateDetailModel(dateID: data.dateID, title: data.title, startAt: data.startAt, city: data.city, tags: tagsInfo, date: data.date, places: datePlaceInfo, dDay: data.dDay)
                self.isSuccessGetDateDetailData.value = true
                print("@log ----------dsijflskdjfla", self.dateDetailData.value)
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
    
    func deleteDateSchdeuleData(dateID: Int) {
        dateScheduleService.deleteDateSchedule(dateID: dateID) { response in
            switch response {
            case .success(let data):
                print(data)
                print("success")
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

    
    var kakaoShareInfo: [String: String] = [:]
    
    var kakaoPlacesInfo : [KakaoPlaceModel] = []
    
    var maxPlaces : Int {
        return min(dateDetailData.value?.places.count ?? 0, 5)
    }
    
    var isMoreThanFiveSchedule : Bool {
        return (dateDetailData.value?.places.count ?? 0 >= 5)
    }
    
    func setTempArgs() {
        kakaoShareInfo["userName"] = userName
//        kakaoShareInfo["title"] = dateDetailData.value?.title
        kakaoShareInfo["startAt"] = dateDetailData.value?.startAt
        print(dateDetailData.value?.places.count)
        switch dateDetailData.value?.places.count ?? 0 <= 5 {
        case true:
            for i in 0...maxPlaces-1 {
                kakaoShareInfo["name\(i+1)"] = dateDetailData.value?.places[i].name
                kakaoShareInfo["duration\(i+1)"] = "\(dateDetailData.value?.places[i].duration ?? "") 시간"
            }
            for i in maxPlaces...5 {
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
            print("is 1")
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
