//
//  BringCourseCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class BringCourseCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let likeButtonView = UIView()
    
    private let likeButtonImageView = UIImageView()
    
    private let bringCourseButton = UIButton()
    
    private var isLiked: Bool = false {
        didSet {
            updateLikeButtonColor()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            likeButtonView,
            likeButtonImageView,
            bringCourseButton
        )
    }
    
    override func setLayout() {
        likeButtonView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(72)
        }
        
        likeButtonImageView.snp.makeConstraints {
            $0.center.equalTo(likeButtonView)
            $0.width.equalTo(20)
            $0.height.equalTo(18)
        }
        
        bringCourseButton.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.leading.equalTo(likeButtonView.snp.trailing).offset(16)
        }
    }
    
    override func setStyle() {
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
            $0.setTitle(StringLiterals.CourseDetail.bringCourseLabel, for: .normal)
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
        }
    }
}

// MARK: - Private Methods

private extension BringCourseCell {
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeButtonView.isUserInteractionEnabled = true
        likeButtonView.addGestureRecognizer(tapGesture)
    }
    
    @objc func likeButtonTapped() {
        isLiked.toggle()
    }
    
    func updateLikeButtonColor() {
        if isLiked {
            likeButtonImageView.tintColor = UIColor(resource: .deepPurple)
        } else {
            likeButtonImageView.tintColor = UIColor(resource: .gray200)
        }
    }
}
