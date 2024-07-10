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
   
//   var tagButtonsSet: Set<UIButton> = []
   
   var isError: (() -> Void)?
   
   var isNonError: (() -> Void)?
   
   
   //MARK: - AddSecondView 전용 Viewmodel
   
   var tableViewDataSource: [AddCoursePlaceModel] = []
   
   var changeTableViewData: ObservablePattern<Int> = ObservablePattern(0)
   
   init() {
      fetchTableViewData()
   }
   
}

extension AddCourseViewModel {
   
   func fetchTableViewData() {
      tableViewDataSource.append(contentsOf: [
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
   
//   func isTagBtnFull(sender: UIButton) -> Bool {
//      if let index = tagButtonsSet.firstIndex(of: sender) {
//         tagButtonsSet.remove(at: index)
//         return true
//      } else {
//         tagButtonsSet.insert(sender)
//         return false
//      }
//   }
   
//   func isTagBtnFull(sender: UIButton) -> Bool {
//      let flag = tagButtonsArr.count >= 3 ? true : false
//      if tagButtonsArr.contains(<#T##other: Collection##Collection#>)
//      // tagButtonArr의 개수가 3개라면
//      if flag {
//         
//      } else {
//         
//      }
//   }
   
//   func isPassSixCheckBtn() -> Bool {
//      guard let isImageEmpty = isImageEmpty.value,
//            let isDateNameValid = isDateNameValid.value,
//            let isVisitDateValid = isVisitDateValid.value,
//            let dateStartTime = dateStartTime.value,
//            let tagButtonsArr = tagButtonsArr
//      else {}
////      isImageEmpty.value ?? true ? (cnt+=1) : (cnt=0)
////      isDateNameValid.value ?? true ? (cnt+=1) : (cnt=0)
////      isVisitDateValid.value ?? true ? (cnt+=1) : (cnt=0)
////      (dateStartTime.value?.count ?? 0 > 0) ? (cnt+=1) : (cnt=0)
////      (tagButtonsArr.count != 0) ? (cnt+=1) : (cnt=0)
//      
//      return true
//   }
   
   func getSampleImages() -> Bool {
      var t = (1...9).map { _ in
         UIImage(resource: .test)
      }
      
      // 이미지 개수 대응 관련 코드
      for i in t {
         dataSource.append(i)
      }
      isImageEmpty.value = dataSource.isEmpty
      return isImageEmpty.value ?? true
   }
}
