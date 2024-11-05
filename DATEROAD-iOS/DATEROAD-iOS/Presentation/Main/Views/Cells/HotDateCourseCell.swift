//
//  HotDateCourseCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

import Kingfisher

final class HotDateCourseCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let countryLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let courseImage: UIImageView = UIImageView()
    
    private let likeView: UIView = UIView()
    
    private let likeImage: UIImageView = UIImageView()
    
    private let likeLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let dateNameView: UIView = UIView()
    
    private let dateNameLabel: UILabel = UILabel()
    
    private let costView: UIView = UIView()
    
    private let costImage: UIImageView = UIImageView()
    
    private var costLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let timeView: UIView = UIView()
    
    private let timeImage: UIImageView = UIImageView()
    
    private var timeLabel: DRPaddingLabel = DRPaddingLabel()
    
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        self.courseImage.image = nil
        self.costLabel.text = nil
        self.likeLabel.text = nil
        self.countryLabel.text = nil
        self.dateNameLabel.text = nil
    }
    
    override func setHierarchy() {
        self.addSubviews(countryLabel,
                         courseImage,
                         likeView,
                         likeImage,
                         likeLabel,
                         dateNameView,
                         dateNameLabel,
                         costView,
                         costImage,
                         costLabel,
                         timeView,
                         timeImage,
                         timeLabel)
    }
    
    override func setLayout() {
        countryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(26)
        }
        
        courseImage.snp.makeConstraints {
            $0.top.equalTo(countryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(238)
        }
        
        likeView.snp.makeConstraints {
            $0.bottom.leading.equalTo(courseImage).inset(5)
            $0.trailing.equalTo(likeLabel)
            $0.height.equalTo(22)
        }
        
        likeImage.snp.makeConstraints {
            $0.centerY.equalTo(likeView)
            $0.leading.equalTo(likeView).inset(10)
            $0.width.equalTo(10)
            $0.height.equalTo(9)
        }
        
        likeLabel.snp.makeConstraints {
            $0.leading.equalTo(likeImage.snp.trailing).offset(5)
            $0.verticalEdges.equalTo(likeView).inset(2)
        }
        
        dateNameView.snp.makeConstraints {
            $0.top.equalTo(courseImage.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        dateNameLabel.snp.makeConstraints {
            $0.top.equalTo(dateNameView)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        costView.snp.makeConstraints {
            $0.top.equalTo(dateNameView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(costLabel)
            $0.height.equalTo(26)
        }
        
        costImage.snp.makeConstraints {
            $0.centerY.equalTo(costView)
            $0.leading.equalTo(costView).inset(10)
            $0.size.equalTo(12)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.equalTo(costImage.snp.trailing).offset(6)
            $0.verticalEdges.equalTo(costView).inset(2)
        }
        
        timeView.snp.makeConstraints {
            $0.top.equalTo(dateNameView.snp.bottom).offset(10)
            $0.leading.equalTo(costView.snp.trailing).offset(6)
            $0.trailing.equalTo(timeLabel)
            $0.height.equalTo(26)
        }
        
        timeImage.snp.makeConstraints {
            $0.centerY.equalTo(costView)
            $0.leading.equalTo(timeView).inset(10)
            $0.size.equalTo(12)
        }
        
        timeLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(timeView).inset(2)
            $0.leading.equalTo(timeImage.snp.trailing).offset(6)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        countryLabel.do {
            $0.backgroundColor = UIColor(resource: .mediumPurple)
            $0.roundedLabel(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_med_13))
            $0.setPadding(top: 0, left: 13, bottom: 0, right: 13)
        }
        
        courseImage.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.image = UIImage(resource: .placeholder)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.roundCorners(cornerRadius: 13, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        likeView.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
        
        likeImage.image = UIImage(resource: .heartIcon)
        
        likeLabel.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.textColor = UIColor(resource: .drWhite)
            $0.font = UIFont.suit(.body_bold_13)
            $0.roundedLabel(cornerRadius: 12, maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            $0.setPadding(top: 0, left: 0, bottom: 0, right: 10)
        }
        
        dateNameView.backgroundColor = UIColor(resource: .drWhite)
        
        dateNameLabel.do {
            $0.textAlignment = .left
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.numberOfLines = 2
            $0.lineBreakMode = .byWordWrapping
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_17))
        }
        
        costView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
        
        costImage.image = UIImage(resource: .coastIcon)
        
        costLabel.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.textColor = UIColor(resource: .gray400)
            $0.font = UIFont.suit(.body_med_13)
            $0.setPadding(top: 4, left: 0, bottom: 4, right: 10)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
        
        timeView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
        
        timeImage.do {
            $0.image = UIImage(resource: .timeIcon)
        }
        
        timeLabel.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.textColor = UIColor(resource: .gray400)
            $0.font = UIFont.suit(.body_med_13)
            $0.roundedLabel(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
            $0.setPadding(top: 4, left: 0, bottom: 4, right: 10)
        }
    }
    
}

extension HotDateCourseCell {
    
    func bindData(hotDateData: DateCourseModel?) {
        guard let hotDateData else { return }
        self.countryLabel.text = hotDateData.city
        if let url = URL(string: hotDateData.thumbnail) {
            self.courseImage.kf.setImage(with: url, options: [.transition(.none),
                                                              .cacheOriginalImage,
                                                              .keepCurrentImageWhileLoading])
        } else {
            self.courseImage.image = UIImage(resource: .placeholder)
        }
        
        self.likeLabel.text = "\(hotDateData.like)"
        self.dateNameLabel.text = hotDateData.title
        self.costLabel.text =  "\(hotDateData.cost.priceRangeTag())"
        self.timeLabel.text = "\(hotDateData.duration)시간"
    }
    
}
