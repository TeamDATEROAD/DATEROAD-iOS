//
//  AddScheduleFirstViewModelInterface.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 10/22/24.
//

import UIKit

/// 일정등록 화면1 Interface
protocol AddScheduleFirstViewModelInterface {
    
    //MARK: - Observable & Properties
    
    var isBroughtData: Bool { get set }
    
    var isTimePicker: Bool? { get set }
    
    var dateName: ObservablePattern<String> { get }
    
    var isDateNameVaild: ObservablePattern<Bool> { get }
    
    var visitDate: ObservablePattern<String> { get }
    
    var isVisitDateVaild: ObservablePattern<Bool> { get }
    
    var dateStartAt: ObservablePattern<String> { get set }
    
    var isDateStartAtVaild: ObservablePattern<Bool> { get }
    
    var isOverCount: ObservablePattern<Bool> { get }
    
    var isValidTag: ObservablePattern<Bool> { get }
    
    var tagCount: ObservablePattern<Int> { get }
    
    var dateLocation: ObservablePattern<String> { get }
    
    var isDateLocationVaild: ObservablePattern<Bool> { get }
    
    var country: String { get set }
    
    var city: String { get set }
    
    var selectedTagData: [String] { get }
    
    var ispastDateVaild: ObservablePattern<Bool> { get }
    
    var isSuccessGetData: ObservablePattern<Bool> { get }
    
    var tagData: [ProfileTagModel] { get }
    
    var pastDateTagIndex: [Int] { get }
    
    var pastDatePlaces: [TimelineModel] { get set }
    
    var viewedDateCourseByMeData: CourseDetailViewModel? { get set }
    
    
    //MARK: - Func()
    
    /// Related to Tag
    /// - 버튼 세팅
    func fetchTagData()
    
    /// Related to Data setting
    /// - (불러온)일정등록 시 해당 일정 데이터 세팅
    func fetchPastDate()
    
    /// Related to DateName
    /// - 데이트이름 길이 유효성 검사
    func satisfyDateName(str: String)
    
    /// Related to DatePicker
    /// - .date와 .time의 경우를 나눠 값 할당
    func isFutureDate(date: Date, dateType: String)
    
    /// Related to Tag
    /// - 기존 선택된 태그 or 미선택된 태그를 선택했을 때 이후 상황을 다룸
    func countSelectedTag(isSelected: Bool, tag: String)
    
    /// Related to Tag
    /// - 태그 유효성 검사
    func checkTagCount(min: Int, max: Int)
    
    /// Related to DateLocation
    /// - 데이트장소 유효성 검사
    func satisfyDateLocation(str: String)
    
    /// Related to NextBtn
    /// - 다음 버튼 활성화 여부
    func isOkSixBtn() -> Bool
    
}
