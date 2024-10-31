//
//  AddScheduleFirstViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 10/22/24.
//

import UIKit

//MARK: - AddScheduleFirstViewController ViewModel

/// 일정등록 화면1 관련 ViewModel
class AddScheduleFirstViewModel: AddScheduleFirstViewModelInterface {
    
    init(addScheduleAmplitude: AddScheduleAmplitude, setLoading: @escaping (Bool) -> ()) {
        self.addScheduleAmplitude = addScheduleAmplitude
        self.setLoading = setLoading
    }
    
    var addScheduleAmplitude: AddScheduleAmplitude
    
    let setLoading: (_ isLoading: Bool) -> ()
    
    // 데이트 이름 유효성 판별 (true는 통과)
    let dateName: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateNameVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    private let minimumDateNameLength = 5
    
    // 방문 일자 유효성 판별 (true는 통과)
    let visitDate: ObservablePattern<String> = ObservablePattern(nil)
    
    let isVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 데이트 시작시간 유효성 판별 (self.count > 0 인지)
    var dateStartAt: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateStartAtVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 코스 등록 태그 생성
    var tagData: [ProfileTagModel] = []
    
    // 선택된 태그
    let isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    let isValidTag: ObservablePattern<Bool> = ObservablePattern(nil)
    
    let tagCount: ObservablePattern<Int> = ObservablePattern(nil)
    
    private let minTagCnt = 1
    
    private let maxTagCnt = 3
    
    // 코스 지역 유효성 판별
    let dateLocation: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateLocationVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 기타
    var isTimePicker: Bool?
    
    var country = ""
    
    var city = ""
    
    var isBroughtData = false
    
    var viewedDateCourseByMeData: CourseDetailViewModel?
    
    let ispastDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
    
    let isSuccessGetData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var pastDatePlaces = [TimelineModel]()
    
    var selectedTagData: [String] = []
    
    var pastDateTagIndex = [Int]()
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tag }
    }
    
    func fetchPastDate() {
        viewedDateCourseByMeData?.isSuccessGetData.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess == true {
                self.setLoading(true)
                if let data = self.viewedDateCourseByMeData {
                    dateName.value = data.titleHeaderData.value?.title
                    dateLocation.value = data.titleHeaderData.value?.city
                    dateStartAt.value = data.startAt
                    
                    //동네.KOR 불러와서 지역, 동네 ENG 버전 알아내는 미친 로직
                    let cityName = data.titleHeaderData.value?.city ?? ""
                    if let result = LocationMapper.getCountryAndCity(from: cityName) {
                        let country = result.country.rawValue
                        let city = result.city.rawValue
                        self.city = city
                        self.country = country
                        self.isDateLocationVaild.value = true
                    }
                    
                    //태그 추적해서 미리 셀렉 및 개수 표시 해버리는 진짜 미쳐버린 로직
                    guard let tags = viewedDateCourseByMeData?.tagArr else {return}
                    selectedTagData = tags.map { $0.tag }
                    pastDateTagIndex = getTagIndices(from: selectedTagData)
                    pastDateTagIndex.sort()
                    
                    print("pastDateTagIndex values: \(pastDateTagIndex)")
                    
                    checkTagCount(min: minTagCnt, max: maxTagCnt)
                    
                    isDateNameVaild.value = true
                    isDateStartAtVaild.value = true
                    isDateLocationVaild.value = true
                    
                    ///코스 등록 2 AddPlaceCollectionView 구성
                    if let result = data.timelineData.value {
                        pastDatePlaces = result
                    }
                    
                    self.setLoading(false)
                    isSuccessGetData.value = true
                }
            }
        }
    }
    
    /// (불러온)일정등록 시 tag 미리 select setting
    func getTagIndices(from tags: [String]) -> [Int] {
        return tags.compactMap { tag in
            TendencyTag.allCases.firstIndex { $0.tag.english == tag }
        }
    }
    
    func satisfyDateName(str: String) {
        isDateNameVaild.value = str.count >= minimumDateNameLength
    }
    
    func isFutureDate(date: Date, dateType: String) {
        if dateType == "date" {
            let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: date)
            visitDate.value = formattedDate
            self.isVisitDateVaild.value = true
        } else {
            var formattedDate = DateFormatterManager.shared.timeFormatter.string(from: date)
            formattedDate = formattedDate
                .replacingOccurrences(of: "오전", with: "AM")
                .replacingOccurrences(of: "오후", with: "PM")
            dateStartAt.value = formattedDate
            self.isDateStartAtVaild.value = !(dateStartAt.value?.isEmpty ?? true)
        }
    }
    
    func countSelectedTag(isSelected: Bool, tag: String) {
        if isSelected {
            if !selectedTagData.contains(tag) {
                selectedTagData.append(tag)
            }
        } else {
            if let index = selectedTagData.firstIndex(of: tag) {
                selectedTagData.remove(at: index)
            }
        }
        checkTagCount(min: minTagCnt, max: maxTagCnt)
    }
    
    func checkTagCount(min: Int, max: Int) {
        let count = selectedTagData.count
        self.tagCount.value = count
        
        if count >= min && count <= max {
            self.isValidTag.value = true
            self.isOverCount.value = false
        } else {
            self.isValidTag.value = false
            if count > max {
                self.isOverCount.value = true
            }
        }
        print(count)
    }
    
    func satisfyDateLocation(str: String) {
        let flag = !str.isEmpty
        isDateLocationVaild.value = flag
    }
    
    func isOkSixBtn() -> Bool {
        let isDateNameVaild = isDateNameVaild.value ?? false
        let isValidTag = isValidTag.value ?? false
        let isVisitDateVaild = isVisitDateVaild.value ?? false
        let isDateStartAtVaild = isDateStartAtVaild.value ?? false
        let isDateLocationVaild = isDateLocationVaild.value ?? false
        
        for i in [isDateNameVaild, isValidTag, isVisitDateVaild, isDateLocationVaild, isDateStartAtVaild] {
            if i == false {
                print("\(i) == false")
                return false
            }
        }
        return true
    }
    
}
