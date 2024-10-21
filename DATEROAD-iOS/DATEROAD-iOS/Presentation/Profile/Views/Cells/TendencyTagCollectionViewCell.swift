//
//  TendencyTagCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class TendencyTagCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    var tendencyTagButton:  DRTagButton
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        self.tendencyTagButton = DRTagButton(tendencyType: "")
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.contentView.addSubview(tendencyTagButton)
    }
    
    override func setLayout() {
        tendencyTagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        tendencyTagButton.do {
            $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
        }
    }
    
    func updateButtonTitle(tag: ProfileTagModel) {
        self.tendencyTagButton.setTitle(" \(tag.tagTitle)", for: .normal)
        self.tendencyTagButton.setImage(tag.tagIcon, for: .normal)
    }
    
    func updateButtonTitle(title: String) {
        guard let tendencyTag = TendencyTag.getTag(byEnglish: title) else { return }
        tendencyTagButton.do {
            $0.setImage(tendencyTag.tag.tagIcon, for: .normal)
            $0.setTitle(" \(tendencyTag.tag.tagTitle)", for: .normal)
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
}
