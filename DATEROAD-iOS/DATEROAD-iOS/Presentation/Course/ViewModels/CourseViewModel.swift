//
//  CourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import Foundation

final class CourseViewModel: Serviceable {
    
    var priceData: [String] = []
    
    var courseData: [String] = []
    
    var courseListModel: [CourseListModel] = []
    
    var countryData = LocationModel.countryData()
    
    var cityData = [LocationModel.City]()
    
    var selectedCountryIndex: ObservablePattern<Int> = ObservablePattern(0)
    
    var selectedCityIndex: ObservablePattern<Int>  = ObservablePattern(nil)
    
    var selectedCityName: ObservablePattern<String>  = ObservablePattern(nil)
    
    var selectedPriceIndex: ObservablePattern<Int> = ObservablePattern(nil)
    
    var isApplyButtonEnabled: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isSuccessGetData: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(true)
        
    var didUpdateCourseList: (() -> Void)?
    
    func resetSelections() {
        selectedCountryIndex.value = 0
        selectedCityName.value = nil
        selectedCityIndex.value = nil
        selectedPriceIndex.value = nil
        updateCityData()
    }
    
    func updateCityData() {
        guard let selectedCountryIndex = selectedCountryIndex.value else { return }
        let selectedCountry = countryData[selectedCountryIndex]
        cityData = selectedCountry.cities
    }
    
    func updateApplyButtonState() {
        isApplyButtonEnabled.value = selectedCityIndex.value != nil
    }
    
}

extension CourseViewModel {
    
    func fetchPriceData() {
        priceData = Price.allCases.map { $0.priceTitle }
    }
    
    func getCourse() {
        let city = selectedCityName.value ?? ""
        let cost = selectedPriceIndex.value?.costNum()
        
        self.isSuccessGetData.value = false
        self.setLoading()
        
        NetworkService.shared.courseService.getCourseInfo(city: city, cost: cost) { response in
            switch response {
            case .success(let data):
                let courseModels = data.courses.map { filterList in
                    CourseListModel(
                        courseId: filterList.courseID,
                        thumbnail: filterList.thumbnail,
                        location: filterList.city,
                        title: filterList.title,
                        cost: filterList.cost,
                        time: filterList.duration,
                        like: filterList.like
                    )
                }
                self.courseListModel = courseModels
                self.didUpdateCourseList?()
                self.isSuccessGetData.value = true
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                self.onFailNetwork.value = true
                print("Failed to fetch course data")
            }
        }
    }
    
    func setLoading() {
        guard let isSuccessGetData = self.isSuccessGetData.value else { return }
        self.onLoading.value = !isSuccessGetData
    }
    
}
