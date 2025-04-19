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
    
    private var dateLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_black))
    
    var dDayLabel: DRTextLabel = DRTextLabel(textLabelType: .background(.bold11_white, .purple600_10), hidden: true)
    
    // TODO: - UILabel로 변경
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var locationLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med15_gray500))
    
    private var titleLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold24_black),
        alignment: .left,
        numberOfLines: 2
    )
    
    private var dateDetailView = UIView()
    
    private var dateStartTimeLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi15_black))
    
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
                         dDayLabel,
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
            $0.leading.equalToSuperview().inset(ScreenUtils.width * 0.1386667)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.61602217)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.01477833)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(21)
        }
        
        dDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(19)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.height.equalTo(62)
            $0.width.equalTo(ScreenUtils.width * 0.768)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.15640394)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.19458128)
            $0.height.equalTo(30)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalTo(firstTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.19458128)
            $0.height.equalTo(30)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalTo(secondTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(ScreenUtils.height * 0.19458128)
            $0.height.equalTo(30)
        }
        
        dateDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(ScreenUtils.height * 0.25369458)
            $0.bottom.equalToSuperview()
        }
        
        dateStartTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(ScreenUtils.width * 16 / 375)
            $0.top.equalToSuperview().inset(30)
        }
        
        dateTimeLineCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width * 16 / 375)
            $0.top.equalToSuperview().inset(63)
            $0.height.equalTo(ScreenUtils.height / 812 * 340)
        }
        
        kakaoShareButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width / 375 * 73)
            $0.height.equalTo(ScreenUtils.width * 0.1386667)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.04802956)
        }
        
        courseShareButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width / 375 * 73)
            $0.height.equalTo(ScreenUtils.width * 0.1386667)
            $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.04802956)
        }
    }
    
    override func setStyle() {
        ribbonImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        dDayLabel.setPadding(top: 2, left: 10, bottom: 2, right: 10)
        
        [firstTagButton, secondTagButton, thirdTagButton].forEach { i in
            i.do {
                $0.setButtonStatus(buttonType: tagButtonType)
            }
        }
        
        [secondTagButton, thirdTagButton].forEach { i in
            i.isHidden = true
        }
        
        dateDetailView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        dateTimeLineCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.isPagingEnabled = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.clipsToBounds = true
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        kakaoShareButton.do {
            $0.isHidden = true
            var config = UIButton.Configuration.plain()
            config.image = UIImage(resource: .kakaoShare)
            config.title = StringLiterals.DateSchedule.kakaoShare
            config.background.backgroundColor = UIColor(resource: .purple600)
            config.baseForegroundColor = UIColor(resource: .drWhite)
            config.cornerStyle = .capsule
            config.imagePadding = 12
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.suit(.body_bold_15)
                return outgoing
            }
            $0.configuration = config
        }
        
        courseShareButton.do {
            $0.isHidden = true
            var config = UIButton.Configuration.plain()
            config.title = StringLiterals.DateSchedule.courseShare
            config.background.backgroundColor = UIColor(resource: .purple600)
            config.baseForegroundColor = UIColor(resource: .drWhite)
            config.cornerStyle = .capsule
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.suit(.body_bold_15)
                return outgoing
            }
            $0.configuration = config
        }
        
        DateDetailContentView.dateTimeLineCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
            $0.itemSize = CGSize(width: ScreenUtils.width * 343/375, height: 76)
        }
    }
    
}


// MARK: - Data Binding Methods

extension DateDetailContentView {
    
    func dataBind(_ dateDetailData : DateDetailModel) {
        dateLabel.text = dateDetailData.date
        dDayLabel.text = dateDetailData.dDay == 0 ? "D-Day" : "D-\(dateDetailData.dDay)"
        
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
    
    private func setColorToLabel(_ cardType: DateCardType) {
        self.backgroundColor = cardType.bgColor
        self.ribbonImageView.image = cardType.ribbonImage
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
            var config = UIButton.Configuration.plain()
            config.image = tendencyTag.tag.tagIcon
            config.title = " \(tendencyTag.tag.tagTitle)"
            config.titleLineBreakMode = .byClipping
            config.titleAlignment = .center
            config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
            config.baseForegroundColor = .drBlack
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.suit(.body_med_13)
                return outgoing
            }
            $0.configuration = config
        }
    }
    
}


