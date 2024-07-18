//
//  String+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

extension String {
    
    // 텍스트의 너비를 계산하는 확장 함수
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    //숫자로 된 날짜를 년/월/일로 변환해주는 함수
    
    func formatDateFromString(inputFormat: String, outputFormat: String) -> String? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = inputFormat
         guard let date = dateFormatter.date(from: self) else {
             return nil
         }
         
         dateFormatter.dateFormat = outputFormat
         let formattedDate = dateFormatter.string(from: date)
         return formattedDate
     }
    
    // 2023.07.18 -> JULY 18 함수
    func toReadableDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateFormat = "MMMM dd"
        readableDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return readableDateFormatter.string(from: date).uppercased()
    }
    
}
