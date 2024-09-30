//
//  LocationFilterView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 8/11/24.
//

import UIKit

import SnapKit
import Then

protocol LocationFilterViewDelegate: AnyObject {
    func closeLocationFilterView()
    func didTapApplyButton()
}

final class LocationFilterView: BaseView {
    
    // MARK: - UI Properties
    
    private let dimmedView = UIView()
    
    private let bottomSheetView = UIView()
    
    private let titleLabel = UILabel()
    
    private let closeButton = UIButton()
    
    let countryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let lineView = UIView()
    
    let cityCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
    
    let applyButton = UIButton()
    
    
    // MARK: - UI Properties
    
    weak var delegate: LocationFilterViewDelegate?
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(dimmedView, bottomSheetView)
        
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
            $0.top.horizontalEdges.equalToSuperview()
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
            $0.size.equalTo(40)
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
        cityCollectionView.do {
            $0.showsVerticalScrollIndicator = false
        }
        
        dimmedView.do {
            $0.alpha = 0.7
            $0.layer.backgroundColor = UIColor(resource: .drBlack).cgColor
            let gesture = UITapGestureRecognizer(target: self, action: #selector(closeLocationFilterView))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
        
        bottomSheetView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        titleLabel.do {
            $0.setLabel(text:StringLiterals.LocationFilter.title,textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_bold_18))
        }
        
        closeButton.do {
            $0.setImage(UIImage(resource: .btnClose), for: .normal)
            $0.addTarget(self, action: #selector(closeLocationFilterView), for: .touchUpInside)
        }
        
        lineView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
        }
        
        applyButton.do {
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.setTitle(StringLiterals.LocationFilter.apply, for: .normal)
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
        }
    }
    
    @objc
    func closeLocationFilterView() {
        delegate?.closeLocationFilterView()
    }
    
    @objc
    func didTapApplyButton() {
        delegate?.didTapApplyButton()
    }
    
}


