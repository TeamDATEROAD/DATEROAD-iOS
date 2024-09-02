//
//  UITextVIew+.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 9/2/24.
//

import UIKit

extension UITextView {
   
   func setFontAndLineLetterSpacing(_ text: String, font: UIFont) {
      let style = NSMutableParagraphStyle()
      
      // 폰트 크기의 50%를 lineSpacing으로 설정
      style.lineSpacing = font.pointSize * 0.5
      
      // 자간, 행간, 폰트 설정
      let attributedString = NSMutableAttributedString(
         string: text,
         attributes: [
            .kern: CGFloat(0),  // 자간
            .paragraphStyle: style,  // 행간
            .font: font  // 폰트
         ]
      )
      
      self.attributedText = attributedString
   }
   
}

