//
//  DRDateFormatterManager.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 8/26/24.
//

import UIKit

final class DateFormatterManager {
   
    static let shared = DateFormatterManager()
   
    private init() {}

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
   
   func isFutureDay(selecDateStr: String) -> Bool {
      let formatter = dateFormatter
      let today = Date()
      let selectedDate = formatter.date(from: selecDateStr)
      return (selectedDate ?? today) <= today
   }
   
   // Kor 날짜 문자열을 "yyyy.MM.dd"로 변환하는 함수
   func convertToStandardFormat(from dateString: String) -> Date? {
      let currentFormatter = DateFormatter()
      currentFormatter.locale = Locale(identifier: "ko_KR")
      currentFormatter.dateFormat = "yyyy년 M월 d일"
      
      return currentFormatter.date(from: dateString)
   }
   
}
