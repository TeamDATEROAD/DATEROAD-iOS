//
//  StickyHeaderNavBarView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import UIKit

import SnapKit
import Then

final class StickyHeaderNavBarView: UIView {
    
    // MARK: - UI Properties
    
    private let previousButton = UIButton()
    
    private let moreButton = UIButton()
    
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
            $0.centerY.leading.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.size.equalTo(44)
        }
    }
    
    func setStyle() {
        
        self.backgroundColor = .clear
        
        previousButton.do {
            let image = UIImage(resource: .leftArrow).withRenderingMode(.alwaysTemplate)
            $0.setImage(image, for: .normal)
            $0.tintColor = UIColor(resource: .drWhite)
        }
        
        moreButton.do {
            let image = UIImage(resource: .moreButton).withRenderingMode(.alwaysTemplate)
            $0.setImage(image, for: .normal)
            $0.tintColor = UIColor(resource: .drWhite)
        }
        
       
    }
    
}
