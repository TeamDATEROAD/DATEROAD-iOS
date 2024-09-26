//
//  AddCourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

final class AddCourseViewModel: Serviceable {
   
   let onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
   
   let ispastDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
   var pastDateDetailData: DateDetailModel?
   
   var pastDatePlaces = [DatePlaceModel]()
   
   var selectedTagData: [String] = []
   
   var pastDateTagIndex = [Int]()
   
   
   //MARK: - AddFirstCourse 사용되는 ViewModel
   
   // ImageCollection 유효성 판별
   var pickedImageArr = [UIImage]()
   
   let isPickedImageVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
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
   
   // 코스 등록 태그
   var tagData: [ProfileTagModel] = []
   
   let isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
   
   let isValidTag: ObservablePattern<Bool> = ObservablePattern(nil)
   
   let tagCount: ObservablePattern<Int> = ObservablePattern(nil)
   
   private let minTagCnt = 1
   
   private let maxTagCnt = 3
   
   // 코스 지역 유효성 판별
   let dateLocations: ObservablePattern<String> = ObservablePattern(nil)
   
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
   
   
   //MARK: - AddThirdView 전용 Viewmodel 변수
   
   let contentTextCount: ObservablePattern<Int> = ObservablePattern(nil)
   
   var contentText = ""
   
   var contentFlag = false
   
   let priceText: ObservablePattern<Int> = ObservablePattern(nil)
   
   var priceFlag = false
   
   var price = 0
   
   let isDoneBtnOK: ObservablePattern<Bool> = ObservablePattern(false)
   
   var tags: [[String: Any]] = []
   
   let isSuccessPostData: ObservablePattern<Bool> = ObservablePattern(false)
   
   let onLoading: ObservablePattern<Bool> = ObservablePattern(nil)
   
   let onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
   
   
   //MARK: - AddCourse Amplitude 관련 변수
   
   var courseImage = false
   
   var courseTitle = false
   
   var courseDate = false
   
   var courseStartTime = false
   
   var courseTags = false
   
   var courseLocation = false
   
   var dateLocation = false
   
   var dateSpendTime = false
   
   var locationNum = 0
   
   var courseContentBool = false
   
   var courseContentNum = 0
   
   var courseCost = false
   
   
   // MARK: - Initializer
   
   init(pastDateDetailData: DateDetailModel? = nil) {
      initAmplitudeVar()
      fetchTagData()
      self.pastDateDetailData = pastDateDetailData
   }
   
}

extension AddCourseViewModel {
   
   func initAmplitudeVar() {
      courseImage = false
      courseTitle = false
      courseDate = false
      courseStartTime = false
      courseTags = false
      courseLocation = false
      dateLocation = false
      dateSpendTime = false
      locationNum = 0
      courseContentBool = false
      courseContentNum = 0
      courseCost = false
   }
   
   func course1BackAmplitude() {
      AmplitudeManager.shared.trackEventWithProperties(
         StringLiterals.Amplitude.EventName.clickCourse1Back,
         properties: [
            StringLiterals.Amplitude.Property.courseImage: self.courseImage,
            StringLiterals.Amplitude.Property.courseTitle: self.courseTitle,
            StringLiterals.Amplitude.Property.courseDate: self.courseDate,
            StringLiterals.Amplitude.Property.courseStartTime: self.courseStartTime,
            StringLiterals.Amplitude.Property.courseTags: self.courseTags,
            StringLiterals.Amplitude.Property.courseLocation: self.courseLocation
         ]
      )
   }
   
   func course2BackAmplitude() {
      AmplitudeManager.shared.trackEventWithProperties(
         StringLiterals.Amplitude.EventName.clickCourse2Back,
         properties: [
            StringLiterals.Amplitude.Property.dateLocation: self.dateLocation,
            StringLiterals.Amplitude.Property.dateSpendTime: self.dateSpendTime,
            StringLiterals.Amplitude.Property.locationNum: self.locationNum
         ]
      )
   }
   
   func course3BackAmplitude() {
      AmplitudeManager.shared.trackEventWithProperties(
         StringLiterals.Amplitude.EventName.clickCourse3Back,
         properties: [
            StringLiterals.Amplitude.Property.courseContentBool: self.courseContentBool,
            StringLiterals.Amplitude.Property.courseContentNum: self.courseContentNum,
            StringLiterals.Amplitude.Property.courseCost: self.courseCost
         ]
      )
   }
   
   func getTagIndices(from tags: [String]) -> [Int] {
      return tags.compactMap { tag in
         TendencyTag.allCases.firstIndex { $0.tag.english == tag }
      }
   }
   
   ///지난 데이트 코스 등록 데이터 바인딩 함수
   func fetchPastDate() {
      dateName.value = pastDateDetailData?.title
      guard let pastDateDetailDataDate = pastDateDetailData?.date else {return}
      guard let pastDate = DateFormatterManager.shared.convertToStandardFormat(from: pastDateDetailDataDate) else { return }
      let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: pastDate)
      visitDate.value = formattedDate
      
      dateStartAt.value = pastDateDetailData?.startAt
      dateLocations.value = pastDateDetailData?.city
      
      //동네.KOR 불러와서 지역, 동네 ENG 버전 알아내는 미친 로직
      let cityName = pastDateDetailData?.city ?? ""
      if let result = LocationMapper.getCountryAndCity(from: cityName) {
         let country = result.country.rawValue
         let city = result.city.rawValue
         self.city = city
         self.country = country
         self.isDateLocationVaild.value = true
      }
      
