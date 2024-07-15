//
//  CourseModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

struct CourseListModel {
    let courseId: Int?
    let thumbnail: UIImage?
    let location: String?
    let title: String?
    let cost: Int?
    let time: Float?
    let like: Int?
    
    init(courseId: Int?, thumbnail: UIImage, location: String?, title: String?, cost: Int?, time: Float?, like: Int?) {
        self.courseId = courseId
        self.thumbnail = thumbnail
        self.location = location
        self.title = title
        self.cost = cost
        self.time = time
        self.like = like
        
    }
}

extension CourseListModel {
    
    static let courseContents: [CourseListModel] = [
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5000),
        CourseListModel(courseId: 1, thumbnail: .image6, location: "건대/성수/왕십리", title: "나도 데이트 하고 싶다 데이트가 뭔데여 ㅜㅜㅜ", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 2, thumbnail: .image6, location: "건대/성수/왕십리", title: "캡틴 아니었으면 앱잼 이딴거 안했어", cost: 10, time: 6.5, like: 100),
        CourseListModel(courseId: 3, thumbnail: .image3, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 4, thumbnail: .image2, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 5, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 6, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 7, thumbnail: .image4, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 8, thumbnail: .image5, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", cost: 10, time: 6.5, like: 5)
    
    ]
}
