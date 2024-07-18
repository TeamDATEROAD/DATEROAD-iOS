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
    
    var selectedCountryIndex: ObservablePattern<Int> = ObservablePattern(0)
    
    var selectedCityIndex: ObservablePattern<Int?>  = ObservablePattern(nil)
    
    var selectedCityName: ObservablePattern<String?>  = ObservablePattern(nil)
    
    var selectedPriceIndex: ObservablePattern<Int?> = ObservablePattern(0)
    
    var isApplyButtonEnabled: ObservablePattern<Bool> = ObservablePattern(false)
    
    var didUpdateCityData: (() -> Void)?
    
    var didUpdateselectedCityName: ((String?) -> Void)?
    
    var didUpdateSelectedCountryIndex: ((Int?) -> Void)?
    
    var didUpdateSelectedCityIndex: ((Int?) -> Void)?
    
    var didUpdateSelectedPriceIndex: ((Int?) -> Void)?
    
    var didUpdateApplyButtonState: ((Bool) -> Void)?
    
    init() {
        fetchPriceData()
    }
    
    func resetSelections() {
        selectedCountryIndex.value = 0
        selectedCityIndex.value = 0
        selectedPriceIndex.value = 0
        updateCityData()
    }

    
    func updateCityData() {
        guard let selectedCountryIndex = selectedCountryIndex.value else {
            cityData.removeAll()
            didUpdateCityData?()
            return
        }
        let selectedCountry = countryData[selectedCountryIndex]
        cityData = selectedCountry.cities
        didUpdateCityData?()
    }
    
    func updateApplyButtonState() {
        isApplyButtonEnabled.value = selectedCityIndex.value != nil
    }
 
    
}

extension CourseViewModel {
    
    func fetchPriceData() {
        priceData = Price.allCases.map { $0.priceTitle }
    }

}
