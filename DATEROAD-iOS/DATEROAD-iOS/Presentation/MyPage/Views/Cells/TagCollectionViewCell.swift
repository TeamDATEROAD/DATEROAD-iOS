//
//  TagCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class TagCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    var tagButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
     var tendencyTag:  DRButtonType = TagButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.contentView.addSubview(tagButton)
    }
    
    override func setLayout() {
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        tagButton.do {
            $0.setButtonStatus(buttonType: tendencyTag)
        }
    }

    func updateButtonTitle(title: String) {
        self.tagButton.setTitle(title, for: .normal)
    }
    
}

