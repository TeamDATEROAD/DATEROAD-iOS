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
    
    let cityButton = DRTextButton(title: "", buttonName: .med_gray100_10)
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(cityButton)
    }
    
    override func setLayout() {
        cityButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension CityLabelCollectionViewCell {
    
    func updateCityButtonProperties(with city: LocationModel.City, isSelected: Bool) {
        cityButton.setTitle(city.rawValue, for: .normal)
        cityButton.setButtonStyle(isSelected ? .med_purple_10 : .med_gray100_10)
    }
    
}

