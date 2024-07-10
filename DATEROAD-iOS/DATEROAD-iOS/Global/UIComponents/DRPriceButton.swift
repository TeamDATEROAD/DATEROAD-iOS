//
//  DRPriceButton.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

class DRPriceButton: UIButton {
    
    // MARK: - Properties
        
    private let selectedType: DRButtonType = SelectedButton()
    
    private var unselectedType: DRButtonType = UnselectedButton()
    
    
    
    // MARK: - Life Cycle
    
    init(tendencyType: String) {
        super.init(frame: .zero)
        
        initPriceButtonStyle(tagTitle: tendencyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Methods

extension DRPriceButton {
    
    func initPriceButtonStyle(tagTitle: String) {
        self.do {
            $0.setTitle(tagTitle, for: .normal)
            $0.setButtonStatus(buttonType: unselectedType)
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
        }
    }
}
