//
//  DateCardCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

final class DateCardCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private var topImageView = UIImageView()
    
    private var bottomImageView = UIImageView()
    
    private var dateLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.extra24_black),
        alignment: .left,
        numberOfLines: 2
    )

    private var dDayLabel: DRTextLabel = DRTextLabel(textLabelType: .background(.bold11_white, .deepPurple_10))

    // TODO: - UILabel로 변경
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var dotDividerView = UIImageView()
    
    private var leftCircleInsetImageView = UIImageView()
    
    private var rightCircleInsetImageView = UIImageView()
    
    private var locationLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med15_gray500))
    
    private var titleLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold24_black),
        alignment: .left,
        numberOfLines: 2
    )
    
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
                         dDayLabel,
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
        
        dDayLabel.snp.makeConstraints {
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
        
        self.roundCorners(cornerRadius: 20)
        
        topImageView.contentMode = .scaleAspectFill
        
        bottomImageView.contentMode = .scaleAspectFill
        
        dDayLabel.setPadding(top: 2, left: 10, bottom: 2, right: 10)
        
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
    }
    
}

extension DateCardCollectionViewCell {
    
    func dataBind(_ dateCardData : DateCardModel, _ dateCardItemRow: Int) {
        self.dateLabel.text = dateCardData.date
        dDayLabel.text = dateCardData.dDay == 0 ? StringLiterals.DateSchedule.dDay : "D-\(dateCardData.dDay)"

        updateTagButton(title: "\(dateCardData.tags[0].tag)", button: self.firstTagButton)
        if dateCardData.tags.count >= 2 {
            self.secondTagButton.isHidden = false
            updateTagButton(title: "\(dateCardData.tags[1].tag)", button: self.secondTagButton)
        }
        if dateCardData.tags.count == 3 {
            self.thirdTagButton.isHidden = false
            updateTagButton(title: "\(dateCardData.tags[2].tag)", button: self.thirdTagButton)
        }
        locationLabel.text = dateCardData.city
        titleLabel.text = dateCardData.title
    }
    
    private func setColorToLabel(_ cardType: DateCardType) {
        self.backgroundColor = cardType.bgColor
        self.topImageView.image = cardType.topImage
        self.bottomImageView.image = cardType.bottomImage
        [self.firstTagButton, self.secondTagButton, self.thirdTagButton].forEach {
            $0.backgroundColor = cardType.buttonColor
        }
    }
    
    func setColor(index: Int) {
        let cardType = DateCardType(rawValue: index % 3) ?? .pink
        setColorToLabel(cardType)
    }
    
    func updateTagButton(title: String, button: UIButton) {
        guard let tendencyTag = TendencyTag.getTag(byEnglish: title) else { return }
        button.do {
            $0.setImage(tendencyTag.tag.tagIcon, for: .normal)
            $0.setTitle(" \(tendencyTag.tag.tagTitle)", for: .normal)
        }
    }
    
}
