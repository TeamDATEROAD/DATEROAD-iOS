//
//  DateCardCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

final class DateCardCollectionViewCell: BaseCollectionViewCell {
    
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
    
    override func prepareForReuse() {
        self.secondTagButton.isHidden = true
        self.thirdTagButton.isHidden = true
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
            $0.height.equalTo(ScreenUtils.height * 0.2658)
        }
        
        bottomImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(ScreenUtils.width * 0.328)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.36)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.height.equalTo(62)
        }
        
        dDayButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(19)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(secondTagButton.snp.bottom)
            $0.height.equalTo(29)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(95)
            $0.top.equalTo(thirdTagButton.snp.bottom).offset(ScreenUtils.height * 0.015)
            $0.height.equalTo(29)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(39)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.18)
            $0.height.equalTo(29)
        }
        
        dotDividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(7)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.33)
            $0.height.equalTo(1.5)
        }
        
        leftCircleInsetImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.321)
        }
        
        rightCircleInsetImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.321)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.3608)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = .systemRed
        
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner,
                                                            .layerMaxXMinYCorner,
                                                            .layerMinXMaxYCorner,
                                                            .layerMinXMinYCorner])
        
        topImageView.contentMode = .scaleAspectFill
        
        bottomImageView.contentMode = .scaleAspectFill
        
        dateLabel.setLabel(alignment: .left,
                           numberOfLines: 2,
                           textColor: UIColor(resource: .drBlack),
                           font: UIFont.suit(.title_extra_24))
        
        dDayButton.do {
            $0.titleLabel?.font = UIFont.suit(.cap_bold_11)
            $0.titleLabel?.textColor = UIColor(resource: .drWhite)
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,
                                                               .layerMaxXMinYCorner,
                                                               .layerMinXMaxYCorner,
                                                               .layerMinXMinYCorner])
        }
        
        firstTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.isEnabled = false
            $0.adjustsImageWhenDisabled = false
        }
        
        secondTagButton.do {
            $0.isHidden = true
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.transform = CGAffineTransform(rotationAngle: CGFloat(15 * Double.pi / 180))
            $0.isEnabled = false
            $0.adjustsImageWhenDisabled = false
        }
        
        thirdTagButton.do {
            $0.isHidden = true
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.transform = CGAffineTransform(rotationAngle: CGFloat(-12 * Double.pi / 180))
            $0.isEnabled = false
            $0.adjustsImageWhenDisabled = false
        }
        
        dotDividerView.image = UIImage(resource: .dottedLine)
        
        leftCircleInsetImageView.image = UIImage(resource: .leftCardInset)
        
        rightCircleInsetImageView.image = UIImage(resource: .rightCardInset)
        
        locationLabel.setLabel(textColor: UIColor(resource: .gray500), font: UIFont.suit(.body_med_15))
        
        titleLabel.setLabel(alignment: .left,
                            numberOfLines: 2,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.systemFont(ofSize: 24, weight: .black))
    }
    
}

extension DateCardCollectionViewCell {
    
    func dataBind(_ dateCardData : DateCardModel, _ dateCardItemRow: Int) {
        self.dateLabel.text = dateCardData.date
        if dateCardData.dDay == 0 {
            self.dDayButton.setTitle(StringLiterals.DateSchedule.dDay, for: .normal)
        } else {
            self.dDayButton.setTitle("D-\(dateCardData.dDay)", for: .normal)
        }
        updateTagButton(title: "\(dateCardData.tags[0].tag)", button: self.firstTagButton)
        if dateCardData.tags.count >= 2 {
            self.secondTagButton.isHidden = false
            updateTagButton(title: "\(dateCardData.tags[1].tag)", button: self.secondTagButton)
        }
        if dateCardData.tags.count == 3 {
            self.thirdTagButton.isHidden = false
            updateTagButton(title: "\(dateCardData.tags[2].tag)", button: self.thirdTagButton)
        }
        self.locationLabel.text = dateCardData.city
        self.titleLabel.text = dateCardData.title
    }
    
    private func setColorToLabel(bgColor : UIColor, topImage: UIImage, bottomImage: UIImage, buttonColor: UIColor) {
        self.backgroundColor = bgColor
        self.topImageView.image = topImage
        self.bottomImageView.image = bottomImage
        self.firstTagButton.backgroundColor = buttonColor
        self.secondTagButton.backgroundColor = buttonColor
        self.thirdTagButton.backgroundColor = buttonColor
    }
    
    func setColor(index: Int) {
        let colorIndex = index % 3
        if colorIndex == 0 {
            setColorToLabel(bgColor: UIColor(resource: .pink200),
                            topImage: UIImage(resource: .lilacTop),
                            bottomImage: UIImage(resource: .lilacBottom),
                            buttonColor: UIColor(resource: .pink100))
        } else if colorIndex == 1 {
            setColorToLabel(bgColor: UIColor(resource: .purple200),
                            topImage: UIImage(resource: .deepPurpleTop),
                            bottomImage: UIImage(resource: .deepPurpleBottom),
                            buttonColor: UIColor(resource: .purple100))
        } else {
            setColorToLabel(bgColor: UIColor(resource: .lime),
                            topImage: UIImage(resource: .limeTop),
                            bottomImage: UIImage(resource: .limeBottom),
                            buttonColor: UIColor(resource: .lime100))
        }
    }
    
    func updateTagButton(title: String, button: UIButton) {
        guard let tendencyTag = TendencyTag.getTag(byEnglish: title) else { return }
        button.do {
            $0.setImage(tendencyTag.tag.tagIcon, for: .normal)
            $0.setTitle(" \(tendencyTag.tag.tagTitle)", for: .normal)
        }
    }
    
}
