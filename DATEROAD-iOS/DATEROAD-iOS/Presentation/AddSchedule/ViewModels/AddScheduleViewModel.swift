//
//  AddScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

final class AddScheduleViewModel: Serviceable {
   
   var isBroughtData = false
   
   var viewedDateCourseByMeData: CourseDetailViewModel?
   
   let ispastDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
   let isSuccessGetData: ObservablePattern<Bool> = ObservablePattern(false)
   
   var pastDatePlaces = [TimelineModel]()
   
   var selectedTagData: [String] = []
   
   var pastDateTagIndex = [Int]()
   
   
   //MARK: - AddFirstCourse 사용되는 ViewModel
   
   // 데이트 이름 유효성 판별 (true는 통과)
   let dateName: ObservablePattern<String> = ObservablePattern(nil)
   
   let isDateNameVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   private let minimumDateNameLength = 5
   
   // 방문 일자 유효성 판별 (true는 통과)
   let visitDate: ObservablePattern<String> = ObservablePattern(nil)
   
   let isVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   // 데이트 시작시간 유효성 판별 (self.count > 0 인지)
   let dateStartAt: ObservablePattern<String> = ObservablePattern(nil)
   
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
   
   
   //MARK: - AddSecondView 전용 Viewmodel 변수
   
   var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
   
   let datePlace: ObservablePattern<String> = ObservablePattern(nil)
   
   let timeRequire: ObservablePattern<String> = ObservablePattern(nil)
   
   let isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
   
   let editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
   
   var isChange: (() -> Void)?
   
   var isEditMode: Bool = false
   
   let onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
   
   let isSuccessPostData: ObservablePattern<Bool> = ObservablePattern(false)
   
   let onLoading: ObservablePattern<Bool> = ObservablePattern(false)
   
   let onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
   
   
   //MARK: - AddSchedule Amplitude 관련 변수
   
   var dateTitle: Bool = false
   
   var dateDate: Bool = false
   
   var dateTime: Bool = false
   
   var dateTagNum: Int = 0
   
   var dateArea: Bool = false
   
   var dateDetailLocation: Bool = false
   
   var dateDetailTime: Bool = false
   
   var dateCourseNum: Int = 0
   
   
   // MARK: - Initializer
   
   init() {
      initAmplitudeVar()
      fetchTagData()
   }
   
}

extension AddScheduleViewModel {
   
   func initAmplitudeVar() {
      dateTitle = false
      dateDate = false
      dateTime = false
      dateTagNum = 0
      dateArea = false
      dateDetailLocation = false
      dateDetailTime = false
      dateCourseNum = 0
   }
   
   func resetAddFirstScheduleAmplitude() {
      dateTitle = false
      dateDate = false
      dateTime = false
      dateTagNum = 0
      dateArea = false
   }
   
   func schedule1BackAmplitude() {
      AmplitudeManager.shared.trackEventWithProperties(
         StringLiterals.Amplitude.EventName.clickSchedule1Back,
         properties: [
            StringLiterals.Amplitude.Property.dateTitle: self.dateTitle,
            StringLiterals.Amplitude.Property.dateDate: self.dateDate,
            StringLiterals.Amplitude.Property.dateTime: self.dateTime,
            StringLiterals.Amplitude.Property.dateTagNum: self.dateTagNum,
            StringLiterals.Amplitude.Property.dateArea: self.dateArea
         ]
      )
      self.resetAddFirstScheduleAmplitude()
   }
   
   func schedule2BackAmplitude() {
      AmplitudeManager.shared.trackEventWithProperties(
         StringLiterals.Amplitude.EventName.clickSchedule2Back,
         properties: [
            StringLiterals.Amplitude.Property.dateDetailLocation: self.dateDetailLocation,
            StringLiterals.Amplitude.Property.dateDetailTime: self.dateDetailTime,
            StringLiterals.Amplitude.Property.dateCourseNum: self.dateCourseNum
         ]
      )
   }
   
   func getTagIndices(from tags: [String]) -> [Int] {
      return tags.compactMap { tag in
         TendencyTag.allCases.firstIndex { $0.tag.english == tag }
      }
   }
   
