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
        places: [DatePlaceModel(name: "성수미술관 연남점", duration: 2, sequence: 1),
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
    
    /*
    func setItemInfo(maxPlaces: Int) {
        for i in 1...maxPlaces+1 {
            itemInfo.append(
                ItemInfo(name: upcomingDateDetailDummyData.places[i].name, duration: "\(upcomingDateDetailDummyData.places[i].duration)시간")
                )
        }
    }
     */
    
    func shareToKaKao() {
        let appLink = Link(iosExecutionParams: ["key1": "value1", "key2": "value2"])
        
        let appButton = Button(title: "자세히 보기", link: appLink)
        
        let templateId : Int64 = 109999

        // 카카오톡 설치여부 확인
        if ShareApi.isKakaoTalkSharingAvailable() {
            ShareApi.shared.shareCustom(
                templateId: templateId,
                templateArgs: ["userName": userName,
                               "title": upcomingDateDetailDummyData.title]) {(sharingResult, error) in
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
                // 없을 경우 카카오톡 앱스토어로 이동합니다. (이거 하려면 URL Scheme에 itms-apps 추가 해야함)
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
