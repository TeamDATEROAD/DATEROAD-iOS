//
//  DateCardCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then


class DateCardCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private var topImageView = UIImageView()
    
    private var bottomImageView = UIImageView()
    
    private var dateLabel = UILabel()
    
    private var dDayButton = UIButton()
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var dotDividerView = UIImageView()
    
    private var leftCircleInsetImageView = UIImageView()
    
    private var rightCircleInsetImageView = UIImageView()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private let tagButtonType : DRButtonType = DateScheduleTagButton()
    // MARK: - Properties
    
    var dateCardItemRow: Int?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setHierarchy() {
        self.addSubviews(topImageView,
                         bottomImageView,
                         dateLabel,
                         dDayButton,
                         firstTagButton,
                         secondTagButton,
                         thirdTagButton,
                         dotDividerView,
                         leftCircleInsetImageView,
                         rightCircleInsetImageView,
                         locationLabel,
                         titleLabel)
    }
    
    override func setLayout() {
        
        topImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.width.equalToSuperview()
            $0.height.equalTo(215.79)
        }
        
        bottomImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(123)
            $0.top.equalToSuperview().inset(346)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.height.equalTo(62)
            // $0.width.equalTo(66)
        }
        
        dDayButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(19)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(218)
            $0.height.equalTo(29)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(83)
            $0.top.equalToSuperview().inset(189)
            $0.height.equalTo(29)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(39)
            $0.top.equalToSuperview().inset(146.21)
            $0.height.equalTo(29)
        }
        
        dotDividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(7)
            $0.top.equalToSuperview().inset(268)
            $0.height.equalTo(1.5)
        }
        
        leftCircleInsetImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(261)
        }
        
        rightCircleInsetImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(261)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(293)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(25)
        }
        
        
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .lilac)
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
        topImageView.do {
            $0.image = UIImage(resource: .lilacTop)
        }
        
        bottomImageView.do {
            $0.image = UIImage(resource: .lilacBottom)
        }
        
        dateLabel.do {
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 2
            
        }
        
        dDayButton.do {
            $0.titleLabel?.font = UIFont.suit(.cap_bold_11)
            $0.titleLabel?.textColor = UIColor(resource: .drWhite)
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        firstTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        }
        
        secondTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.transform = CGAffineTransform(rotationAngle: CGFloat(15 * Double.pi / 180))
        }
        
        thirdTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.transform = CGAffineTransform(rotationAngle: CGFloat(-12 * Double.pi / 180))
        }
        
        dotDividerView.do {
            $0.image = UIImage(resource: .dottedLine)
        }
        
        leftCircleInsetImageView.do {
            $0.image = UIImage(resource: .leftCardInset)
        }
        
        rightCircleInsetImageView.do {
            $0.image = UIImage(resource: .rightCardInset)
        }
        
        locationLabel.do {
            $0.font = UIFont.suit(.body_med_15)
            $0.textColor = UIColor(resource: .gray500)
        }
        
        titleLabel.do {
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 2
            $0.lineBreakMode = .byWordWrapping
        }
    }
    
}

extension DateCardCollectionViewCell {
    func dataBind(_ dateCardData : DateCardModel, _ dateCardItemRow: Int) {
        self.dateLabel.text = dateCardData.dateCalendar
        self.dDayButton.setTitle("D-\(dateCardData.dDay ?? 0)", for: .normal)
        self.firstTagButton.setTitle(dateCardData.tags[0], for: .normal)
        if dateCardData.tags.count >= 2 {
            self.secondTagButton.isHidden = false
            self.secondTagButton.setTitle(dateCardData.tags[1], for: .normal)
        }
        if dateCardData.tags.count == 3 {
            self.thirdTagButton.isHidden = false
            self.thirdTagButton.setTitle(dateCardData.tags[2], for: .normal)
        }
        self.locationLabel.text = dateCardData.dateLocation
        self.titleLabel.text = dateCardData.dateTitle
    }
}

