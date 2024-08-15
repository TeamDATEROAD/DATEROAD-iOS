//
//  AddCourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

final class AddCourseViewModel: Serviceable {
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)

   var pastDateDetailData: DateDetailModel?
   var ispastDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
   var pastDatePlaces = [DatePlaceModel]()
   
   var selectedTagData: [String] = []
   
   var pastDateTagIndex = [Int]()
   //MARK: - AddFirstCourse 사용되는 ViewModel
   
   /// ImageCollection 유효성 판별
   var pickedImageArr = [UIImage]()
   var isPickedImageVaild: ObservablePattern<Bool> = ObservablePattern(false)
   
   /// 데이트 이름 유효성 판별 (true는 통과)
   var dateName: ObservablePattern<String> = ObservablePattern(nil)
   var isDateNameVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 방문 일자 유효성 판별 (true는 통과)
   var visitDate: ObservablePattern<String> = ObservablePattern(nil)
   var isVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 데이트 시작시간 유효성 판별 (self.count > 0 인지)
   var dateStartAt: ObservablePattern<String> = ObservablePattern(nil)
   var isDateStartAtVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 코스 등록 태그
   var tagData: [ProfileTagModel] = []
   var isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
   var isValidTag: ObservablePattern<Bool> = ObservablePattern(nil)
   var tagCount: ObservablePattern<Int> = ObservablePattern(0)
   
   /// 코스 지역 유효성 판별
   var dateLocation: ObservablePattern<String> = ObservablePattern("")
   var isDateLocationVaild: ObservablePattern<Bool> = ObservablePattern(nil)
   
   var isTimePicker: Bool?
   
   var country = ""
   var city = ""
   
   
   //MARK: - AddSecondView 전용 Viewmodel 변수
   
   var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
   
   var changeTableViewData: ObservablePattern<Int> = ObservablePattern(0)
   
   var datePlace: ObservablePattern<String> = ObservablePattern("")
   
   var timeRequire: ObservablePattern<String> = ObservablePattern("")
   
   var isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
   
   var editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
   
   var isChange: (() -> Void)?
   
   var isEditMode: Bool = false
   
   
   //MARK: - AddThirdView 전용 Viewmodel 변수
   
   var contentTextCount: ObservablePattern<Int> = ObservablePattern(0)
   var contentText = ""
   var contentFlag = false
   
   var priceText: ObservablePattern<Int> = ObservablePattern(nil)
   var priceFlag = false
   var price = 0
   
   var isDoneBtnOK: ObservablePattern<Bool> = ObservablePattern(false)
   
   var tags: [[String: Any]] = []
   
   init(pastDateDetailData: DateDetailModel? = nil) {
       fetchTagData()
      self.pastDateDetailData = pastDateDetailData
   }
}

extension AddCourseViewModel {
   
   func getTagIndices(from tags: [String]) -> [Int] {
       return tags.compactMap { tag in
           TendencyTag.allCases.firstIndex { $0.tag.english == tag }
       }
   }
   
   ///지난 데이트 코스 등록 데이터 바인딩 함수
   func fetchPastDate() {
      dateName.value = pastDateDetailData?.title
      visitDate.value = pastDateDetailData?.date
      dateStartAt.value = pastDateDetailData?.startAt
      dateLocation.value = pastDateDetailData?.city
      
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
      checkTagCount()
      
      isDateNameVaild.value = true
      isVisitDateVaild.value = true
      isDateStartAtVaild.value = true
      isDateLocationVaild.value = true
      
      ///코스 등록 2 AddPlaceCollectionView 구성
      if let result = pastDateDetailData?.places {
         pastDatePlaces = result
      }
      
   }
   
   //MARK: - AddCourse First 함수
   
   func satisfyDateName(str: String) {
      let flag = (str.count >= 5) ? true : false
      isDateNameVaild.value = flag
   }
   
   func isFutureDate(date: Date, dateType: String) {
      let dateFormatter = DateFormatter()
      
      if dateType == "date" {
         dateFormatter.dateFormat = "yyyy.MM.dd"
         
         let formattedDate = dateFormatter.string(from: date)
         visitDate.value = formattedDate
         
         let dateStr = visitDate.value ?? ""
         let today = Date()
         let selectedDate = dateFormatter.date(from: dateStr)
         
         // 현재 selectedDate가 미래 일자가 아니라면 true
         let flag = (selectedDate ?? today) <= today
         
         self.isVisitDateVaild.value = flag
      } else {
         dateFormatter.dateStyle = .none
         dateFormatter.timeStyle = .short
         dateFormatter.dateFormat = "hh:mm a"
         let formattedDate = dateFormatter.string(from: date)
         dateStartAt.value = formattedDate
         let flag = ((dateStartAt.value?.count ?? 0) > 0) ? true : false
         self.isDateStartAtVaild.value = flag
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
      print(datePlace, timeRequire)
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
   
   
   //MARK: - AddThirdView 전용 func
   
   func isDoneBtnValid() {
      if contentFlag && priceFlag {
         print("contentFlag : \(contentFlag)\npriceFlag : \(priceFlag)")
         isDoneBtnOK.value = true
      } else {
         isDoneBtnOK.value = false
      }
   }
   
   
   func postAddCourse() {
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
         case .reIssueJWT:
             self.onReissueSuccess.value = self.patchReissue()
         default:
            print("Failed to fetch user profile")
            return
         }
      }
   }
   
}
