//
//  SearchPlaceData.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import Foundation

struct SearchPlaceData: Equatable {
    
    let name: String
    
    let address: String
    
    // TODO: - 서버 연결하면서 더미 지우기
    init(name: String = "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: String = "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오") {
        self.name = name
        self.address = address
    }
    
    static var dummyData: [SearchPlaceData] = {
        return [
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬", address: "뚝섬 주소명"),
            SearchPlaceData(name: "여의도다ㄷ", address: "ㅇㅇㅇ"),
            SearchPlaceData(name: "노들섬", address: "ㄴㄷㄹㅅㅇㄴㅎㅁㅎㅁㄴㅇ"),
            SearchPlaceData(name: "ㅇㄹㄴㄹㅁㅈㄷ", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "ㅂㅈㄷㄱㅂ오"),
            SearchPlaceData(name: "ㅁㄴㅇㄹㅁㄴㅇㄹ", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "ㅇ", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "ㅂㅈㄷㄱㅂ오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "ㄴㄹ", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "베ㅜㄹㄱㅂㄷㄱ"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "ㅇㄹㄱㄷㄷㄱㅎㄱㄷㅎ", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오"),
            SearchPlaceData(name: "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오")
        ]
    }()
    
}
