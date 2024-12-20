//
//  PointDetailView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import UIKit

final class PointDetailView: BaseView {
    
    // MARK: - UI Properties
    
    private let pointView = UIView()
    
    var userNameLabel = UILabel()
    
    var totalPointLabel = UILabel()
    
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
        self.addSubviews(pointView,
                         segmentControl,
                         segmentControlUnderLineView,
                         selectedSegmentUnderLineView,
                         pointCollectionView,
                         emptyUsedPointView,
                         emptyGainedPointView)
        
        self.pointView.addSubviews(userNameLabel, totalPointLabel)
    }
    
    override func setLayout() {
        pointView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(16)
            $0.height.equalTo(18)
        }
        
        totalPointLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(45)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(31)
        }
        
        segmentControl.snp.makeConstraints{
            $0.top.equalTo(pointView.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
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
            $0.bottom.equalToSuperview().inset(34)
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
        pointView.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        }
        
        userNameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            $0.textColor = UIColor(resource: .drWhite)
            $0.textAlignment = .left
        }
        
        totalPointLabel.do {
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drWhite)
            $0.textAlignment = .left
        }
        
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
