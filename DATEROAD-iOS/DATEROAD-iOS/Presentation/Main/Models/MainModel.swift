//
//  MainModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

struct UpcomingDateModel: Equatable {
    
    let dateId : Int
    
    let dDay : Int
    
    let dateName : String
    
    let month : Int
    
    let day : Int
    
    let startAt : String
    
    static var emptyData: UpcomingDateModel {
        return UpcomingDateModel(dateId: 0, dDay: 0, dateName: "", month: 0, day: 0, startAt: "")
    }
    
}

struct MainUserModel: Equatable {
    
    let name: String
    
    let point: Int
    
    let imageUrl: String?
    
}

struct DateCourseModel: Equatable {
    
    let courseId: Int
    
    let thumbnail: String
    
    let title: String
    
    let city: String
    
    let like: Int
    
    let cost: Int
    
    let duration: String
    
}

struct BannerModel: Equatable {
    
    let advertisementId: Int
    
    let imageUrl: String
    
}
