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
    func didSelectLocation(country: LocationModel.Country, city: LocationModel.City)
}

class LocationFilterViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let dimmedView = UIView()
    
    private let bottomSheetView = UIView()
    
    private let titleLabel = UILabel()
    
    private let closeButton = UIButton()
    
    private let countryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let lineView = UIView()
    
    private let cityCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
    
    private let applyButton = UIButton()
    
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
        self.view.addSubviews(dimmedView, bottomSheetView)
        
        bottomSheetView.addSubviews(
            titleLabel,
            closeButton,
            countryCollectionView,
            lineView,
            cityCollectionView,
            applyButton
        )
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView)
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(469)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView).inset(23)
            $0.leading.equalToSuperview().inset(25)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView).inset(15)
            $0.trailing.equalTo(bottomSheetView).inset(12)
            $0.width.height.equalTo(40)
        }
        
        countryCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(33)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(countryCollectionView.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(26)
            $0.height.equalTo(1)
        }
        
        cityCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(22)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(194)
        }
        
        applyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        
        dimmedView.do {
            $0.alpha = 0.7
            $0.layer.backgroundColor = UIColor(resource: .drBlack).cgColor
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
        
        bottomSheetView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        titleLabel.do {
            $0.text = "지역을 선택해주세요"
            $0.font = UIFont.suit(.title_bold_18)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        closeButton.do {
            $0.setImage(UIImage(resource: .btnClose), for: .normal)
            $0.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        }
        
        lineView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
        }
        
        applyButton.do {
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.setTitle("적용하기", for: .normal)
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
            
        }
        
    }
    
    @objc
    func closeView() {
        if self.navigationController == nil {
            self.dismiss(animated: false)
        } else {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @objc
    func didTapDimmedView(sender: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
    
   @objc
   func applyButtonTapped() {
       guard let selectedCountryIndex = courseViewModel.selectedCountryIndex.value,
             let selectedCityIndex = courseViewModel.selectedCityIndex.value else { return }
       
       let selectedCountry = courseViewModel.countryData[selectedCountryIndex]
       let selectedCity = courseViewModel.cityData[selectedCityIndex]
       
       delegate?.didSelectLocation(country: selectedCountry, city: selectedCity)
       closeView()
   }
    
    
}

// MARK: - Private Methods

private extension LocationFilterViewController {
    
    private func bindViewModel() {
        courseViewModel.didUpdateCityData = { [weak self] in
            self?.cityCollectionView.reloadData()
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
        
        self.courseViewModel.selectedPriceIndex.bind {[weak self] index in
            self?.courseViewModel.didUpdateSelectedPriceIndex?(index)
        }
        
        self.courseViewModel.isApplyButtonEnabled.bind {[weak self] isApply in
            self?.courseViewModel.didUpdateApplyButtonState?(isApply ?? false)
        }
        
    }
    
    private func updateApplyButtonState(isEnabled: Bool) {
        if isEnabled {
            applyButton.setButtonStatus(buttonType: EnabledButton())
        } else {
            applyButton.setButtonStatus(buttonType: DisabledButton())
        }
    }
    
    func register() {
        countryCollectionView.register(
            CountryLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: CountryLabelCollectionViewCell.cellIdentifier)
        cityCollectionView.register(
            CityLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: CityLabelCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
    }
}

extension LocationFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        if collectionView == countryCollectionView {
            let screenWidth = ScreenUtils.width
            cellWidth = ((screenWidth - 50) - ( countryInset * 2 )) / 3
            cellHeight = 33
        } else if collectionView == cityCollectionView {
            let text = courseViewModel.cityData[indexPath.item].rawValue
            let font = UIFont.suit(.body_med_13)
            let textWidth = text.width(withConstrainedHeight: 30, font: font)
            cellWidth = textWidth + 28
            cellHeight = 30
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == countryCollectionView ? 8 : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == cityCollectionView ? 8 : 0
    }
    
}

extension LocationFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionView == countryCollectionView ? courseViewModel.countryData.count : courseViewModel.cityData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let isCountryCollection = collectionView == countryCollectionView
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
        
        if collectionView == countryCollectionView {
            courseViewModel.selectedCountryIndex.value = indexPath.item
        } else if collectionView == cityCollectionView {
            courseViewModel.selectedCityIndex.value = indexPath.item
        }
        
        collectionView.reloadData()
    }
}




