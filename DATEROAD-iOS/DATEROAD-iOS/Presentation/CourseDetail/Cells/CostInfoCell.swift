//
//  CoastInfoCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class CostInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let timelineBackgroundView = UIView()
    
    private let costLabel = UILabel()

    override func setHierarchy() {
        self.addSubviews(timelineBackgroundView, costLabel)
    }
    
    override func setLayout() {
        timelineBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(timelineBackgroundView)
        }
    }
    
    override func setStyle() {
        timelineBackgroundView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 14
        }
        
        costLabel.do {
            $0.text = "90,000원"
            $0.font = UIFont.suit(.body_bold_15)
            $0.textColor = UIColor(resource: .drBlack)
        }
    }
}

extension CostInfoCell {
    
    func setCell(costData: Int) {
        if costData == 0 {
            costLabel.text = StringLiterals.CourseDetail.priceLabelZero
        } else {
            costLabel.text = "\(costData.formattedWithSeparator)원"
        }
    }
    
}

