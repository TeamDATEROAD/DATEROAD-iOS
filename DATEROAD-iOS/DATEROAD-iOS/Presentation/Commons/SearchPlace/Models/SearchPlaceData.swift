//
//  SearchPlaceData.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import Foundation

struct SearchPlaceData {
    
    let name: String
    
    let address: String
    
    // TODO: - 서버 연결하면서 더미 지우기
    init(name: String = "뚝섬 이름이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오", address: String = "뚝섬 주소명이 이렇게 길진 않겠지만 길어지면 점처리를 해보자고오오") {
        self.name = name
        self.address = address
    }
    
    static var dummyData: [SearchPlaceData] = {
        return Array(repeating: SearchPlaceData.init(), count: 25)
    }()
    
}
