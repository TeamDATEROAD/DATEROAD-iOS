//
//  UpcomingDateScheduleView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateScheduleView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    
    var cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: dateCardCollectionViewLayout)
    
    var cardPageControl = UIPageControl()
    
    var dateRegisterButton = UIButton()
    
    var pastDateButton = UIButton()
    
    // MARK: - Properties
    
    static var dateCardCollectionViewLayout = UICollectionViewFlowLayout()
    
    lazy var upcomingDateScheduleData = DateScheduleModel(dateCards: [])
    
    var currentIndex: CGFloat = 0
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel,
                          cardCollectionView,
                          cardPageControl,
                          dateRegisterButton,
                          pastDateButton)
    }
    
    override func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        dateRegisterButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(63)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(44)
        }
        
        cardCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(178)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height*0.5)
        }
        
        cardPageControl.snp.makeConstraints {
            $0.top.equalTo(cardCollectionView.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        pastDateButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(127)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(177)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        titleLabel.do {
            $0.font = UIFont.suit(.title_bold_20)
            $0.textColor = UIColor(resource: .drBlack)
            $0.text = "데이트 일정"
        }
        
        cardCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.isPagingEnabled = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.clipsToBounds = true
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
        }
        
        UpcomingDateScheduleView.dateCardCollectionViewLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = ScreenUtils.width * 0.0693
            $0.itemSize = CGSize(width: ScreenUtils.width * 0.776, height: ScreenUtils.height*0.5)
        }
        
        cardPageControl.do {
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(resource: .gray200)
            $0.currentPageIndicatorTintColor = UIColor(resource: .deepPurple)
        }
        
        dateRegisterButton.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setImage(UIImage(resource: .plusSchedule), for: .normal)
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        pastDateButton.do {
            $0.setTitle("지난 데이트 보기", for: .normal)
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.setTitleColor(UIColor(resource: .drBlack), for: .normal)
            $0.roundedButton(cornerRadius: 13, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
    }
}

extension UpcomingDateScheduleView {
    func updatePageControlSelectedIndex(index: Int) {
        cardPageControl.currentPage = index
    }
}



