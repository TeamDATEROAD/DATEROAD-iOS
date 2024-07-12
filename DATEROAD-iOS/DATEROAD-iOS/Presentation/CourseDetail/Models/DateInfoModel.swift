//
//  InfoContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/6/24.
//

import UIKit

struct DateInfoModel {
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

extension DateInfoModel {
    
    static let coast: Int = 50000
    
    static let tagContents: [DateInfoModel] = [DateInfoModel(tag: "🚙 드라이브"),
                                              DateInfoModel(tag: "🛍️ 쇼핑"),
                                              DateInfoModel(tag: "🚪 실내")]
    
}
