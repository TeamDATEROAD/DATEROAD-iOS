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
    
    var tendencyTag:  DRButtonType = TendencyTagButton()
    
    
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
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
        }
    }
    
    func updateButtonTitle(title: String) {
        guard let tendencyTag = TendencyTag.getTag(byEnglish: title) else { return }
        tagButton.do {
            $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
            $0.setImage(tendencyTag.tag.tagIcon, for: .normal)
            $0.setTitle(tendencyTag.tag.tagTitle, for: .normal)
        }
        //        self.tagButton.setTitle(title, for: .normal)
    }
    
}