   func fetchPastDate() {
      viewedDateCourseByMeData?.isSuccessGetData.bind { [weak self] isSuccess in
         guard let self = self else { return }
         if isSuccess == true {
            self.setLoading(isLoading: true)
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
               
               self.setLoading(isLoading: false)
               isSuccessGetData.value = true
            }
         }
      }
   }
   
   
   //MARK: - AddSchedule First 함수
   
   func satisfyDateName(str: String) {
      isDateNameVaild.value = str.count >= minimumDateNameLength
   }
   
   func isFutureDate(date: Date, dateType: String) {
      if dateType == "date" {
         let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: date)
         visitDate.value = formattedDate
         self.isVisitDateVaild.value = true
      } else {
         let formattedDate = DateFormatterManager.shared.timeFormatter.string(from: date)
         dateStartAt.value = formattedDate
         self.isDateStartAtVaild.value = !(dateStartAt.value?.isEmpty ?? true)
      }
   }
   
   func fetchTagData() {
      tagData = TendencyTag.allCases.map { $0.tag }
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
   
   
   //MARK: - AddSecondView 전용 func
   
   func updatePlaceCollectionView() {
      print(addPlaceCollectionViewDataSource)
   }
   
   func updateTimeRequireTextField(text: String) {
      if let doubleValue = Double(text) {
         let text = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(doubleValue)) : String(doubleValue)
      }
      timeRequire.value = "\(text) 시간"
   }
   
   func isAbleAddBtn() -> Bool {
      return !(datePlace.value?.isEmpty ?? true)
      && !(timeRequire.value?.isEmpty ?? true)
   }
   
   func tapAddBtn(datePlace: String, timeRequire: String) {
      addPlaceCollectionViewDataSource.append(AddCoursePlaceModel(placeTitle: datePlace, timeRequire: timeRequire))
      
      //viewmodel 값 초기화
      self.datePlace.value = ""
      self.timeRequire.value = ""
      self.dateDetailLocation = false
      self.dateDetailTime = false
      self.isChange?()
   }
   
   /// dataSource 개수 >= 2 라면 (다음 2/3) 버튼 활성화
   func isSourceMoreThanOne() {
      let cnt = addPlaceCollectionViewDataSource.count
      self.dateCourseNum = cnt
      let flag = (cnt >= 2)
      print("지금 데이터소스 개수 : \(addPlaceCollectionViewDataSource.count)\nflag: \(flag)")
      isValidOfSecondNextBtn.value = flag
   }
   
   /// 데이터 0개면 true 반환
   func isDataSourceNotEmpty() {
      let flag = (addPlaceCollectionViewDataSource.count >= 1) ? true : false
      editBtnEnableState.value = flag
   }
   
   /// 로딩뷰 세팅 함수
   func setLoading(isLoading: Bool) {
      self.onLoading.value = isLoading
   }
   
   func postAddScheduel() {
      self.setLoading(isLoading: true)
      
      var places: [PostAddSchedulePlace] = []
      
      for (index, model) in addPlaceCollectionViewDataSource.enumerated() {
         // Extract the numeric part from the timeRequire string
         let timeComponents = model.timeRequire.split(separator: " ")
         
         if let timeString = timeComponents.first {
            if let duration = Float(timeString) {
               let place = PostAddSchedulePlace(title: model.placeTitle, duration: duration, sequence: index)
               places.append(place)
               print("👍👍👍👍 : place added - \(place)")
            } else {
               print("❌❌❌ Step 1: Failed to convert timeString \(timeString) to Float")
            }
         } else {
            print("❌❌❌ Step 2: Failed to extract timeString from \(model.timeRequire)")
         }
      }
      print(addPlaceCollectionViewDataSource, "addPlaceCollectionViewDataSource : \(addPlaceCollectionViewDataSource)")
      print(places, "places : \(places)")
      
      guard let dateName = dateName.value else {return}
      guard let visitDate = visitDate.value else {return}
      guard let dateStartAt = dateStartAt.value else {return}
      let country = country
      let city = city
      let postAddScheduleTags = selectedTagData.map { PostAddScheduleTag(tag: $0) }
      
      NetworkService.shared.addScheduleService.postAddSchedule(course: PostAddScheduleRequest(
         title: dateName,
         date: visitDate,
         startAt: dateStartAt,
         tags: postAddScheduleTags,
         country: country,
         city: city,
         places: places)) { result in
            switch result {
            case .success(let response):
               self.setLoading(isLoading: false)
               self.isSuccessPostData.value = true
            case .reIssueJWT:
               self.patchReissue { isSuccess in
                  self.onReissueSuccess.value = isSuccess
               }
            default:
               self.onFailNetwork.value = true
               print("Failed to another reason")
               return
            }
         }
   }
   
}
