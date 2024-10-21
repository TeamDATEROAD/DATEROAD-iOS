//
//  PriceButtonCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

final class PriceButtonCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    var priceButton:  DRPriceButton
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        self.priceButton = DRPriceButton(tendencyType: "")
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.priceButton.setTitle(title, for: .normal)
    }
    
}

