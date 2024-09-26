//
//  InfoHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then

final class InfoHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = UILabel()
    
    // MARK: - Properties
    
    static let elementKinds: String = "infoHeaderView"
    
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
            $0.textColor = UIColor(resource: .drBlack)
            $0.font = UIFont.suit(.title_bold_18)
            $0.numberOfLines = 1
        }
    }
    
}

extension InfoHeaderView {
    
    func bindTitle(headerTitle: String) {
        self.titleLabel.text = headerTitle
    }
    
}
