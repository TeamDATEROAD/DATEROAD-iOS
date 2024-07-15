//
//  MainModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

struct UpcomingDateModel {
    let dateId : Int
    let dDay : Int
    let dateName : String
    let month : Int
    let day : Int
    let startAt : String
    
    static var dummyData: UpcomingDateModel {
        return UpcomingDateModel(dateId: 1, dDay: 0, dateName: "스리랑 데이트", month: 7, day: 20, startAt: "12:00 PM")
    }

    static var emptyData: UpcomingDateModel {
        return UpcomingDateModel(dateId: 0, dDay: 0, dateName: "", month: 0, day: 0, startAt: "")
    }
}

struct MainUserModel {
    let name: String
    let point: Int
    let imageUrl: String?
    
    static var dummyData: MainUserModel {
        return MainUserModel(name: "스리", point: 7, imageUrl: "www.asdfasdfds.jpg")
    }
}

struct DateCourseModel {
    let courseId: Int
    let thumbnail: String
    let title: String
    let city: String
    let like: Int
    let cost: Int
    let duration: Int
    
    static var hotDateDummyData: [DateCourseModel] {
        return [DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 성수편 스리와 데이트 - 성수편", city: "건대/상수/왕십리", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 홍대편", city: "홍대/합정/마포", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 한남편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 종로편", city: "종로/중구", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 여의도편", city: "영등포/여의도", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 해방촌편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 신용산편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10)]
    }
    
    static var newDateDummyData: [DateCourseModel] {
        return [DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 여의도편 스리와 데이트 - 여의도편", city: "영등포/여의도", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 해방촌편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 신용산편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 성수편", city: "건대/상수/왕십리", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 홍대편", city: "홍대/합정/마포", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 한남편", city: "용산/이태원/한남", like: 3, cost: 10, duration: 10),
                DateCourseModel(courseId: 1, thumbnail: "www.asdfasdfds.jpg", title: "스리와 데이트 - 종로편", city: "종로/중구", like: 3, cost: 10, duration: 10)]
    }
}

struct BannerModel {
    let imageUrl: UIImage
    
    static var bannerDummyData: [BannerModel] {
//        return [BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "스리 픽"),
//                BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "에디터 픽"),
//                BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "스리 픽"),
//                BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "에디터 픽"),
//                BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "스리 픽"),
//                BannerModel(advertismentId: 0, imageUrl: "www.naver.jpg", title: "관리자 아카이빙 게시물 이름", tag: "에디터 픽")
//        ]
        return [BannerModel(imageUrl: UIImage(resource: .testImage2)),
                BannerModel(imageUrl: UIImage(resource: .test)),
                BannerModel(imageUrl: UIImage(resource: .testImage2)),
                BannerModel(imageUrl: UIImage(resource: .test)),
                BannerModel(imageUrl: UIImage(resource: .testImage2)),
                BannerModel(imageUrl: UIImage(resource: .test))
        ]
    }
}
