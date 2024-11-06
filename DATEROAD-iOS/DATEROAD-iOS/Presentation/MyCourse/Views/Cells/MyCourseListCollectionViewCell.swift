//
//  ViewedCourseCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class MyCourseListCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private var thumbnailImageView = UIImageView()
    
    private var heartButton = UIButton()
    
    private var infoView = UIView()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var expenseButton = UIButton()
    
    private var timeButton = UIButton()
    
    
    // MARK: - Properties
    
    var viewedCourseItemRow: Int?
    
    var courseID: Int?
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 셀이 재사용될 때 이미지나 데이터를 초기화합니다.
        thumbnailImageView.image = nil
        locationLabel.text = nil
        titleLabel.text = nil
        heartButton.titleLabel?.text = nil
        expenseButton.titleLabel?.text = nil
        timeButton.titleLabel?.text = nil
    }
    
    override func setHierarchy() {
        self.addSubviews(thumbnailImageView, heartButton, infoView)
        infoView.addSubviews(locationLabel,
                             titleLabel,
                             expenseButton,
                             timeButton)
    }
    
    override func setLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(120)
        }
        
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.leading).inset(5)
            $0.bottom.equalTo(thumbnailImageView.snp.bottom).inset(5)
            $0.height.equalTo(22)
        }
        
        infoView.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(9)
            $0.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.height.equalTo(42)
        }
        
        expenseButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(26)
        }
        
        timeButton.snp.makeConstraints {
            $0.leading.equalTo(expenseButton.snp.trailing).offset(6)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(26)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        thumbnailImageView.do {
            $0.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        heartButton.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.roundedButton(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_13)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6.5, left: -2.5, bottom: 6.5, right: 2.5)
            $0.titleEdgeInsets = UIEdgeInsets(top: 2, left: 2.5, bottom: 2, right: -2.5)
            $0.setImage(UIImage(resource: .heartIcon), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        locationLabel.do {
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .gray400)
            $0.textAlignment = .left
        }
        
        titleLabel.do {
            $0.font = UIFont.suit(.body_bold_15)
            $0.textColor = UIColor(resource: .drBlack)
            $0.textAlignment = .left
            $0.numberOfLines = 2
        }
        
        expenseButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundedButton(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2.5, bottom: 0, right: 2.5)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: -2.5)
            $0.setImage(UIImage(resource: .coastIcon), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
        }
        
        timeButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundedButton(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2.5, bottom: 0, right: 2.5)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: -2.5)
            $0.setImage(UIImage(resource: .timeIcon), for: .normal)
        }
    }
    
}

extension MyCourseListCollectionViewCell {
    
    func dataBind(_ viewedCourseData: MyCourseModel?, _ viewedCourseItemRow: Int?) {
        guard let viewedCourseData else { return }
        self.thumbnailImageView.kf.setImage(
            with: URL(string: viewedCourseData.thumbnail),
            options: [
                .transition(.none),
                .cacheOriginalImage
            ]
        )
        self.courseID = viewedCourseData.courseId
        self.heartButton.setTitle("\(viewedCourseData.like)", for: .normal)
        self.locationLabel.text = viewedCourseData.city
        self.titleLabel.text = viewedCourseData.title
        self.expenseButton.setTitle(viewedCourseData.cost, for: .normal)
        self.timeButton.setTitle(viewedCourseData.duration + "시간", for: .normal)
        self.viewedCourseItemRow = viewedCourseItemRow
    }
    
}
