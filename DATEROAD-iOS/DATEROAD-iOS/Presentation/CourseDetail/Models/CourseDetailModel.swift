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
    
    static var conditionalDummyData: ConditionalModel {
        return ConditionalModel(courseId: 0, isCourseMine: true, isAccess: true, free: 0, totalPoint: 0, isUserLiked: true)
    }
}


struct ThumbnailModel {
    let imageUrl: String
    let sequence: Int
//    let courseImages: [(imageUrl: String, sequence: Int)]
//    let like: Int
    
//    static var thumbnailDummyData: ThumbnailModel {
//        return ThumbnailModel(courseImages: [
//            (imageUrl: "https://example.com/default_image.jpg", sequence: 0)
//        ], like: 0)
//    }
}


struct TitleHeaderModel {
    var date: String
    var title: String
    var cost: Int
    var totalTime: Double
    var city: String
    
    static var titleHeaderDummyData: TitleHeaderModel {
        return TitleHeaderModel(date: "2024.7.14", title: "만원으로 데이트 하기 챌린지", cost: 10000, totalTime: 10.5, city: "건대/성수/왕십리")
    }
}


struct MainContentsModel {
    var description: String
    
    static var descriptionDummyData: MainContentsModel {
        return MainContentsModel(description: """
5년차 장기연애 커플이 보장하는 성수동 당일치기 데이트 코스를 소개해 드릴게요. 저희 커플은 12시에 만나서 브런치 집을 갔어요. 여기에서는 프렌치 토스트를 꼭 시키세요. 강추합니다.
                                 
1시간 정도 밥을 먹고 바로 성수미술관에 가서 그림을 그렸는데요. 물감이 튈 수 있어서 흰색 옷은 피하는 것을 추천드려요. 2시간 정도 소요가 되는데 저희는 예약을 해둬서 웨이팅 없이 바로 입장했고, 네이버 예약을 이용했습니다. 평일 기준 20,000원이니 꼭 예약해서 가세요!

미술관에서 나와서는 어니언 카페에 가서 팡도르를 먹었습니다. 일찍 안 가면 없다고 하니 꼭 일찍 가세요!
""")
    }
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
    
    static let timelineContents: [TimelineModel] = [
        TimelineModel(sequence: 1, title: "플롭 안국점", duration: 0.5),
        TimelineModel(sequence: 1, title: "플롭 안국점", duration: 0.5)
    ]
}




struct CoastModel {
    let totalCoast: Int
    
    static var coastDummyData: CoastModel {
        return CoastModel(totalCoast: 10000)
    }
}


struct TagModel {
    let tag: String
    
    static var tagDummyData: [TagModel] = [
        TagModel(tag: "🚙 드라이브"),
        TagModel(tag: "🛍️ 쇼핑"),
        TagModel(tag: "🚪 실내")
    ]
}

