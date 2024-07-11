//
//  CourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import Foundation

final class CourseViewModel {
    
    var priceData: [String] = []
    
    var courseData: [String] = []
    
    var countryData = LocationModel.countryData()
    
    var cityData = [LocationModel.City]()
    
    var selectedCountryIndex: Int? {
        didSet {
            updateCityData()
            selectedCityIndex = nil
            didUpdateSelectedCountryIndex?(selectedCountryIndex)
            updateApplyButtonState()
        }
    }
    
    var selectedCityIndex: Int? {
        didSet {
            didUpdateSelectedCityIndex?(selectedCityIndex)
            updateApplyButtonState()
        }
    }
    
    var isApplyButtonEnabled: Bool = false {
        didSet {
            didUpdateApplyButtonState?(isApplyButtonEnabled)
        }
    }
    
    var didUpdateCityData: (() -> Void)?
    
    var didUpdateSelectedCountryIndex: ((Int?) -> Void)?
    
    var didUpdateSelectedCityIndex: ((Int?) -> Void)?
    
    var didUpdateApplyButtonState: ((Bool) -> Void)?
    
    init() {
        fetchPriceData()
    }
    

    // MARK: - Methods
    
    private func updateCityData() {
        guard let selectedCountryIndex = selectedCountryIndex else { return }
        let selectedCountry = countryData[selectedCountryIndex]
        cityData = selectedCountry.cities
        didUpdateCityData?()
    }
    
    private func updateApplyButtonState() {
        isApplyButtonEnabled = selectedCityIndex != nil
    }
    
    func setupInitialSelection() {
        selectedCountryIndex = 0
    }
    
    
}

extension CourseViewModel {
    
    func fetchPriceData() {
        priceData = Price.allCases.map { $0.priceTitle }
    }
}
