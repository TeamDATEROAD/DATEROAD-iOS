//
//  AddCourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

final class AddCourseViewModel {
   
   var dataSource = [UIImage]()
   
   var dateName: ObservablePattern<String> = ObservablePattern("")
   
   var visitDate: ObservablePattern<String> = ObservablePattern("")
   
   /// ImageCollection 유효성 판별
   var isImageEmpty: ObservablePattern<Bool> = ObservablePattern(false)
   
   /// 데이트 이름 유효성 판별 (true는 통과)
   var isDateNameValid: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 방문 일자 유효성 판별 (true는 통과)
   var isVisitDateValid: ObservablePattern<Bool> = ObservablePattern(nil)
   
   /// 데이트 시작시간 유효성 판별 (self.count > 0 인지)
   var dateStartTime: ObservablePattern<String> = ObservablePattern("")
   
   var isTagButtonValid: ObservablePattern<Bool> = ObservablePattern(false)
   
   /// 코스 등록하기 1 View 중 6개를 모두 통과하였는지 판별
   var isSixCheckPass: ObservablePattern<Int> = ObservablePattern(0)
   
   var tagCount: ObservablePattern<Int> = ObservablePattern(0)
   
   var cnt = 0
   
   var isError: (() -> Void)?
   
   var isNonError: (() -> Void)?
   
   var isChange: (() -> Void)?
   
   
   //MARK: - AddSecondView 전용 Viewmodel 변수
   
   var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
   
   var changeTableViewData: ObservablePattern<Int> = ObservablePattern(0)
   
   var datePlace: ObservablePattern<String> = ObservablePattern("")
   
   var timeRequire: ObservablePattern<String> = ObservablePattern("")
   
   var isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
   
   var editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
   
   //datePlace이 바뀌면 bind{} 파트에서 viewmodel안에 datePlace랑 timeRequire의 value.count 값을 비교해서 true false 반환토록하고, 이를  bind{} 바인드에 앞선 값들을 flag로 받고 이를 토대로 true false로 버튼 타입 바꿔줌
   var isEditMode: Bool = false
   
   
   //MARK: - AddThirdView 전용 Viewmodel 변수
   
   var contentTextCount: ObservablePattern<Int> = ObservablePattern(0)
   var contentFlag = false
   
   var priceText: ObservablePattern<Int> = ObservablePattern(nil)
   var priceFlag = false
   
   var isDoneBtnOK: ObservablePattern<Bool> = ObservablePattern(false)
   
}

extension AddCourseViewModel {
   
   func fetchTableViewData() {
      addPlaceCollectionViewDataSource.append(contentsOf: [
         AddCoursePlaceModel(placeTitle: "경북궁",timeRequire: "2시간"),
         AddCoursePlaceModel(placeTitle: "숭례문", timeRequire: "1시간"),
         AddCoursePlaceModel(placeTitle: "남대문", timeRequire: "3시간"),
         AddCoursePlaceModel(placeTitle: "문상훈", timeRequire: "30분"),
         AddCoursePlaceModel(placeTitle: "경북궁2",timeRequire: "2시간"),
         AddCoursePlaceModel(placeTitle: "숭례문2", timeRequire: "1시간"),
         AddCoursePlaceModel(placeTitle: "남대문2", timeRequire: "3시간"),
         AddCoursePlaceModel(placeTitle: "문상훈2", timeRequire: "30분")
      ])
   }
   
   func isFutureDate(date: Date, dateType: String) {
      if dateType == "date" {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy. MM. dd."
         
         let formattedDate = dateFormatter.string(from: date)
         visitDate.value = formattedDate
         
         let dateStr = visitDate.value ?? ""
         dateFormatter.dateFormat = "yyyy. MM. dd."
         
         let today = Date()
         let selectedDate = dateFormatter.date(from: dateStr)
         
         // 현재 selectedDate가 미래 일자가 아니라면 true
         let flag = (selectedDate ?? today) <= today
         
         self.isVisitDateValid.value = flag
      } else {
         let dateformatter = DateFormatter()
         dateformatter.dateStyle = .none
         dateformatter.timeStyle = .short
         let formattedDate = dateformatter.string(from: date)
         dateStartTime.value = formattedDate
      }
   }
   
   func isDateNameValid(cnt: Int) {
      let flag = cnt >= 5
      isDateNameValid.value = flag
   }
   
   func countSelectedTag(isSelected: Bool) {
      guard let oldCount = tagCount.value else { return }
      
      if isSelected {
         tagCount.value = oldCount + 1
      } else {
         if oldCount != 0 {
            tagCount.value = oldCount - 1
         }
      }
      
      checkTagCount()
   }
   
   func checkTagCount() {
      guard let count = tagCount.value else { return }
      
      if count >= 1 && count <= 3 {
         self.isTagButtonValid.value = true
      } else {
         self.isTagButtonValid.value = false
      }
      print(count)
   }
   
   func getSampleImages() -> Bool {
      let t = (1...9).map { _ in
         UIImage(resource: .test)
      }
      
      // 이미지 개수 대응 관련 코드
      for i in t {
         dataSource.append(i)
      }
      isImageEmpty.value = dataSource.isEmpty
      return isImageEmpty.value ?? true
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
         print("아직 안돼~")
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
   
   func isContentValid(cnt: Int) {
      let flag = (cnt >= 200) ? true : false
      contentFlag = flag
      isDoneBtnValid()
   }
   
   func isPriceValid() {
      let flag = (priceText.value ?? 0 > 0) ? true : false
      priceFlag = flag
      isDoneBtnValid()
   }
   
   func isDoneBtnValid() {
      if contentFlag && priceFlag {
         print("contentFlag : \(contentFlag)\npriceFlag : \(priceFlag)")
         isDoneBtnOK.value = true
      } else {
         isDoneBtnOK.value = false
      }
   }
   
}
