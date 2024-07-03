//
//  HashTagCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/4/24.
//

import UIKit

import SnapKit
import Then


final class HashTagInfoCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    let hashTagLabel = UILabel()
    
    // MARK: - Properties
    
    static let identifier: String = "HashTagInfoCell"

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
private extension HashTagInfoCell {
    
    func setHierarchy() {
        contentView.addSubview(hashTagLabel)
    }
    
    func setLayout() {
        hashTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setStyle() {
        hashTagLabel.do {
            $0.text = "🚙 드라이브"
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        contentView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 14
        }
    }

}




