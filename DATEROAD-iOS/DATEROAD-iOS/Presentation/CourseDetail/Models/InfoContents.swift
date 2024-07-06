//
//  InfoContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/6/24.
//

import UIKit

struct InfoContents {
    let coast: Int?
    let tag: String?
    
    init(coast: Int) {
        self.coast = coast
        self.tag = nil
    }
    
    init(tag: String) {
        self.coast = nil
        self.tag = tag
    }
}

extension InfoContents {
    
    static let coast: Int = 900000
    
    static let tagContents: [InfoContents] = [InfoContents(tag: "🚙 드라이브"),
                                              InfoContents(tag: "🛍️ 쇼핑"),
                                              InfoContents(tag: "🚪 실내")]
    
}
