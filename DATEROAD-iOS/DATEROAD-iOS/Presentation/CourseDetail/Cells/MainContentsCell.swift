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
    
    let mainTextLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.systemMed13_black), numberOfLines: 3)
    
    
    // MARK: - Life Cycles
    
    override func setHierarchy() {
        self.addSubviews(mainTextLabel)
    }
    
    override func setLayout() {
        mainTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        mainTextLabel.do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2
            $0.attributedText = NSMutableAttributedString(string: "본문", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
    }
    
}

extension MainContentsCell {
    
    func setCell(mainContentsData: MainContentsModel) {
        mainTextLabel.text = mainContentsData.description
    }
    
}
