//
//  MainContentsCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/8/24.
//

import UIKit

import SnapKit
import Then


final class MainContentsCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let mainTextLabel = UILabel()
    
    override func setHierarchy() {
        self.addSubviews(mainTextLabel)
    }
    
    override func setLayout() {
        mainTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func setStyle() {
        mainTextLabel.do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2
            $0.attributedText = NSMutableAttributedString(string: "본문", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 0
        }
    }
    
}

extension MainContentsCell {
    
    func setCell(mainContentsData: MainContents) {
        mainTextLabel.text = mainContentsData.mainText
    }
}
