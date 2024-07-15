//
//  MainViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import Foundation

final class MainViewModel {
    
    var currentIndex: ObservablePattern<IndexPath> = ObservablePattern(IndexPath(item: 0, section: 2))
    
    var nickname: ObservablePattern<String> = ObservablePattern(nil)
    
    var upcomingData: ObservablePattern<UpcomingDateModel> = ObservablePattern(nil)
    
    var mainUserData: ObservablePattern<MainUserModel> = ObservablePattern(nil)

    var hotCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)
    
    var bannerData: ObservablePattern<[BannerModel]> = ObservablePattern(nil)

    var newCourseData: ObservablePattern<[DateCourseModel]> = ObservablePattern(nil)

    let sectionData: [MainSection] = MainSection.dataSource
    
    
    init() {
        fetchSectionData()
    }
    
}

extension MainViewModel {
    
    // TODO: - 서버 통신 후 수정 예정
    
    func fetchSectionData() {
        upcomingData.value = UpcomingDateModel.dummyData
        mainUserData.value = MainUserModel.dummyData
        hotCourseData.value = DateCourseModel.hotDateDummyData
        newCourseData.value = DateCourseModel.newDateDummyData
        bannerData.value = BannerModel.bannerDummyData
        nickname.value = MainUserModel.dummyData.name
    }
}
