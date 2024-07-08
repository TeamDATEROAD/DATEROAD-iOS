//
//  CoastInfoCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class CoastInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let coastLabel = UILabel()
    
    // MARK: - Properties
    
    static let identifier: String = "CoastInfoCell"
    
    override func setHierarchy() {
        self.addSubviews(timelineBackgroundView, coastLabel)
    }
    
    override func setLayout() {
        timelineBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        coastLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(timelineBackgroundView)
        }
    }
    
    override func setStyle() {
        timelineBackgroundView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 14
        }
        
        coastLabel.do {
            $0.text = "90,000원"
            $0.font = UIFont.suit(.body_bold_15)
            $0.textColor = UIColor(resource: .drBlack)
        }
    }
}

extension CoastInfoCell {
    
    func setCell(coastData: Int) {
        coastLabel.text = "\(coastData.formattedWithSeparator)원"
    }
    
}

