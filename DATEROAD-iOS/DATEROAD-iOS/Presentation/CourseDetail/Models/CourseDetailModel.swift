//
//  CourseDetailModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/13/24.
//

struct ConditionalModel {
    var courseId: Int
    var isCourseMine: Bool
    var isAccess: Bool
    var free: Int
    var totalPoint: Int
    var isUserLiked: Bool
    
    init(courseId: Int, isCourseMine: Bool, isAccess: Bool, free: Int, totalPoint: Int, isUserLiked: Bool) {
        self.courseId = courseId
        self.isCourseMine = isCourseMine
        self.isAccess = isAccess
        self.free = free
        self.totalPoint = totalPoint
        self.isUserLiked = isUserLiked
    }
}


struct ThumbnailModel {
    let imageUrl: String
    let sequence: Int
}


struct TitleHeaderModel {
    var date: String
    var title: String
    var cost: Int
    var totalTime: Double
    var city: String
}


struct MainContentsModel {
    var description: String
}


struct TimelineModel {
    let sequence: Int
    let title: String
    let duration: Float
    
    init(sequence: Int, title: String, duration: Float) {
        self.sequence = sequence
        self.title = title
        self.duration = duration
    }
}


struct CoastModel {
    let totalCoast: Int
}


struct TagModel {
    let tag: String
}

