//
//  LocationFilterViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

import SnapKit
import Then

protocol LocationFilterDelegate: AnyObject {
    func didSelectCity(_ country: LocationModel.Country,_ city: LocationModel.City)
    func getCourse()
}

class LocationFilterViewController: BaseViewController {
   
   // MARK: - UI Properties
   
    private let locationFilterView = LocationFilterView()
  
   
   // MARK: - Properties
   
   private let courseViewModel = CourseViewModel()
   
   weak var delegate: LocationFilterDelegate?
   
   final let countryInset: CGFloat = 8
   
   final let cityInset: CGFloat = 8
   
   // MARK: - Life Cycles
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      register()
      setDelegate()
      bindViewModel()
   }
   
   override func setHierarchy() {
       self.view.addSubview(locationFilterView)
   }
   
   override func setLayout() {
       locationFilterView.snp.makeConstraints {
           $0.edges.equalToSuperview()
       }
   }
   
   override func setStyle() {
      self.navigationController?.navigationBar.isHidden = true
      
   }
}

extension LocationFilterViewController: LocationFilterViewDelegate {
    
    func closeLocationFilterView() {
       if self.navigationController == nil {
          self.dismiss(animated: false)
       } else {
          self.navigationController?.popViewController(animated: false)
       }
    }
    
    func didTapApplyButton() {
        guard let selectedCountryIndex = courseViewModel.selectedCountryIndex.value,
              let selectedCityIndex = courseViewModel.selectedCityIndex.value else { return }
        
        let selectedCountry = courseViewModel.countryData[selectedCountryIndex]
        let selectedCity = courseViewModel.cityData[selectedCityIndex]
        
        let cityNameComponents = selectedCity.rawValue.split(separator: ".")
        let cityName = cityNameComponents.last.map { String($0) } ?? selectedCity.rawValue
        
        if let subRegion = SubRegion(rawValue: cityName) {
            let formattedCityName = "\(subRegion)"
            courseViewModel.selectedCityName.value = formattedCityName
        } else {
            print("💙")
        }
        
        delegate?.didSelectCity(selectedCountry, selectedCity)
        delegate?.getCourse()
        closeLocationFilterView()
    }
}

// MARK: - Private Methods

private extension LocationFilterViewController {
    
    private func bindViewModel() {
        courseViewModel.didUpdateCityData = { [weak self] in
            self?.locationFilterView.cityCollectionView.reloadData()
        }
        courseViewModel.didUpdateApplyButtonState = { [weak self] isEnabled in
            self?.updateApplyButtonState(isEnabled: isEnabled)
        }
        
        self.courseViewModel.selectedCountryIndex.bind { [weak self] index in
            self?.courseViewModel.updateCityData()
            self?.courseViewModel.selectedCityIndex.value = nil
            self?.courseViewModel.didUpdateSelectedCountryIndex?(index)
            self?.courseViewModel.updateApplyButtonState()
        }
        
        self.courseViewModel.selectedCityIndex.bind { [weak self] index in
            self?.courseViewModel.didUpdateSelectedCityIndex?(index)
            self?.courseViewModel.updateApplyButtonState()
        }
        
        self.courseViewModel.selectedCityName.bind { [weak self] cityName in
            self?.courseViewModel.didUpdateselectedCityName?(cityName)

            self?.courseViewModel.updateApplyButtonState()
        }
        self.courseViewModel.selectedPriceIndex.bind {[weak self] index in
            self?.courseViewModel.didUpdateSelectedPriceIndex?(index)
        }
        
        self.courseViewModel.isApplyButtonEnabled.bind {[weak self] isApply in
            self?.courseViewModel.didUpdateApplyButtonState?(isApply ?? false)
        }
        
    }
    
    private func updateApplyButtonState(isEnabled: Bool) {
        if isEnabled {
            locationFilterView.applyButton.setButtonStatus(buttonType: EnabledButton())
        } else {
            locationFilterView.applyButton.setButtonStatus(buttonType: DisabledButton())
        }
    }
    
    func register() {
        locationFilterView.countryCollectionView.register(
            CountryLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: CountryLabelCollectionViewCell.cellIdentifier)
        locationFilterView.cityCollectionView.register(
            CityLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: CityLabelCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        locationFilterView.delegate = self
        locationFilterView.countryCollectionView.delegate = self
        locationFilterView.countryCollectionView.dataSource = self
        locationFilterView.cityCollectionView.delegate = self
        locationFilterView.cityCollectionView.dataSource = self
    }
}

extension LocationFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        if collectionView == locationFilterView.countryCollectionView {
            let screenWidth = ScreenUtils.width
            cellWidth = ((screenWidth - 50) - ( countryInset * 2 )) / 3
            cellHeight = 33
        } else if collectionView == locationFilterView.cityCollectionView {
            let text = courseViewModel.cityData[indexPath.item].rawValue
            let font = UIFont.suit(.body_med_13)
            let textWidth = text.width(withConstrainedHeight: 30, font: font)
            cellWidth = textWidth + 28
            cellHeight = 30
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == locationFilterView.countryCollectionView ? 8 : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == locationFilterView.cityCollectionView ? 8 : 0
    }
    
}

extension LocationFilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == locationFilterView.countryCollectionView ? courseViewModel.countryData.count : courseViewModel.cityData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isCountryCollection = collectionView == locationFilterView.countryCollectionView
        let cellIdentifier = isCountryCollection ? CountryLabelCollectionViewCell.cellIdentifier : CityLabelCollectionViewCell.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if isCountryCollection, let countryCell = cell as? CountryLabelCollectionViewCell {
            let country = courseViewModel.countryData[indexPath.item]
            let isSelected = courseViewModel.selectedCountryIndex.value == indexPath.item
            countryCell.configure(with: country, isSelected: isSelected)
        } else if let cityCell = cell as? CityLabelCollectionViewCell {
            let city = courseViewModel.cityData[indexPath.item]
            let isSelected = courseViewModel.selectedCityIndex.value == indexPath.item
            cityCell.configure(with: city, isSelected: isSelected)
        }
        
        return cell
    }
}

extension LocationFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == locationFilterView.countryCollectionView {
            courseViewModel.selectedCountryIndex.value = indexPath.item
        } else if collectionView == locationFilterView.cityCollectionView {
            courseViewModel.selectedCityIndex.value = indexPath.item
        }
        
        collectionView.reloadData()
    }
}




