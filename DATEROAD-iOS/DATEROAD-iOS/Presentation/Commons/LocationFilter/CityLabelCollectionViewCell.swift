//
//  CityCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class CityLabelCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let grayBoxView = UIView()
    
    private let cityLabel = UILabel()
    
    // MARK: - Properties
    
    var itemRow: Int?
    
    override func setHierarchy() {
        self.addSubviews(grayBoxView, cityLabel)
    }
    
    override func setLayout() {
        grayBoxView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.center.equalTo(grayBoxView)
        }
    }
    
    override func setStyle() {
        grayBoxView.do {
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray100)
        }
        
        cityLabel.do {
            $0.text = "서울 전체"
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .gray400)
        }
    }
    
    
}

extension CityLabelCollectionViewCell {
    func configure(with city: LocationModel.City, isSelected: Bool) {
        cityLabel.text = city.rawValue
        updateSelectionState(isSelected)
    }
    // 선택했을 때 버튼 색 속성 변경
    func updateSelectionState(_ isSelected: Bool) {
        if isSelected {
            grayBoxView.backgroundColor = UIColor(resource: .deepPurple)
            cityLabel.textColor = UIColor(resource: .drWhite)
        } else  {
            grayBoxView.backgroundColor = UIColor(resource: .gray100)
            cityLabel.textColor = UIColor(resource: .gray400)
        }
    }
    
}

