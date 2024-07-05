//
//  BringCourseCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class BringCourseCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let likeButtonView = UIView()
    
    private let likeButtonImageView = UIImageView()
    
    private let bringCourseButton = UIButton()
    
    // MARK: - Properties
    
    static let identifier: String = "BringCourseCell"
    
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

// MARK: - Private Methods
private extension BringCourseCell {
    
    func setHierarchy() {
        self.addSubviews(likeButtonView, likeButtonImageView, bringCourseButton)
    }
    
    func setLayout() {
        likeButtonView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(72)
        }
        
        likeButtonImageView.snp.makeConstraints {
            $0.centerY.centerX.equalTo(likeButtonView)
            $0.width.equalTo(20)
            $0.height.equalTo(18)
        }
        
        bringCourseButton.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.leading.equalTo(likeButtonView.snp.trailing).offset(16)
        }
    }
    
    func setStyle() {
        likeButtonView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        likeButtonImageView.do {
            $0.image = UIImage(resource:.heartIcon).withRenderingMode(.alwaysTemplate)
            $0.tintColor = UIColor(resource: .gray200)
        }
        
        bringCourseButton.do {
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setTitle("코스 가져오기", for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
        }
    }
    
}





