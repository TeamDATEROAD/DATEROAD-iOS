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
    
    let dimmedView: DRDimmedView = DRDimmedView()

    let locationFilterView = LocationFilterView()
    
    
    // MARK: - Properties
    
    private let courseViewModel = CourseViewModel()
    
    weak var dimmedViewDelegate: DimmedViewDelegate?
    
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
        self.view.addSubviews(dimmedView, locationFilterView)
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationFilterView.snp.makeConstraints {
            $0.height.equalTo(469)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.locationFilterView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
    }
    
    func registerCell() {
        locationFilterView.countryCollectionView.register(CountryLabelCollectionViewCell.self, forCellWithReuseIdentifier: CountryLabelCollectionViewCell.cellIdentifier)
        locationFilterView.cityCollectionView.register(CityLabelCollectionViewCell.self, forCellWithReuseIdentifier: CityLabelCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        dimmedView.delegate = self
        locationFilterView.delegate = self
        locationFilterView.countryCollectionView.delegate = self
        locationFilterView.countryCollectionView.dataSource = self
        locationFilterView.cityCollectionView.delegate = self
        locationFilterView.cityCollectionView.dataSource = self
    }
    
    func bindViewModel() {
        self.courseViewModel.selectedCountryIndex.bind { [weak self] _ in
            self?.locationFilterView.countryCollectionView.reloadData()
            self?.courseViewModel.updateCityData()
            self?.courseViewModel.selectedCityIndex.value = nil
        }
        
        self.courseViewModel.selectedCityIndex.bind { [weak self] index in
            self?.locationFilterView.cityCollectionView.reloadData()
            self?.locationFilterView.updateApplyButtonProperties(index != nil)
        }
    }
    
    @objc
    func closeLocationFilterView() {
        self.dismissBottomSheet()
    }
    
}

extension LocationFilterViewController {
    
    func resetSelections() {
        courseViewModel.resetSelections()
        locationFilterView.countryCollectionView.reloadData()
        locationFilterView.cityCollectionView.reloadData()
    }
    
    func presentBottomSheet(in viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false) {
            self.animateBottomSheetPresentation(animated: animated, completion: completion)
        }
    }
    
    func dismissBottomSheet(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.locationFilterView.transform = CGAffineTransform(translationX: 0, y: 469)
                self.backgroundView.alpha = 0  // 배경을 페이드아웃
            }, completion: { _ in
                self.dismiss(animated: false, completion: completion)
            })
        } else {
            self.backgroundView.alpha = 0
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    private func animateBottomSheetPresentation(animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            self.locationFilterView.transform = CGAffineTransform(translationX: 0, y: 469)
            self.backgroundView.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backgroundView.alpha = 1
                self.locationFilterView.transform = .identity
            }, completion: { _ in
                completion?()
            })
        } else {
            self.backgroundView.alpha = 1
            completion?()
        }
    }
    
}

// MARK: - @objc Methods

extension LocationFilterViewController {
    
    @objc
    func didTapCountryButton(_ sender: DRTextButton) {
        courseViewModel.selectedCountryIndex.value = sender.tag
    }
    
    @objc
    func didTapCityButton(_ sender: DRTextButton) {
        courseViewModel.selectedCityIndex.value = sender.tag
    }
    
}

// MARK: - LocationFilterViewDelegate Methods

extension LocationFilterViewController: LocationFilterViewDelegate {
    
    func closeLocationFilterViewToDelegate() {
        self.dismissBottomSheet()
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
            countryCell.countryButton.tag = indexPath.item
            countryCell.countryButton.addTarget(self, action: #selector(didTapCountryButton(_:)), for: .touchUpInside)
            countryCell.updateCountryButtonProperties(with: country, isSelected: isSelected)
        } else if let cityCell = cell as? CityLabelCollectionViewCell {
            var city: LocationModel.City
            // "서울 전체"를 제외한 필터링된 데이터 사용
            if isAddType {
                let filteredCityData = courseViewModel.cityData.filter { $0.rawValue != "서울 전체" && $0.rawValue != "경기 전체" }
                city = filteredCityData[indexPath.item]
            } else {
                city = courseViewModel.cityData[indexPath.item]
            }
            
            let isSelected = courseViewModel.selectedCityIndex.value == indexPath.item
            cityCell.cityButton.tag = indexPath.item
            cityCell.cityButton.addTarget(self, action: #selector(didTapCityButton(_:)), for: .touchUpInside)
            cityCell.updateCityButtonProperties(with: city, isSelected: isSelected)
        }
        
        return cell
    }
    
}

extension LocationFilterViewController: UICollectionViewDelegate {}

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
