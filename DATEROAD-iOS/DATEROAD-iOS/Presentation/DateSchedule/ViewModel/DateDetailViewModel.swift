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
   
    var upcomingDateDetailDummyData = DateDetailModel(
        dateID: 1,
        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
        startAt: "12:00",
        city: "건대/성수/왕십리",
        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
        date: "June 24",
        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,           sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1)]
    )
    
    
    var pastDateDetailDummyData = DateDetailModel(
        dateID: 1,
        title: "성수동 당일치기 데이트 가볼까요? 이 정돈 어떠신지?",
        startAt: "12:00",
        city: "건대/성수/왕십리",
        tags: ["🎨 전시·팝업", "🎨 전시·팝업", "🎨 전시·팝업"],
        date: "June 24",
        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2,
                     sequence: 1),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 2),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 3),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 4),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 5),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 6),
                 DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 7)]
    )
    
    var userName : String = "수민"
    
    var maxPlaces : Int {
        return min(upcomingDateDetailDummyData.places.count, 5)
    }
    
    var kakaoShareInfo: [String: String] = [:]
    
    var kakaoPlacesInfo : [KakaoPlaceModel] = []
    
    func setTempArgs() {
        kakaoShareInfo["userName"] = userName
        kakaoShareInfo["title"] = upcomingDateDetailDummyData.title
        kakaoShareInfo["startAt"] = upcomingDateDetailDummyData.startAt
        
        switch upcomingDateDetailDummyData.places.count <= 5 {
        case true:
            for i in 0...maxPlaces-1 {
                kakaoShareInfo["name\(i+1)"] = upcomingDateDetailDummyData.places[i].name
                kakaoShareInfo["name\(i+1)"] = "\(upcomingDateDetailDummyData.places[i].duration)"
            }
            /*
            for i in maxPlaces...5 {
                kakaoPlacesInfo.append(KakaoPlaceModel(name: nil, duration: nil))
            }*/
        case false:
            for i in 0...4 {
                kakaoShareInfo["name\(i+1)"] = upcomingDateDetailDummyData.places[i].name
                kakaoShareInfo["name\(i+1)"] = "\(upcomingDateDetailDummyData.places[i].duration)"
            }
        }
    }
    
    func shareToKaKao() {
        let appLink = Link(iosExecutionParams: ["key1": "value1", "key2": "value2"])
        
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
            let url = "itms-apps://itunes.apple.com/app/362057947"
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
