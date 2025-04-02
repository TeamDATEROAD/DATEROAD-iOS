//
//  PointDetailView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import UIKit

final class PointDetailView: BaseView {
    
    // MARK: - UI Properties
    
    var userNameLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold13_gray400), alignment: .left)
    
    var totalPointLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.extra24_black), alignment: .left)
    
    let pointAddButton: DRTextButton = DRTextButton(title: "포인트 모으러 가기", buttonName: .bold_purple_14)
    
    var segmentControl = UISegmentedControl(items: [StringLiterals.PointDetail.gainedDetail, StringLiterals.PointDetail.usedDetail])
    
    private let segmentControlUnderLineView = UIView()
    
    let selectedSegmentUnderLineView = UIView()
    
    var pointCollectionView = PointCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var emptyGainedPointView = CustomEmptyView()
    
    var emptyUsedPointView = CustomEmptyView()
    
    
    // MARK: - Properties
    
    private let segmentBackgroundImage = UIImage()
    
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(userNameLabel,
                         totalPointLabel,
                         pointAddButton,
                         segmentControl,
                         segmentControlUnderLineView,
                         selectedSegmentUnderLineView,
                         pointCollectionView,
                         emptyUsedPointView,
                         emptyGainedPointView)
    }
    
    override func setLayout() {
        userNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14 * ScreenUtils.height / 812)
            $0.leading.equalToSuperview().inset(16 * ScreenUtils.width / 375)
            $0.height.equalTo(18)
        }
        
        totalPointLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(42 * ScreenUtils.height / 812)
            $0.leading.equalToSuperview().inset(16 * ScreenUtils.width / 375)
            $0.height.equalTo(31)
        }
        
        pointAddButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(93 * ScreenUtils.height / 812)
            $0.horizontalEdges.equalToSuperview().inset(16 * ScreenUtils.width / 375)
            $0.height.equalTo(54 * ScreenUtils.height / 812)
        }
        
        segmentControl.snp.makeConstraints{
            $0.top.equalToSuperview().offset(167 * ScreenUtils.height / 812)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54 * ScreenUtils.height / 812)
        }
        
        segmentControlUnderLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        selectedSegmentUnderLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentControl.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        pointCollectionView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34 * ScreenUtils.height / 812)
        }
        
        emptyGainedPointView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 444/812)
        }
        
        emptyUsedPointView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 444/812)
        }
    }
    
    override func setStyle() {
        segmentControl.do {
            $0.selectedSegmentIndex = 0
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.suit(.body_bold_17), NSAttributedString.Key.foregroundColor: UIColor(resource: .gray300)], for: .normal)
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.suit(.body_bold_17), NSAttributedString.Key.foregroundColor: UIColor(resource: .drBlack)], for: .selected)
            $0.setBackgroundImage(segmentBackgroundImage, for: .normal, barMetrics: .default)
            $0.setDividerImage(segmentBackgroundImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
            $0.tintColor = .clear
        }
        
        segmentControlUnderLineView.do {
            $0.backgroundColor = UIColor(resource: .gray300)
        }
        
        selectedSegmentUnderLineView.do {
            $0.backgroundColor = UIColor(resource: .drBlack)
        }
        
        pointCollectionView.do {
            $0.isHidden = true
        }
        
        emptyGainedPointView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .emptyGainedPoint),
                            emptyTitle: StringLiterals.EmptyView.emptyGainedPoint)
        }
        
        emptyUsedPointView.do {
            $0.isHidden = true
            $0.setEmptyView(emptyImage: UIImage(resource: .emptyUsedPoint),
                            emptyTitle: StringLiterals.EmptyView.emptyUsedPoint)
        }
    }
    
}
