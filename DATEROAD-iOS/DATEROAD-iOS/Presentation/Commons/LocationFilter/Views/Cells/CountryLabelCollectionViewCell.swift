//
//  CityLabelCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class CountryLabelCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let grayBoxView = UIView()
    
    private let countryLabel = UILabel()
    
    
    // MARK: - Properties
    
    var itemRow: Int?
    
    override func setHierarchy() {
        self.addSubviews(grayBoxView, countryLabel)
    }
    
    override func setLayout() {
        grayBoxView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        countryLabel.snp.makeConstraints {
            $0.center.equalTo(grayBoxView)
        }
    }
    
    override func setStyle() {
        grayBoxView.do {
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray100)
        }
        
        countryLabel.do {
            $0.text = "서울"
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .gray400)
        }
    }
    
    
    func updateSelectionState(_ isSelected: Bool) {
        print(isSelected)
        if isSelected {
            grayBoxView.backgroundColor = UIColor(resource: .deepPurple)
            countryLabel.textColor = UIColor(resource: .drWhite)
        } else {
            grayBoxView.backgroundColor = UIColor(resource: .gray100)
            countryLabel.textColor = UIColor(resource: .gray400)
        }
    }
    
}

extension CountryLabelCollectionViewCell {
    
    func configure(with country: LocationModel.Country, isSelected: Bool) {
        countryLabel.text = country.rawValue
        updateSelectionState(isSelected)
    }
    
}
