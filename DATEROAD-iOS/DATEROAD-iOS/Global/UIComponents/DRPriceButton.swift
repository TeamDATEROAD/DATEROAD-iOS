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

        setUnselectedTypeFontColor(UIColor(resource: .gray400))
        initTagButtonStyle(tagTitle: tendencyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Methods

extension DRPriceButton {
    
    func setUnselectedTypeFontColor(_ color: UIColor) {
            if var unselectedButton = unselectedType as? UnselectedButton {
                unselectedButton.fontColor = color
                unselectedType = unselectedButton
            }
        }
    
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
