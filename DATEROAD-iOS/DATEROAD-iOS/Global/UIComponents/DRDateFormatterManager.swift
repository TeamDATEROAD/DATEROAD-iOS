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
   
}
