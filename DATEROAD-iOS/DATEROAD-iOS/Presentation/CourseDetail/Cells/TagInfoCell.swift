//
//  HashTagCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/4/24.
//

import UIKit

import SnapKit
import Then


final class TagInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let hashTagLabel = UILabel()
    
    override func setHierarchy() {
        contentView.addSubview(hashTagLabel)
    }
    
    override func setLayout() {
        hashTagLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setStyle() {
        hashTagLabel.do {
            $0.text = "🚙 드라이브"
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        contentView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 15
        }
    }

}

extension TagInfoCell {
    func setCell(tag: String) {
        hashTagLabel.text = tag
    }
}

