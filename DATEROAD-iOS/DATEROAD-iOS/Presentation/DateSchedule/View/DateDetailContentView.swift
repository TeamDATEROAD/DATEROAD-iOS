//
//  DateDetailContentView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

final class DateDetailContentView: BaseView {
    
    // MARK: - UI Properties
    
    private var ribbonImageView = UIImageView()
    
    private var dateLabel = UILabel()
    
    var dDayButton = UIButton()
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var dateDetailView = UIView()
    
    private var dateStartTimeLabel = UILabel()
    
    var dateTimeLineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: dateTimeLineCollectionViewLayout)
    
    private var dateDeleteButton = UIButton()
    
    private let tagButtonType : DRButtonType = DateScheduleTagButton()
    
    var kakaoShareButton = UIButton()
    
    var courseShareButton = UIButton()
    
    static var dateTimeLineCollectionViewLayout = UICollectionViewFlowLayout()
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(ribbonImageView,
                         dateLabel,
                         dDayButton,
                         firstTagButton,
                         secondTagButton,
                         thirdTagButton,
                         locationLabel,
                         titleLabel,
                         dateDetailView,
                         kakaoShareButton,
                         courseShareButton)
        
        dateDetailView.addSubviews(dateStartTimeLabel, dateTimeLineCollectionView)
    }
    
    override func setLayout() {
        ribbonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(ScreenUtils.width*0.1386667)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(ScreenUtils.height*0.61602217)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(ScreenUtils.height*0.01477833)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(21)
        }
        
        dDayButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(19)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.height.equalTo(62)
            $0.width.equalTo(ScreenUtils.width*0.768)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(ScreenUtils.height*0.15640394)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(ScreenUtils.height*0.19458128)
            $0.height.equalTo(30)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalTo(firstTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(ScreenUtils.height*0.19458128)
            $0.height.equalTo(30)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalTo(secondTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(ScreenUtils.height*0.19458128)
            $0.height.equalTo(30)
        }
        
        dateDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(ScreenUtils.height*0.25369458)
            $0.bottom.equalToSuperview()
        }
        
        dateStartTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(ScreenUtils.width*16/375)
            $0.top.equalToSuperview().inset(30)
        }
        
        dateTimeLineCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width*16/375)
            $0.top.equalToSuperview().inset(63)
            $0.height.equalTo(ScreenUtils.height*0.39162562)
        }
        
        kakaoShareButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(ScreenUtils.width*0.1386667)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height*0.04802956)
        }
        
        courseShareButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(ScreenUtils.width*0.1386667)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height*0.04802956)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .lilac)
        
        ribbonImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        dateLabel.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_semi_15))
        
        dDayButton.do {
            $0.isHidden = true
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
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.isEnabled = false
            $0.adjustsImageWhenDisabled = false
        }
        
        thirdTagButton.do {
            $0.isHidden = true
            $0.titleLabel?.lineBreakMode = .byClipping
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.textAlignment = .center
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            $0.isEnabled = false
            $0.adjustsImageWhenDisabled = false
        }
        
        locationLabel.setLabel(textColor: UIColor(resource: .gray500), font: UIFont.suit(.body_med_15))
        
        titleLabel.setLabel(alignment: .left,
                               numberOfLines: 2,
                               textColor: UIColor(resource: .drBlack),
                               font:  UIFont.systemFont(ofSize: 24, weight: .black))
        
        dateDetailView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        dateStartTimeLabel.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_semi_15))
        
        dateTimeLineCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.isPagingEnabled = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.clipsToBounds = true
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
        }
        
        kakaoShareButton.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setImage(UIImage(resource: .kakaoShare), for: .normal)
            $0.setTitle(StringLiterals.DateSchedule.kakaoShare, for: .normal)
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            $0.imageEdgeInsets = UIEdgeInsets(top: 14, left: -6, bottom: 14, right: 6)
            $0.titleEdgeInsets = UIEdgeInsets(top: 15.5, left: 6, bottom: 15.5, right: -6)
            $0.roundedButton(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        courseShareButton.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setTitle(StringLiterals.DateSchedule.courseShare, for: .normal)
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
            $0.roundedButton(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        DateDetailContentView.dateTimeLineCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
            $0.itemSize = CGSize(width: ScreenUtils.width * 343/375, height: 54)
        }
    }
    
}


// MARK: - Data Binding Methods

extension DateDetailContentView {
    
    func dataBind(_ dateDetailData : DateDetailModel) {
        self.dateLabel.text = dateDetailData.date
        if dateDetailData.dDay == 0 {
            self.dDayButton.setTitle("D-Day", for: .normal)
        } else {
            self.dDayButton.setTitle("D-\(dateDetailData.dDay)", for: .normal)
            
        }
        self.dateStartTimeLabel.text = "\(dateDetailData.startAt) " + StringLiterals.DateSchedule.startTime
        updateTagButton(title: "\(dateDetailData.tags[0].tag)", button: self.firstTagButton)
        if dateDetailData.tags.count >= 2 {
            self.secondTagButton.isHidden = false
            updateTagButton(title: "\(dateDetailData.tags[1].tag)", button: self.secondTagButton)
        }
        if dateDetailData.tags.count == 3 {
            self.thirdTagButton.isHidden = false
            updateTagButton(title: "\(dateDetailData.tags[2].tag)", button: self.thirdTagButton)
        }
        self.locationLabel.text = dateDetailData.city
        self.titleLabel.text = dateDetailData.title
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
            setColorToLabel(bgColor: UIColor(resource: .pink200),
                            ribbonImage: UIImage(resource: .lilacRibbon),
                            buttonColor: UIColor(resource: .pink100))
        } else if colorIndex == 1 {
            setColorToLabel(bgColor: UIColor(resource: .purple200),
                            ribbonImage: UIImage(resource: .deepPurpleRibbon),
                            buttonColor: UIColor(resource: .purple100))
        } else {
            setColorToLabel(bgColor: UIColor(resource: .lime),
                            ribbonImage: UIImage(resource: .limeRibbon),
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


