//
//  UpcomingDateDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateDetailViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    private var dateLabel = UILabel()
    
    private var dDayButton = UIButton()
    
    private var firstTagButton = UIButton()
    
    private var secondTagButton = UIButton()
    
    private var thirdTagButton = UIButton()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var dateDetailView = UIView()
    
    private var dateStartTimeLabel = UILabel()
    
    private var dateTimeLineCollectionView = DateTimeLineCollectionView()
    
    private var dateDeleteButton = UIButton()
    
    private let tagButtonType : DRButtonType = DateScheduleTagButton()
    
    // MARK: - Properties
    
    private let upcomingDateCardViewModel = DateDetailViewModel()
    
    private lazy var upcomingDataDetailData = upcomingDateCardViewModel.upcomingDateDetailDummyData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: "데이트 일정")
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
       
    }
    
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubviews(dateLabel,
                                     dDayButton,
                                     firstTagButton,
                                     secondTagButton,
                                     thirdTagButton,
                                     locationLabel,
                                     titleLabel,
                                     dateDetailView)
        
        dateDetailView.addSubviews(dateStartTimeLabel, dateTimeLineCollectionView)
    }
    
    override func setLayout() {
        super.setLayout()
        
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

    }
    
    override func setStyle() {
        super.setStyle()
        
        self.contentView.backgroundColor = UIColor(resource: .lilac)

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
            $0.setUpBindings(upcomingDateDetailData: upcomingDataDetailData)
        }
    }
}

extension UpcomingDateDetailViewController {
    
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

}

extension UpcomingDateDetailViewController {
    
    @objc
    func deleteDateCourse() {
        print("delete date course 바텀시트")
    }
}
