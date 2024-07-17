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
        kakaoShareInfo["title"] = dateDetailData.value?.title
        kakaoShareInfo["startAt"] = dateDetailData.value?.startAt
        
        switch dateDetailData.value?.places.count ?? 0 <= 5 {
        case true:
            for i in 0...maxPlaces-1 {
                kakaoShareInfo["name\(i+1)"] = dateDetailData.value?.places[i].name
                kakaoShareInfo["name\(i+1)"] = "\(dateDetailData.value?.places[i].duration ?? "")"
            }
            /*
            for i in maxPlaces...5 {
                kakaoPlacesInfo.append(KakaoPlaceModel(name: nil, duration: nil))
            }*/
        case false:
            for i in 0...4 {
                kakaoShareInfo["name\(i+1)"] = dateDetailData.value?.places[i].name
                kakaoShareInfo["name\(i+1)"] = "\(dateDetailData.value?.places[i].duration ?? "")"
            }
        }
    }
    
    func shareToKaKao() {
        // let appLink = Link(iosExecutionParams: ["key1": "value1", "key2": "value2"])
        
        // let appButton = Button(title: "자세히 보기", link: appLink)
        
        let templateId : Int64 = 109999

        setTempArgs()
        
        // 카카오톡 설치여부 확인
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
            // 없을 경우 카카오톡 앱스토어로 이동 (URL Scheme에 itms-apps 추가확인)
            // 나중에 히슬언니 로직이랑 합치기...?
            let url = Config.kakaoAppStore
            if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
