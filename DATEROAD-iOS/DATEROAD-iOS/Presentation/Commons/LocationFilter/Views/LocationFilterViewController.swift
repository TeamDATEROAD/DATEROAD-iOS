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

final class LocationFilterViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let locationFilterView = LocationFilterView()
    
    
    // MARK: - Properties
    
    private let courseViewModel = CourseViewModel()
    
    weak var delegate: LocationFilterDelegate?
    
    final let countryInset: CGFloat = 8
    
    final let cityInset: CGFloat = 8
    
    final var isAddType: Bool = false
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
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
        self.view.backgroundColor = .clear
    }
    
    func registerCell() {
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
    
    func bindViewModel() {
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
    
}

// MARK: - Private Methods

private extension LocationFilterViewController {
    
    func updateApplyButtonState(isEnabled: Bool) {
        if isEnabled {
            locationFilterView.applyButton.setButtonStatus(buttonType: EnabledButton())
        } else {
            locationFilterView.applyButton.setButtonStatus(buttonType: DisabledButton())
        }
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
        var selectedCity = courseViewModel.cityData[selectedCityIndex]
        if selectedCountry.rawValue != "인천" {
            selectedCity = isAddType ? courseViewModel.cityData[selectedCityIndex+1] :
            courseViewModel.cityData[selectedCityIndex]
        }
        
        delegate?.didSelectCity(selectedCountry, selectedCity)
        delegate?.getCourse()
        closeLocationFilterView()
    }
    
}

extension LocationFilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == locationFilterView.cityCollectionView && isAddType {
            // "서울 전체"를 제외한 항목 수 반환
            return courseViewModel.cityData.filter { $0.rawValue != "서울 전체" && $0.rawValue != "경기 전체" }.count
        } else {
            return collectionView == locationFilterView.countryCollectionView ? courseViewModel.countryData.count : courseViewModel.cityData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = collectionView == locationFilterView.countryCollectionView ?
        CountryLabelCollectionViewCell.cellIdentifier :
        CityLabelCollectionViewCell.cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let countryCell = cell as? CountryLabelCollectionViewCell {
            let country = courseViewModel.countryData[indexPath.item]
            let isSelected = courseViewModel.selectedCountryIndex.value == indexPath.item
            countryCell.configure(with: country, isSelected: isSelected)
        } else if let cityCell = cell as? CityLabelCollectionViewCell {
            // "서울 전체"를 제외한 필터링된 데이터 사용
            if isAddType {
                let filteredCityData = courseViewModel.cityData.filter { $0.rawValue != "서울 전체" && $0.rawValue != "경기 전체" }
                let city = filteredCityData[indexPath.item]
                let isSelected = courseViewModel.selectedCityIndex.value == indexPath.item
                cityCell.configure(with: city, isSelected: isSelected)
            } else {
                let city = courseViewModel.cityData[indexPath.item]
                let isSelected = courseViewModel.selectedCityIndex.value == indexPath.item
                print(city.rawValue, "🔥🔥🔥")
                cityCell.configure(with: city, isSelected: isSelected)
            }
        }
        
        return cell
    }
    
}

extension LocationFilterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == locationFilterView.countryCollectionView {
            courseViewModel.selectedCountryIndex.value = indexPath.item
        } else {
            courseViewModel.selectedCityIndex.value = indexPath.item
        }
        
        collectionView.reloadData()
    }
    
}

extension LocationFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == locationFilterView.countryCollectionView {
            let screenWidth = ScreenUtils.width
            let cellWidth = ((screenWidth - 50) - ( countryInset * 2 )) / 3
            return CGSize(width: cellWidth, height: 33)
        } else {
            let font = UIFont.suit(.body_med_13)
            
            let cityData = isAddType
            ? courseViewModel.cityData.filter { $0.rawValue != "서울 전체" && $0.rawValue != "경기 전체" }
            : courseViewModel.cityData
            
            let text = cityData[indexPath.item].rawValue
            let textWidth = text.width(withConstrainedHeight: 30, font: font)
            
            return CGSize(width: textWidth + 28, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == locationFilterView.countryCollectionView ? 8 : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == locationFilterView.cityCollectionView ? 8 : 0
    }
    
}
