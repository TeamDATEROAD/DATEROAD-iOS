//
//  DRErrorLabel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/6/24.
//

import UIKit

class DRErrorLabel: UILabel {
    
    // MARK: - Properties
        
    private let warningType: DRErrorType = Warning()
    
    private let correctType: DRErrorType = Correct()
    
    
    // MARK: - Life Cycle
    
    init(errorType: String) {
        super.init(frame: .zero)
        
        initErrLabelStyle(title: errorType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Methods

extension DRErrorLabel {
    
    func initErrLabelStyle(title: String) {
        self.setErrorLabel(text: title, errorType: warningType)
    }
    
    func updateErrLabelStyle(title: String, isValid: Bool) {
        isValid ? self.setErrorLabel(text: title, errorType: warningType)
        : self.setErrorLabel(text: title, errorType: warningType)
    }

}


