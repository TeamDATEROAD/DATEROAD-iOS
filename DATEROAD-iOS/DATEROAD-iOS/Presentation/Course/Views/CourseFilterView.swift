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

final class CourseFilterView: BaseView {
    
    // MARK: - UI Properties
    
    let locationFilterButton = UIButton()
    
    let resetButton: DRImageButton = DRImageButton(image: UIImage(resource: .icReset), buttonName: .med_white_0)
    
    let priceCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
    
    weak var delegate: CourseFilterViewDelegate?
    
    private var currentButton: DRTextButton?
    
    
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
            $0.top.leading.equalToSuperview().inset(16)
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
            $0.horizontalEdges.equalToSuperview().inset(16)
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
        
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
}

extension CourseFilterView {
    
    func updatePrice(button: DRTextButton, _ buttonName: ButtonName, isSelected: Bool) {
        // 버튼 속성 업데이트
        button.setButtonStyle(buttonName, isSelected: isSelected)
        
        // 현재 선택된 버튼 변경
        // true -> 받아온 버튼이 현재 선택된 버튼, false -> 버튼 해제한 경우이므로 선택된 버튼 x
        currentButton = isSelected ? button : nil
    }
    
    func resetPriceButtons() {
        guard let priceButton = currentButton else { return }
        updatePrice(button: priceButton, .med_gray100_15, isSelected: false)
        currentButton = nil
    }
    
    func resetLocationFilterButton() {
        locationFilterButton.do {
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.setTitle("지역", for: .normal)
            $0.layer.borderWidth = 0
            $0.tintColor = UIColor(resource: .gray400)
        }
    }
    
    @objc
    private func locationFilterButtonTapped() {
        delegate?.didTapLocationFilter()
    }
    
    @objc
    private func didTapResetButton() {
        delegate?.didTapResetButton()
    }
    
}
