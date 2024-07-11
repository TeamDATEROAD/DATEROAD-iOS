//
//  VisitDateView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

class VisitDateView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let dateLabel = UILabel()

    // MARK: - Properties
   
    
    func setHierarchy() {
        self.addSubview(dateLabel)
    }
    
    func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview()
        }
    }
    
    func setStyle() {
        dateLabel.do {
            $0.text = "2024년 6월 27일"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
    }
    
}
