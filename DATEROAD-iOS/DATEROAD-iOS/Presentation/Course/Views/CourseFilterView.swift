//
//  CourseFilterView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/11/24.
//

import UIKit

import SnapKit
import Then

protocol CourseFilterViewDelegate: AnyObject {
    func didTapLocationFilter()
    func didTapResetButton()
}

class CourseFilterView: BaseView {
    
    // MARK: - UI Properties
    
    let locationFilterButton = UIButton()
    
    let resetButton = UIButton()
    
    let priceCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    weak var delegate: CourseFilterViewDelegate?
    
    private var priceButtons: [UIButton] = []
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setHierarchy() {
        self.addSubviews(
            locationFilterButton,
            resetButton,
            priceCollectionView
        )
    }
    
    override func setLayout() {
        locationFilterButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        priceCollectionView.snp.makeConstraints {
            $0.top.equalTo(locationFilterButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(30)
        }
    }
    
    override func setStyle() {
        locationFilterButton.do {
            $0.setTitle("지역", for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.contentHorizontalAlignment = .left
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.setImage(UIImage(resource: .icDropdown), for: .normal)
            $0.adjustsImageWhenHighlighted = false
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 128, bottom: 0, right: 0)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(locationFilterButtonTapped))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
        
        resetButton.do {
            $0.setImage(UIImage(resource: .icReset), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.adjustsImageWhenHighlighted = false
            $0.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        }
    }
    
    @objc
    private func locationFilterButtonTapped() {
        delegate?.didTapLocationFilter()
    }
    
    @objc
    private func didTapResetButton() {
        delegate?.didTapResetButton()
        resetPriceButtons()
    }
    
    func updatePrice(button: UIButton, buttonType: DRButtonType, isSelected: Bool) {
        button.setButtonStatus(buttonType: buttonType)
    
        if isSelected {
            priceButtons.append(button)
        } else {
            if let index = priceButtons.firstIndex(of: button) {
                priceButtons.remove(at: index)
            }
            button.setTitleColor(UIColor(resource: .gray400), for: .normal)
        }
    }
    
    func resetPriceButtons() {
        for button in priceButtons {
            updatePrice(button: button, buttonType: UnselectedButton(), isSelected: false)
        }
        priceButtons.removeAll()
    }
}
