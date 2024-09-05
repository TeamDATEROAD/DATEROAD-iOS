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
    
    let previousButton = UIButton()
    
    weak var delegate: StickyHeaderNavBarViewDelegate?
    
    let moreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension StickyHeaderNavBarView {
    
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
        
        previousButton.do {
            let image = UIImage(resource: .leftArrow).withRenderingMode(.alwaysTemplate)
            $0.setImage(image, for: .normal)
            $0.tintColor = UIColor(resource: .drWhite)
            $0.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        }
        
        moreButton.do {
            let image = UIImage(resource: .moreButton).withRenderingMode(.alwaysTemplate)
            $0.setImage(image, for: .normal)
            $0.tintColor = UIColor(resource: .drWhite)
            $0.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        }
    }
    
    @objc
    func didTapPreviousButton() {
        delegate?.didTapBackButton()
    }
    
    @objc
    func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
}
