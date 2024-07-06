//
//  TimelineContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/6/24.
//

import UIKit

struct TimelineContents {
    let index: Int?
    let location: String?
    let time: Int?
    
    init(index: Int, location: String, time: Int) {
        self.index = index
        self.location = location
        self.time = time
    }
}

extension TimelineContents {
    
    static let timelineContents: [TimelineContents] = [
        TimelineContents(index: 1, location: "서울 남산 타워", time: 2),
        TimelineContents(index: 2, location: "명동교자", time: 2),
        TimelineContents(index: 3, location: "남산골 한옥마을", time: 2),
        TimelineContents(index: 4, location: "동대문 시장", time: 2),
        TimelineContents(index: 5, location: "진옥화 할매 원조 닭한마리", time: 2),
        TimelineContents(index: 6, location: "청계천", time: 2)
    ]
}
