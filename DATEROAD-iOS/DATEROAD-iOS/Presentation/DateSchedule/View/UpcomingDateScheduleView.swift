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
    
var cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var cardPageControl = UIPageControl()
    
    var emptyView = CustomEmptyView()
    
    var dateRegisterButton = UIButton()
    
    var pastDateButton = UIButton()
    
    // MARK: - Properties
    
//    static var dateCardCollectionViewLayout = UICollectionViewFlowLayout()
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel,
                         cardCollectionView,
                         cardPageControl,
                         emptyView,
                         dateRegisterButton,
                         pastDateButton)
    }
    
    override func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateRegisterButton)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        dateRegisterButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
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
            $0.top.equalTo(cardCollectionView.snp.bottom).offset(ScreenUtils.height*0.035)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ScreenUtils.height * 127/812)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 444/812)
        }
        
        pastDateButton.snp.makeConstraints {
            $0.top.equalTo(cardPageControl.snp.bottom).offset(ScreenUtils.height*0.025)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height*0.0541)
            $0.width.equalTo(ScreenUtils.width*0.472)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        titleLabel.do {
            $0.setLabel(text: StringLiterals.DateSchedule.upcomingDate, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_bold_20))
        }
        
        cardCollectionView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.isPagingEnabled = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.clipsToBounds = true
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
        }
        
//        UpcomingDateScheduleView.dateCardCollectionViewLayout.do {
//            $0.scrollDirection = .horizontal
//            $0.minimumLineSpacing = ScreenUtils.width * 0.0693
//            $0.itemSize = CGSize(width: ScreenUtils.width * 0.776, height: ScreenUtils.height*0.5)
//        }
        
        cardPageControl.do {
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(resource: .gray200)
            $0.currentPageIndicatorTintColor = UIColor(resource: .deepPurple)
        }
        
        emptyView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .emptyDateSchedule), emptyTitle: StringLiterals.EmptyView.emptyDateSchedule)
        }
        
        dateRegisterButton.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setImage(UIImage(resource: .plusSchedule), for: .normal)
            $0.roundedButton(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        pastDateButton.do {
            $0.setTitle(StringLiterals.DateSchedule.seePastDate, for: .normal)
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.setTitleColor(UIColor(resource: .drBlack), for: .normal)
            $0.roundedButton(cornerRadius: 13, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
    }
}

// MARK: - Data Binding Methods

extension UpcomingDateScheduleView {
    func updatePageControlSelectedIndex(index: Int) {
        cardPageControl.currentPage = index
    }
}



