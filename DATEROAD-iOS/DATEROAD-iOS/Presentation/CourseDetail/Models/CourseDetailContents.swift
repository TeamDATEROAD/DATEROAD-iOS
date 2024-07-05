//
//  CourseDetailContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/3/24.
//

import UIKit

import UIKit

struct CourseDetailContents {
    let image: UIImage?
    let index: Int?
    let location: String?
    let time: String?
    let tag: String?
    
    init(image: UIImage) {
        self.image = image
        self.index = nil
        self.location = nil
        self.time = nil
        self.tag = nil
    }
    
    init(index: Int, location: String, time: String) {
        self.image = nil
        self.index = index
        self.location = location
        self.time = time
        self.tag = nil
    }
    
    init(tag: String) {
        self.image = nil
        self.index = nil
        self.location = nil
        self.time = nil
        self.tag = tag
    }
}

extension CourseDetailContents {
    static let images: [UIImage] = [
        UIImage(resource: .image1),
        UIImage(resource: .image2),
        UIImage(resource: .image3),
        UIImage(resource: .image4),
        UIImage(resource: .image5)
    ]
    
    static func timelineContents() -> [CourseDetailContents] {
        return [
            CourseDetailContents(index: 1, location: "성수 미술관 성수점", time: "1시간"),
            CourseDetailContents(index: 2, location: "한강 공원", time: "2시간"),
            CourseDetailContents(index: 3, location: "광화문 광장", time: "1시간"),
            CourseDetailContents(index: 4, location: "이태원 맛집", time: "2시간"),
            CourseDetailContents(index: 5, location: "서울 타워", time: "1시간")
        ]
    }
    
    static let tagContents: [CourseDetailContents] = [
        CourseDetailContents(tag: "🚙 드라이브"),
        CourseDetailContents(tag: "🛍️ 쇼핑"),
        CourseDetailContents(tag: "🚪 실내")
    ]
}
