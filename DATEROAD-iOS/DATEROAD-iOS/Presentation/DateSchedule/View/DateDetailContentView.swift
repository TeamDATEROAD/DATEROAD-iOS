//
//  DateDetailContentView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

class DateDetailContentView: BaseView {

    // MARK: - UI Properties
    
    private var ribbonImageView = UIImageView()
    
    private var dateLabel = UILabel()
    
    private var dDayButton = UIButton()
    
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
    
    // MARK: - Properties
    
    private let upcomingDateCardViewModel = DateDetailViewModel()
    
    private lazy var upcomingDataDetailData = upcomingDateCardViewModel.upcomingDateDetailDummyData
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        setDelegate()
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
            $0.leading.equalToSuperview().inset(54)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(500.21)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
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
            $0.width.equalTo(241)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(127)
        }
        
        firstTagButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(158)
            $0.height.equalTo(30)
        }
        
        secondTagButton.snp.makeConstraints {
            $0.leading.equalTo(firstTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(158)
            $0.height.equalTo(30)
        }
        
        thirdTagButton.snp.makeConstraints {
            $0.leading.equalTo(secondTagButton.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(158)
            $0.height.equalTo(30)
        }
        
        dateDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(206)
            $0.bottom.equalToSuperview()
        }
        
        dateStartTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(30)
        }
        
        dateTimeLineCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(63)
            $0.height.equalTo(318)
        }
        
        kakaoShareButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(78)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(39)
        }
        
        courseShareButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(78)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(39)
        }

    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .lilac)

        ribbonImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        dateLabel.do {
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .drBlack)
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
        }
        
        thirdTagButton.do {
            $0.setButtonStatus(buttonType: tagButtonType)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
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
        
        dateDetailView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        dateStartTimeLabel.do {
            $0.font = UIFont.suit(.body_semi_15)
            $0.textColor = UIColor(resource: .drBlack)
            $0.text = "시작시간: \(upcomingDataDetailData.startTime ?? "12:00")"
        }
        
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
            $0.setTitle("카카오톡으로 공유하기", for: .normal)
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
            $0.setTitle("데이트 코스 올리고 50P 받기", for: .normal)
            $0.setTitleColor(UIColor(resource: .drWhite), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
            $0.roundedButton(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        DateDetailContentView.dateTimeLineCollectionViewLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12
            $0.itemSize = CGSize(width: 343, height: 54)
        }
        
    }

}

extension DateDetailContentView {
    
    func dataBind(_ dateCardData : DateCardModel) {
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

    private func register() {
        dateTimeLineCollectionView.register(DateTimeLineCollectionViewCell.self, forCellWithReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        dateTimeLineCollectionView.delegate = self
    }
}

// MARK: - Delegate

extension DateDetailContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DateDetailContentView.dateTimeLineCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
}
