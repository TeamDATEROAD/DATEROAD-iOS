//
//  AddCourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

enum AddCellType {
   case EmptyType, NotEmptyPType
}

final class AddCourseViewModel {
   
   var dataSource = [UIImage]()
   
   var cellType: ObservablePattern<AddCellType> = ObservablePattern(nil)
   
   var dateName: ObservablePattern<String> = ObservablePattern("")
   
   var visitDate: ObservablePattern<String> = ObservablePattern("")
   
   /// 데이트 시작시간 유효성 판별 (self.count > 0 인지)
   var dateStartTime: ObservablePattern<String> = ObservablePattern("")
   
   /// ImageCollection 유효성 판별
   var isImageEmpty: ObservablePattern<Bool> = ObservablePattern(true)
   
   /// 데이트 이름 유효성 판별 (true는 통과)
   var isDateNameValid: ObservablePattern<Bool> = ObservablePattern(nil)
   
//   var isDateNameError: ((Bool) -> Void)?
   
   var isVisitDateValid: ObservablePattern<Bool> = ObservablePattern(nil)
   
   var tagButtonsArr: [UIButton] = []
   
   var isError: (() -> Void)?
   
   var isNonError: (() -> Void)?
   
}

extension AddCourseViewModel {
   
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
