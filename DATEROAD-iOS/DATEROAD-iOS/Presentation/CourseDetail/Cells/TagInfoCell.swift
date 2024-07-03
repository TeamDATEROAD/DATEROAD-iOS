//
//  TagInfoCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class TagInfoCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let hashTagBackgroundView = UIView()
    
    private let hashTagLabel = UILabel()
    
    // MARK: - Properties
    
    static let identifier: String = "TagInfoCell"

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(contents: CourseDetailContents) {
        hashTagLabel.text = contents.hashTag
    }
}

// MARK: - Private Methods
private extension TagInfoCell {
    
    func setHierarchy() {
        addSubviews(hashTagBackgroundView, hashTagLabel)
    }
    
    func setLayout() {
        hashTagBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalTo(hashTagLabel).inset(-14)
            $0.height.equalTo(30)
        }
        hashTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setStyle() {
        hashTagBackgroundView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 16
        }
        
        hashTagLabel.do {
            $0.text = "🚙 드라이브"
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
    }

}




