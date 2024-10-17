//
//  DRBottom.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/15/24.
//

import Foundation

protocol DRBottomSheetDelegate: AnyObject {
    
    func didTapBottomButton()
    
    func didTapFirstLabel()
    
    func didTapSecondLabel()
    
}

extension DRBottomSheetDelegate {
    
    func didTapBottomButton() {}
    
    func didTapFirstLabel() {}
    
    func didTapSecondLabel() {}
    
}
