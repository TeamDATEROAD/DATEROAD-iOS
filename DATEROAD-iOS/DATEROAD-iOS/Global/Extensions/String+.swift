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
    
    
    
}
