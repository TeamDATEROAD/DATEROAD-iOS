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
    let hashTag: String?
    
    init(image: UIImage) {
        self.image = image
        self.index = nil
        self.location = nil
        self.time = nil
        self.hashTag = nil
    }
    
    init(index: Int, location: String, time: String) {
        self.image = nil
        self.index = index
        self.location = location
        self.time = time
        self.hashTag = nil
    }
    
    init(hashTag: String) {
        self.image = nil
        self.index = nil
        self.location = nil
        self.time = nil
        self.hashTag = hashTag
    }
}

extension CourseDetailContents {
    static let images: [UIImage] = [
        UIImage(resource: .image1),
        UIImage(resource: .image1),
        UIImage(resource: .image1),
        UIImage(resource: .image1),
        UIImage(resource: .image1)
    ]
    
    static let timelineContents: [CourseDetailContents] = [
        CourseDetailContents(index: 1, location: "성수 미술관 성수점", time: "1시간"),
        CourseDetailContents(index: 2, location: "한강 공원", time: "2시간"),
        CourseDetailContents(index: 3, location: "광화문 광장", time: "1.5시간"),
        CourseDetailContents(index: 4, location: "이태원 맛집", time: "2시간"),
        CourseDetailContents(index: 5, location: "서울 타워", time: "1시간")
    ]
    
    static let hashTagContents: [CourseDetailContents] = [
        CourseDetailContents(hashTag: "🚙 드라이브"),
        CourseDetailContents(hashTag: "🛍️ 쇼핑"),
        CourseDetailContents(hashTag: "🚪 실내")
    ]
}
