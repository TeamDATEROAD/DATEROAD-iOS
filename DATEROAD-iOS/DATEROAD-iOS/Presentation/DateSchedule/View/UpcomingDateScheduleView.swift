//
//  UpcomingDateScheduleView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

protocol UpcomingDateScheduleDelete: AnyObject {
    
    func didTapDateRegisterButton()
    
    func didTapPastDateButton()
    
}

final class UpcomingDateScheduleView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    
    var cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var cardPageControl = UIPageControl()
    
    var emptyView = CustomEmptyView()
    
    var dateRegisterButton: DRImageButton = DRImageButton(image: UIImage(resource: .plusSchedule), buttonName: .med_purple_15)
    
    var pastDateButton = DRTextButton(title: StringLiterals.DateSchedule.seePastDate, buttonName: .bold_gray100_14)
    
    
    // MARK: - Properties
    
    weak var delegate: UpcomingDateScheduleDelete?
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        titleLabel.setLabel(text: StringLiterals.DateSchedule.upcomingDate,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.suit(.title_bold_20))
        
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
        
        cardPageControl.do {
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(resource: .gray200)
            $0.currentPageIndicatorTintColor = UIColor(resource: .deepPurple)
        }
        
        emptyView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .emptyDateSchedule), emptyTitle: StringLiterals.EmptyView.emptyDateSchedule)
        }
    }
    
    func setAddTarget() {
        dateRegisterButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        pastDateButton.addTarget(self, action: #selector(didTapPastDateButton), for: .touchUpInside)
    }
    
}


// MARK: - Data Binding Methods

extension UpcomingDateScheduleView {
    
    func updatePageControlSelectedIndex(index: Int) {
        cardPageControl.currentPage = index
    }
    
}


// MARK: - @objc Methods

extension UpcomingDateScheduleView {
    
    @objc
    func didTapRegisterButton() {
        delegate?.didTapDateRegisterButton()
    }
    
    @objc
    func didTapPastDateButton() {
        delegate?.didTapPastDateButton()
    }
    
}

