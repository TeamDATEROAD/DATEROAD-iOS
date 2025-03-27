//
//  MainContentsCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then

final class TitleInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let titleLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold24_black),
        alignment: .left,
        numberOfLines: 2
    )
    
    
    // MARK: - Life Cycles
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
}

extension TitleInfoCell {
    
    func setCell(titleHeaderData: TitleHeaderModel) {
        titleLabel.text = titleHeaderData.title
    }
    
    func bindBannerTitle(title: String) {
        titleLabel.text = title
    }
    
}
