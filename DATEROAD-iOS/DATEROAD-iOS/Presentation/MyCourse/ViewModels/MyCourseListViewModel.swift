//
//  MyCourseListViewModel.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import Foundation

class MyCourseListViewModel {
    
    var userName = "수민" //나중에 유저디폴트? 아무튼 로직으로 변경
    
    let myCourseService = MyCourseService()
    
    var viewedCourseData : [MyCourseModel] = []
    
    var myRegisterCourseData : [MyCourseModel] = []
    
    init(userName: String = "수민") {
        self.userName = userName
        setViewedCourseData()
        setMyRegisterCourseData()
    }
    
    func setViewedCourseData() {
        myCourseService.getViewedCourse() { [weak self] response in
            switch response {
            case .success(let data):
                let viewedCourseData = data.courses.map {
                    MyCourseModel(courseId: $0.courseID, thumbnail: $0.thumbnail, title: $0.title, city: $0.city, cost: $0.cost, duration: $0.duration, like: $0.like)
                }
                self?.viewedCourseData = viewedCourseData
                print(viewedCourseData)
            case .requestErr:
                print("requestError")
            case .decodedErr:
                print("decodedError")
            case .pathErr:
                print("pathError")
            case .serverErr:
                print("serverError")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func setMyRegisterCourseData() {
        myCourseService.getMyRegisterCourse() { [weak self] response in
            switch response {
            case .success(let data):
                let myRegisterCourseData = data.courses.map {
                    MyCourseModel(courseId: $0.courseID, thumbnail: $0.thumbnail, title: $0.title, city: $0.city, cost: $0.cost, duration: $0.duration, like: $0.like)
                }
                self?.myRegisterCourseData = myRegisterCourseData
                print(myRegisterCourseData)
            case .requestErr:
                print("requestError")
            case .decodedErr:
                print("decodedError")
            case .pathErr:
                print("pathError")
            case .serverErr:
                print("serverError")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    /*
    var viewedCourseDummyData = [
        MyCourseListModel(courseID: 1, courseLike: 5000, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 2, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 3, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 4, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 5, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 6, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 7, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
        MyCourseListModel(courseID: 8, courseLike: 5, courseThumbnail: "", courseTitle: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", courseLocation: "건대/성수/왕십리", courseExpense: "10만원 초과", courseTime: "10시간"),
    ]*/
    
    /*
    var myRegisterCourseDummyData = [
        MyCourseModel(courseId: 1, thumbnail: "", title: "여기 야끼니쿠 꼭 먹으러 가세요\n하지만 일본에 있습니다.", city: "건대/성수/왕십리", cost: 10, duration: 6.5, like: 5)
    ]*/
}
