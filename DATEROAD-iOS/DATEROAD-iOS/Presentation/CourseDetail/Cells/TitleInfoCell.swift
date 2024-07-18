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
    
    private let titleLabel = UILabel()
    
    
    
    override func setHierarchy() {
        
        self.addSubview(titleLabel)
    }
    
    override func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
    }
    
    override func setStyle() {
        titleLabel.do {
            $0.text = "나랑 스껄 할래?"
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 2
        }

    }

}

extension TitleInfoCell {
    
    func setCell(titleHeaderData: TitleHeaderModel) {
        titleLabel.text = titleHeaderData.title
    }
}
