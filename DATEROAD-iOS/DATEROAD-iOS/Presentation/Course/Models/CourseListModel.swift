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
    let coast: Int?
    let time: Float?
    let like: Int?
    
    init(courseId: Int?, thumbnail: UIImage, location: String?, title: String?, coast: Int?, time: Float?, like: Int?) {
        self.courseId = courseId
        self.thumbnail = thumbnail
        self.location = location
        self.title = title
        self.coast = coast
        self.time = time
        self.like = like
        
    }
}

extension CourseListModel {
    
    static let courseContents: [CourseListModel] = [
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5000),
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?나랑 스껄 할래?나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image3, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image2, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image6, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image4, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5),
        CourseListModel(courseId: 0, thumbnail: .image5, location: "건대/성수/왕십리", title: "나랑 스껄 할래?", coast: 10, time: 6.5, like: 5)
    
    ]
}
