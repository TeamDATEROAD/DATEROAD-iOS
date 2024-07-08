//
//  LocationFilterViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class LocationFilterViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let dimmedView = UIView()
    
    private let bottomSheetView = UIView()
    
    private let titleLabel = UILabel()
    
    private let closeButton = UIButton()
    
    private let countryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let lineView = UIView()
    
    private let cityCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let applyButton = UIButton()
    
    // MARK: - Properties
    
    final let inset: CGFloat = 8
    
    private var locationData = LocationModel.countryData() {
        didSet {
            self.countryCollectionView.reloadData()
        }
    }
    private var selectedIndex: Int? {
        didSet {
            self.countryCollectionView.reloadData()
        }
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        register()
        setDelegate()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(
            dimmedView,
            bottomSheetView,
            titleLabel,
            closeButton,
            countryCollectionView,
            lineView,
            cityView,
            applyButton
        )
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView.snp.top)
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
        
        cityView.snp.makeConstraints {
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
        dimmedView.do {
            $0.alpha = 0.7
            $0.layer.backgroundColor = UIColor(resource: .drBlack).cgColor
            $0.isUserInteractionEnabled = true
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
        }
    }
    
    private func register() {
        countryCollectionView.register(
            CityLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: CityLabelCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
    }
}

extension LocationFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = ((screenWidth - 50) - ( inset * 2 )) / 3
        return CGSize(width: cellWidth, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension LocationFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityLabelCollectionViewCell.cellIdentifier, for: indexPath) as? CityLabelCollectionViewCell else {
            return UICollectionViewCell()
        }
        let location = locationData[indexPath.item]
        let isSelected = indexPath.item == selectedIndex
        cell.configure(with: location, isSelected: isSelected)
        return cell
    }
}

extension LocationFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
    }
}
