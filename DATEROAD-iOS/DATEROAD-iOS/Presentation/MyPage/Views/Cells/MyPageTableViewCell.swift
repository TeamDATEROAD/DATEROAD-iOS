//
//  MyPageTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class MyPageTableViewCell: BaseTableViewCell {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = UILabel()
    
    let rightArrowButton: UIButton = UIButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel, rightArrowButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightArrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(23)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setStyle() {
        titleLabel.do {
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_semi_15))
        }
        
        rightArrowButton.do {
            $0.setImage(UIImage(resource: .arrowRightLarge), for: .normal)
        }
    }
    
}

extension MyPageTableViewCell {
    
    func bindTitle(title: String) {
        self.titleLabel.text = title
    }
    
}
