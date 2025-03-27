//
//  MyPageTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class MyPageTableViewCell: BaseTableViewCell {
    
    // MARK: - UI Properties
    
    private let titleLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_black), alignment: .left)
    
    let rightArrowButton: DRImageButton = DRImageButton(image: UIImage(resource: .arrowRightLarge), buttonName: .white_gray400_0)
    
    
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
    
}

extension MyPageTableViewCell {
    
    func bindTitle(title: String) {
        self.titleLabel.text = title
    }
    
}
