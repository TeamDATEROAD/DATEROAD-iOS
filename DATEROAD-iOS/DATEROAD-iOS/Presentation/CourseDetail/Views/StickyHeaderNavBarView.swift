//
//  StickyHeaderNavBarView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import UIKit

import SnapKit
import Then

protocol StickyHeaderNavBarViewDelegate: AnyObject {
    
    func didTapBackButton()
    
    func didTapMoreButton()
    
}

final class StickyHeaderNavBarView: UIView {
    
    // MARK: - UI Properties
    
    private let previousButton: DRImageButton = DRImageButton(image: UIImage(resource: .leftArrow), buttonName: .clear)
    
    private let moreButton: DRImageButton = DRImageButton(image: UIImage(resource: .moreButton), buttonName: .clear)
    
    
    // MARK: - Properties
    
    weak var delegate: StickyHeaderNavBarViewDelegate?
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubviews(previousButton, moreButton)
    }
    
    func setLayout() {
        previousButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5)
            $0.leading.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        moreButton.snp.makeConstraints {
            $0.bottom.equalTo(previousButton)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(44)
        }
    }
    
    func setStyle() {
        self.backgroundColor = .clear
        
        previousButton.configuration?.baseForegroundColor = UIColor(resource: .drWhite)
        
        moreButton.configuration?.baseForegroundColor = UIColor(resource: .drWhite)
    }
    
    func setAddTarget() {
        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
}


// MARK: - Methods

extension StickyHeaderNavBarView {
    
    func updateTintColor( _ tintColor: UIColor) {
        moreButton.configuration?.baseForegroundColor = tintColor
        previousButton.configuration?.baseForegroundColor = tintColor
    }
    
    func hiddenMoreButton(_ hidden: Bool) {
        moreButton.isHidden = hidden
    }
    
}


// MARK: - @objc Methods

private extension StickyHeaderNavBarView {
    
    @objc
    func didTapPreviousButton() {
        delegate?.didTapBackButton()
    }
    
    @objc
    func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
}
