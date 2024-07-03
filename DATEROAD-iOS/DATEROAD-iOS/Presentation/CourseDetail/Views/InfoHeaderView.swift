//
//  InfoHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then

class InfoHeaderView: UICollectionReusableView {

    // MARK: - Properties
    
    let titleLabel: UILabel = UILabel()
    
    static let elementKinds: String = "header"
    static let identifier: String = "InfoHeaderView"

    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindTitle(headerTitle: String) {
        self.titleLabel.text = headerTitle
    }
    
}

private extension InfoHeaderView {
    
    func setHierarchy() {
        self.addSubview(titleLabel)
        
    }
    
    func setLayout() {

        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
    }
    
    func setStyle() {
        
        titleLabel.do {
            $0.text = "코스"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
    }
    
}