      //태그 추적해서 미리 셀렉 및 개수 표시 해버리는 진짜 미쳐버린 로직
      guard let tags = pastDateDetailData?.tags else {return}
      selectedTagData = tags.map { $0.tag }
      pastDateTagIndex = getTagIndices(from: selectedTagData)
      checkTagCount(min: minTagCnt, max: maxTagCnt)
      
      isDateNameVaild.value = true
      isVisitDateVaild.value = true
      isDateStartAtVaild.value = true
      isDateLocationVaild.value = true
      
      ///코스 등록 2 AddPlaceCollectionView 구성
      if let result = pastDateDetailData?.places {
         pastDatePlaces = result
      }
   }
   
   
   //MARK: - AddCourse FirstView 관련 함수
   
   func satisfyDateName(str: String) {
      isDateNameVaild.value = str.count >= minimumDateNameLength
   }
   
   func isFutureDate(date: Date, dateType: String) {
      if dateType == "date" {
         let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: date)
         visitDate.value = formattedDate
         let flag = DateFormatterManager.shared.isFutureDay(selecDateStr: formattedDate)
         self.isVisitDateVaild.value = flag
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
      let isPickedImageVaild = isPickedImageVaild.value ?? false
      let isDateNameVaild = isDateNameVaild.value ?? false
      let isValidTag = isValidTag.value ?? false
      let isVisitDateVaild = isVisitDateVaild.value ?? false
      let isDateStartAtVaild = isDateStartAtVaild.value ?? false
      let isDateLocationVaild = isDateLocationVaild.value ?? false
      
      for i in [isPickedImageVaild, isDateNameVaild, isValidTag, isVisitDateVaild, isDateLocationVaild, isDateStartAtVaild] {
         if i == false {
            print("\(i) == false")
            return false
         }
      }
      return true
   }
   
   
   //MARK: - AddCourse SecondView 관련 함수
   
   func updatePlaceCollectionView() {
      print(addPlaceCollectionViewDataSource)
   }
   
   func updateTimeRequireTextField(text: String) {
      var formattedText = text
      if let doubleValue = Double(text) {
         formattedText = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(doubleValue)) : String(doubleValue)
      }
      timeRequire.value = "\(formattedText) 시간"
   }
   
   func isAbleAddBtn() -> Bool {
      return !(datePlace.value?.isEmpty ?? true)
      && !(timeRequire.value?.isEmpty ?? true)
   }
   
   func tapAddBtn(datePlace: String, timeRequire: String) {
      print(datePlace, timeRequire)
      addPlaceCollectionViewDataSource.append(AddCoursePlaceModel(placeTitle: datePlace, timeRequire: timeRequire))
      
      //viewmodel 값 초기화
      self.datePlace.value = ""
      self.timeRequire.value = ""
      
      self.dateLocation = false
      self.dateSpendTime = false
      self.isChange?()
   }
   
   /// dataSource 개수 >= 2 라면 (다음 2/3) 버튼 활성화
   func isSourceMoreThanOne() {
      let cnt = addPlaceCollectionViewDataSource.count
      self.locationNum = cnt
      let flag = (cnt >= 2)
      print("지금 데이터소스 개수 : \(addPlaceCollectionViewDataSource.count)\nflag: \(flag)")
      isValidOfSecondNextBtn.value = flag
   }
   
   /// 데이터 0개면 true 반환
   func isDataSourceNotEmpty() {
      let flag = (addPlaceCollectionViewDataSource.count >= 1) ? true : false
      editBtnEnableState.value = flag
   }
   
   
   //MARK: - AddCourse ThirdView 관련 함수
   
   func isDoneBtnValid() {
      isDoneBtnOK.value = contentFlag && priceFlag
   }
   
   /// 로딩뷰 세팅 함수
   func setLoading(isPostLoading: Bool) {
      self.onLoading.value = isPostLoading
   }
   
   func postAddCourse() {
      self.setLoading(isPostLoading: true)
      
      var places: [[String: Any]] = []
      
      for (index, model) in addPlaceCollectionViewDataSource.enumerated() {
         // Extract the numeric part from the timeRequire string
         let timeComponents = model.timeRequire.split(separator: " ")
         
         if let timeString = timeComponents.first {
            if let duration = Float(timeString) {
               let place = PostAddCoursePlace(title: model.placeTitle, duration: duration, sequence: index + 1)
               places.append(place.toDictionary())
               print("👍👍👍👍 : place added - \(place)")
            } else {
               print("❌❌❌ : Failed to convert \(timeString) to Float")
            }
         } else {
            print("❌❌❌ : Failed to extract timeString from \(model.timeRequire)")
         }
      }
      
      var postAddCourseTag = PostAddCourseTag()
      
      postAddCourseTag.addTags(from: selectedTagData)
      
      
      guard let dateName = dateName.value else {return}
      guard let visitDate = visitDate.value else {return}
      guard let dateStartAt = dateStartAt.value else {return}
      let country = country
      let city = city
      let contentText = contentText
      let price = price
      let images = pickedImageArr
      let place = places
      
      NetworkService.shared.addCourseService.postAddCourse(course: PostAddCourse(title: dateName, date: visitDate, startAt: dateStartAt, country: country, city: city, description: contentText, cost: price).toDictionary(), tags: postAddCourseTag.tags, places: place, images: images)  { result in
         switch result {
         case .success(let response):
            print("Success: \(response)")
            self.setLoading(isPostLoading: false)
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
