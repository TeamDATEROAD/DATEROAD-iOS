//
//  PastDateCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then


class PastDateCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private var ribbonImageView = UIImageView()
    
    private var dateLabel = UILabel()
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var dotDividerView = UIImageView()
    
    private var leftCircleInsetImageView = UIImageView()
    
    private var rightCircleInsetImageView = UIImageView()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private let tagButtonType : DRButtonType = PastDateScheduleTagButton()
    
    // MARK: - Properties
    
    var pastDateItemRow: Int?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setHierarchy() {
        self.addSubviews(ribbonImageView,
                         dateLabel,
                         titleLabel,
                         locationLabel,
                         firstTagButton,
                         secondTagButton,
                         thirdTagButton,
                         dotDividerView,
                         leftCircleInsetImageView,
                         rightCircleInsetImageView)
    }
    
    override func setLayout() {
        
        ribbonImageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(68)
            $0.leading.equalToSuperview().inset(40)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(44)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(133)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(161)
            $0.height.equalTo(26)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalTo(firstTagButton.snp.trailing).offset(6)
            $0.top.equalToSuperview().inset(161)
            $0.height.equalTo(26)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalTo(secondTagButton.snp.trailing).offset(6)
            $0.top.equalToSuperview().inset(161)
            $0.height.equalTo(26)
        }
        
        dotDividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(7)
            $0.top.equalToSuperview().inset(116)
            $0.height.equalTo(1.5)
        }
        
        leftCircleInsetImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(107)
        }
        
        rightCircleInsetImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(107)
        }
        
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .lilac)
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
        ribbonImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        dateLabel.do {
            $0.font = UIFont.suit(.body_semi_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        firstTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        }
        
        secondTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        }
        
        thirdTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
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
            $0.font = UIFont.suit(.body_semi_13)
            $0.textColor = UIColor(resource: .drBlack)
        }
        
        titleLabel.do {
            $0.font = UIFont.suit(.title_extra_20)
            $0.textColor = UIColor(resource: .drBlack)
            $0.numberOfLines = 2
            $0.lineBreakMode = .byWordWrapping
        }
    }
    
}

extension PastDateCollectionViewCell {
    func dataBind(_ dateCardData : DateCardModel, _ dateCardItemRow: Int) {
        dateLabel.text = dateCardData.dateCalendar
        firstTagButton.setTitle(dateCardData.tags[0], for: .normal)
        if dateCardData.tags.count >= 2 {
            secondTagButton.isHidden = false
           secondTagButton.setTitle(dateCardData.tags[1], for: .normal)
        }
        if dateCardData.tags.count == 3 {
            thirdTagButton.isHidden = false
            thirdTagButton.setTitle(dateCardData.tags[2], for: .normal)
        }
        locationLabel.text = dateCardData.dateLocation
        titleLabel.text = dateCardData.dateTitle
    }
    
    private func setColorToLabel(bgColor : UIColor, ribbonImage: UIImage, buttonColor: UIColor) {
        self.backgroundColor = bgColor
        self.ribbonImageView.image = ribbonImage
        self.firstTagButton.backgroundColor = buttonColor
        self.secondTagButton.backgroundColor = buttonColor
        self.thirdTagButton.backgroundColor = buttonColor
    }
    
    func setColor(index: Int) {
        let colorIndex = index % 3
        if colorIndex == 0 {
            setColorToLabel(bgColor: UIColor(resource: .pink200), ribbonImage: UIImage(resource: .lilacRibbon), buttonColor: UIColor(resource: .pink100))
        } else if colorIndex == 1 {
            setColorToLabel(bgColor: UIColor(resource: .purple200), ribbonImage: UIImage(resource: .deepPurpleRibbon), buttonColor: UIColor(resource: .purple100))
        } else {
            setColorToLabel(bgColor: UIColor(resource: .lime), ribbonImage: UIImage(resource: .limeRibbon), buttonColor: UIColor(resource: .lime100))
        }
    }
}

