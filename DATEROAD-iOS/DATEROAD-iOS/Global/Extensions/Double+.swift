//
//  Double+.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation


extension Double {
    
    func formatTime() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(self)
        }
    }
    
}
