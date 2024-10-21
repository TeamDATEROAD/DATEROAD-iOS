//
//  CourseListCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/11/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

protocol CourseListCollectionViewCellDelegate: AnyObject {
    
    func didTapCourseListCell()
    
}

final class CourseListCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let thumnailImgageView = UIImageView()
    
    private let likeBoxView = UIView()
    
    private let likeButton = UIImageView(image: .heartIcon)
    
    private let likeNumLabel = UILabel()
    
    private let locationLabel = UILabel()
    
    private let titleLabel = UILabel()
    
    private let coastIconImageView = UIImageView(image: .coastIcon)
    
    private let coastLabel = UILabel()
    
    private let timeIconImageView = UIImageView(image: .timeIcon)
    
    private let timeLabel = UILabel()
    
    
    // MARK: - Properties
    
    weak var delegate: CourseListCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 셀이 재사용될 때 이미지나 데이터를 초기화합니다.
        thumnailImgageView.image = nil
        likeNumLabel.text = nil
        locationLabel.text = nil
        titleLabel.text = nil
        coastLabel.text = nil
        timeLabel.text = nil
    }
    
    override func setHierarchy() {
        self.addSubviews(
            thumnailImgageView,
            likeBoxView,
            likeNumLabel,
            likeButton,
            locationLabel,
            titleLabel,
            coastIconImageView,
            coastLabel,
            timeIconImageView,
            timeLabel
        )
    }
    
    override func setLayout() {
        thumnailImgageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        likeBoxView.snp.makeConstraints {
            $0.bottom.equalTo(thumnailImgageView).offset(-5)
            $0.leading.equalToSuperview().inset(6)
            $0.trailing.equalTo(likeNumLabel).offset(10)
            $0.height.equalTo(22)
        }
        
        likeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(likeBoxView)
            $0.width.equalTo(10)
            $0.height.equalTo(9)
        }
        
        likeNumLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeBoxView)
            $0.leading.equalTo(likeButton.snp.trailing).offset(5)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(thumnailImgageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        coastIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(212.5)
            $0.leading.equalToSuperview()
            $0.size.equalTo(12)
        }
        
        coastLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(coastIconImageView.snp.trailing).offset(5)
        }
        
        timeIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalToSuperview().inset(87)
            $0.size.equalTo(12)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(coastIconImageView)
            $0.leading.equalTo(timeIconImageView.snp.trailing).offset(5)
        }
    }
    
    override func setStyle() {
        thumnailImgageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
            $0.contentMode = .scaleAspectFill
        }
        
        likeBoxView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 11
            $0.backgroundColor = UIColor(resource: .deepPurple)
        }
        
        likeNumLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_bold_13))
        }
        
        locationLabel.do {
            $0.setLabel(numberOfLines: 1, textColor: UIColor(resource: .gray400), font: UIFont.suit(.body_med_13))
        }
        
        titleLabel.do {
            $0.setLabel(alignment: .left, numberOfLines: 2, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_15))
        }
        
        coastLabel.do {
            $0.setLabel(textColor: UIColor(resource: .gray400), font: UIFont.suit(.cap_reg_11))
        }
        
        timeLabel.do {
            $0.setLabel(textColor: UIColor(resource: .gray400), font: UIFont.suit(.cap_reg_11))
        }
    }
    
}

extension CourseListCollectionViewCell {
    
    func configure(with course: CourseListModel) {
        thumnailImgageView.kfSetImage(with: course.thumbnail, placeholder: UIImage(named: "placeholder_image"))
        
        if let likeCount = course.like {
            likeNumLabel.text = "\(likeCount)"
        } else {
            likeNumLabel.text = nil
        }
        
        locationLabel.text = course.location
        titleLabel.text = course.title
        if let coast = course.cost {
            coastLabel.text = "\(coast.priceRangeTag())"
        } else {
            coastLabel.text = nil
        }
        
        if let time = course.time {
            timeLabel.text = "\(time.formatFloatTime())시간"
        } else {
            timeLabel.text = nil
        }
    }
    
    @objc
    private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapCourseListCell()
    }
    
}
