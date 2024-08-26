//
//  AddScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

final class AddScheduleViewModel: Serviceable {
   var isImporting = false
   var viewedDateCourseByMeData: CourseDetailViewModel?
   var ispastDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
   var pastDatePlaces = [TimelineModel]()
   
   var selectedTagData: [String] = []
   
   var pastDateTagIndex = [Int]()
   
   //MARK: - AddFirstCourse 사용되는 ViewModel
   
   /// 데이트 이름 유효성 판별 (true는 통과)
   var dateName: ObservablePattern<String> = ObservablePattern("")
   var isDateNameVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 방문 일자 유효성 판별 (true는 통과)
   var visitDate: ObservablePattern<String> = ObservablePattern(nil)
   var isVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 데이트 시작시간 유효성 판별 (self.count > 0 인지)
   var dateStartAt: ObservablePattern<String> = ObservablePattern(nil)
   var isDateStartAtVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 코스 등록 태그 생성
   var tagData: [ProfileTagModel] = []
   
   // 선택된 태그
   var isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
   var isValidTag: ObservablePattern<Bool> = ObservablePattern(nil)
   var tagCount: ObservablePattern<Int> = ObservablePattern(0)
   
   /// 코스 지역 유효성 판별
   var dateLocation: ObservablePattern<String> = ObservablePattern("")
   var isDateLocationVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   var country = ""
   var city = ""
   
   var isTimePicker: Bool?
   
   
   //MARK: - AddSecondView 전용 Viewmodel 변수
   
   var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
   
   var changeTableViewData: ObservablePattern<Int> = ObservablePattern(0)
   
   var datePlace: ObservablePattern<String> = ObservablePattern("")
   
   var timeRequire: ObservablePattern<String> = ObservablePattern("")
   
   var isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
   
   var editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
   
   var isChange: (() -> Void)?
   
   var isEditMode: Bool = false
   
   var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
   
   
   init() {
      fetchTagData()
   }
}

extension AddScheduleViewModel {
   
   func getTagIndices(from tags: [String]) -> [Int] {
      return tags.compactMap { tag in
         TendencyTag.allCases.firstIndex { $0.tag.english == tag }
      }
   }
   
   func fetchPastDate(completion: @escaping () -> Void) {
      viewedDateCourseByMeData?.isSuccessGetData.bind { [weak self] isSuccess in
         guard let self = self else { return }
         if isSuccess == true {
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
               
               checkTagCount()
               
               isDateNameVaild.value = true
               isDateStartAtVaild.value = true
               isDateLocationVaild.value = true
               
               ///코스 등록 2 AddPlaceCollectionView 구성
               
               if let result = data.timelineData.value {
                  pastDatePlaces = result
               }
               
               completion() // 데이터 로딩이 완료된 후 호출
            }
         } else {
            print("Failed to load course details")
            completion() // 실패한 경우에도 호출
         }
      }
   }
   
   
   
   //MARK: - AddSchedule First 함수
   
   func satisfyDateName(str: String) {
      let flag = (str.count >= 5) ? true : false
      isDateNameVaild.value = flag
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
      
      checkTagCount()
   }
   
   
   func checkTagCount() {
      let count = selectedTagData.count
      self.tagCount.value = count
      
      if count >= 1 && count <= 3 {
         self.isValidTag.value = true
         self.isOverCount.value = false
      } else {
         self.isValidTag.value = false
         if count > 3 {
            self.isOverCount.value = true
         }
      }
      print(count)
   }
   
   func satisfyDateLocation(str: String) {
      let flag = (str.count > 0) ? true : false
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
         let text = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ?
         String(Int(doubleValue)) : String(doubleValue)
         timeRequire.value = "\(text) 시간"
      } else {
         timeRequire.value = "\(text) 시간"
      }
   }
   
   func isAbleAddBtn() -> Bool {
      if (datePlace.value?.count != 0) && (timeRequire.value?.count != 0) {
         return true
      } else {
         return false
      }
   }
   
   func tapAddBtn(datePlace: String, timeRequire: String) {
      addPlaceCollectionViewDataSource.append(AddCoursePlaceModel(placeTitle: datePlace, timeRequire: timeRequire))
      
      //viewmodel 값 초기화
      self.datePlace.value = ""
      self.timeRequire.value = ""
      self.isChange?()
   }
   
   /// dataSource 개수 >= 2 라면 (다음 2/3) 버튼 활성화
   func isSourceMoreThanOne() {
      let flag = (addPlaceCollectionViewDataSource.count >= 2) ? true : false
      print("지금 데이터소스 개수 : \(addPlaceCollectionViewDataSource.count)\nflag: \(flag)")
      isValidOfSecondNextBtn.value = flag
   }
   
   /// 데이터 0개면 true 반환
   func isDataSourceNotEmpty() {
      let flag = (addPlaceCollectionViewDataSource.count >= 1) ? true : false
      editBtnEnableState.value = flag
   }
   
   func postAddScheduel() {
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
               print("Success: \(response)")
            case .reIssueJWT:
               self.onReissueSuccess.value = self.patchReissue()
            default:
               print("Failed to fetch user profile")
               return
            }
         }
   }
   
}
