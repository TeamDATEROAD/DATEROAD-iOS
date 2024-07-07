//
//  DRTagButton.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

class DRTagButton: UIButton {
    
    // MARK: - Properties
        
    private let selectedType: DRButtonType = SelectedButton()
    
    private let unselectedType: DRButtonType = UnselectedButton()
    
    
    // MARK: - Life Cycle
    
    init(tendencyType: String) {
        super.init(frame: .zero)
        
        initTagButtonStyle(tagTitle: tendencyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Methods

extension DRTagButton {
    
    func initTagButtonStyle(tagTitle: String) {
        self.do {
            $0.setTitle(tagTitle, for: .normal)
            $0.setButtonStatus(buttonType: unselectedType)
        }
    }
    
    func updateTagButtonStyle(isSelected: Bool) {
        if isSelected {
            self.setButtonStatus(buttonType: selectedType)
        } else {
            self.setButtonStatus(buttonType: unselectedType)
        }
    }
}
