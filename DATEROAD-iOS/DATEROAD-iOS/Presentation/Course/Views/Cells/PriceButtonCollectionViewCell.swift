//
//  PriceButtonCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

final class PriceButtonCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let priceButton: DRTextButton = DRTextButton(title: "", buttonName: .med_gray100_15)
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.contentView.addSubview(priceButton)
    }
    
    override func setLayout() {
        priceButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func updateButtonTitle(title: String) {
        priceButton.setTitle(title, for: .normal)
    }
    
}

