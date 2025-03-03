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
        
    let countryButton = DRTextButton(title: "", buttonName: .semi_gray100_10)
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(countryButton)
    }
    
    override func setLayout() {
        countryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension CountryLabelCollectionViewCell {
    
    func updateCountryButtonProperties(with country: LocationModel.Country, isSelected: Bool) {
        countryButton.setTitle(country.rawValue, for: .normal)
        countryButton.setButtonStyle(isSelected ? .semi_purple_10: .semi_gray100_10)
    }
    
}
