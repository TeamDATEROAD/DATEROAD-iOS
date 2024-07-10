//
//  MainContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/6/24.
//

import Foundation

struct MainContents {
    let date: String?
    let title: String?
    let coast: String?
    let time: String?
    let location: String?
    let mainText: String?
    
    init(date: String, title: String, coast: String, time: String, location: String, mainText: String) {
        self.date = date
        self.title = title
        self.coast = coast
        self.time = time
        self.location = location
        self.mainText = mainText
    }
}

extension MainContents {
    
    static let mainContents: MainContents = MainContents(
        date: "2024년 6월 27일",
        title: "나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎나랑 스껄하러 갈래?♥︎",
        coast: "10만원 초과",
        time: "10시간",
        location: "건대/성수/왕십리",
        mainText: """
"5년차 장기연애 커플이 보장하는 성수동 당일치기 데이트 코스를 소개해 드릴게요. 저희 커플은 12시에 만나서 브런치 집을 갔어요. 여기에서는 프렌치 토스트를 꼭 시키세요. 강추합니다.
                                                         
1시간 정도 밥을 먹고 바로 성수미술관에 가서 그림을 그렸는데요. 물감이 튈 수 있어서 흰색 옷은 피하는 것을 추천드려요. 2시간 정도 소요가 되는데 저희는 예약을 해둬서 웨이팅 없이 바로 입장했고, 네이버 예약을 이용했습니다. 평일 기준 20,000원이니 꼭 예약해서 가세요!

미술관에서 나와서는 어니언 카페에 가서 팡도르를 먹었습니다. 일찍 안 가면 없다고 하니 꼭 일찍 가세요!
"""
    )
}

