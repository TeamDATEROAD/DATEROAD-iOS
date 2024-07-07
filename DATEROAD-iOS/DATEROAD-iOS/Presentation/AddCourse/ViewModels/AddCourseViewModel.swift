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
   
   var dataSource = getSampleImages()
   
   var cellType: ObservablePattern<AddCellType> = ObservablePattern(nil)
   
   var dateName: ObservablePattern<String> = ObservablePattern("")
   
   var visitDate: ObservablePattern<String> = ObservablePattern("")
   
   var dateStartTime: ObservablePattern<String> = ObservablePattern("")
   
   var isDateNameError: ((Bool) -> Void)?
   
   var isVisitDateError: ((Bool) -> Void)?
   
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
         
         let flag = (selectedDate ?? today) > today
         
         self.isVisitDateError?(flag)
      } else {
         let dateformatter = DateFormatter()
         dateformatter.dateStyle = .none
         dateformatter.timeStyle = .short
         let formattedDate = dateformatter.string(from: date)
         dateStartTime.value = formattedDate
      }
   }
   
   func isDateNameValid(cnt: Int) {
      let flag = cnt < 5
      isDateNameError?(flag)
   }
   
}
