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
    
    var selectedPriceIndex: Int? {
        didSet {
            didUpdateSelectedPriceIndex?(selectedPriceIndex)
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
    
    var didUpdateSelectedPriceIndex: ((Int?) -> Void)?
    
    var didUpdateApplyButtonState: ((Bool) -> Void)?
    
    init() {
        fetchPriceData()
        setupInitialSelection()
    }
    
    
    // MARK: - Methods
    func setupInitialSelection() {
        selectedCountryIndex = 0 // 초기 선택 설정
        selectedPriceIndex = 0 // 가격 초기 선택
    }
    
    
    func resetSelections() {
        selectedCountryIndex = nil
        selectedCityIndex = nil
        selectedPriceIndex = nil
        updateCityData()
    }
    
    private func updateCityData() {
        guard let selectedCountryIndex = selectedCountryIndex else {
            cityData.removeAll()
            didUpdateCityData?()
            return
        }
        let selectedCountry = countryData[selectedCountryIndex]
        cityData = selectedCountry.cities
        didUpdateCityData?()
    }
    
    private func updateApplyButtonState() {
        isApplyButtonEnabled = selectedCityIndex != nil
    }
    
    
    
}

extension CourseViewModel {
    
    func fetchPriceData() {
        priceData = Price.allCases.map { $0.priceTitle }
    }
}
