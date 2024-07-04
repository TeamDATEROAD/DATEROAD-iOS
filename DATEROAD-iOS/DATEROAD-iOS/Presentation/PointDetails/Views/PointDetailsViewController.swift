//
//  PointDetailsViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/3/24.
//

import UIKit

import SnapKit
import Then

class PointDetailsViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let pointView = UIView()
    
    private var namePointLabel = UILabel()
    
    private var totalPointLabel = UILabel()
    
    private var segmentControl = UISegmentedControl(items: ["획득 내역", "사용 내역"])
    
    private let segmentControlUnderLineView = UIView()
    
    private let selectedSegmentUnderLineView = UIView()
    
    private var pointEarnedCollectionView = PointCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var pointUsedCollectionView = PointCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
    
    private let pointViewModel = PointViewModel()
    
    private lazy var earnedPointDummyData = pointViewModel.earnedPointDummyData
    
    private lazy var usedPointDummyData = pointViewModel.usedPointDummyData
    
    private var isEarnedPointHidden : Bool? {
        didSet {
            guard let isEarnedPointHidden = self.isEarnedPointHidden else { return }
            self.pointEarnedCollectionView.isHidden = isEarnedPointHidden
            self.pointUsedCollectionView.isHidden = !self.pointEarnedCollectionView.isHidden
        }
    }
    
    private let segmentBackgroundImage = UIImage()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBackButton()
        setTitleLabelStyle(title: "포인트 내역")
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(pointView, segmentControl, segmentControlUnderLineView, selectedSegmentUnderLineView, pointEarnedCollectionView, pointUsedCollectionView)
        self.pointView.addSubviews(namePointLabel, totalPointLabel)
    }
    
    override func setLayout() {
        super.setLayout()
        
        pointView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        namePointLabel.snp.makeConstraints{
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
        
        pointEarnedCollectionView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34)
        }
        
        pointUsedCollectionView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34)
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        pointView.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        }
        
        namePointLabel.do {
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .drWhite)
            $0.textAlignment = .left
            $0.text = "\(pointViewModel.pointUserDummyData.userName ?? "00") 님의 포인트"
        }
        
        totalPointLabel.do {
            $0.font = UIFont.suit(.title_extra_24)
            $0.textColor = UIColor(resource: .drWhite)
            $0.textAlignment = .left
            $0.text = "\(pointViewModel.pointUserDummyData.totalPoint ?? 0) P"
        }
        
        segmentControl.do {
            $0.selectedSegmentIndex = 0
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.suit(.body_bold_17), NSAttributedString.Key.foregroundColor: UIColor(resource: .gray300)], for: .normal)
            $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.suit(.body_bold_17), NSAttributedString.Key.foregroundColor: UIColor(resource: .drBlack)], for: .selected)
            $0.setBackgroundImage(segmentBackgroundImage, for: .normal, barMetrics: .default)
            $0.setDividerImage(segmentBackgroundImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
            $0.tintColor = .clear
            $0.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        }
        
        segmentControlUnderLineView.do {
            $0.backgroundColor = UIColor(resource: .gray300)
        }
        
        selectedSegmentUnderLineView.do {
            $0.backgroundColor = UIColor(resource: .drBlack)
        }
        
        pointEarnedCollectionView.do {
            $0.setUpBindings(pointData: earnedPointDummyData)
        }
        
        pointUsedCollectionView.do {
            $0.setUpBindings(pointData: usedPointDummyData)
        }

    }

}

// MARK: - Private Method

private extension PointDetailsViewController {
    @objc func didChangeValue(segment: UISegmentedControl) {
        self.isEarnedPointHidden = self.segmentControl.selectedSegmentIndex != 0
        changeSelectedSegmentUnderLineLayout()
    }
    
    func changeSelectedSegmentUnderLineLayout() {
        guard let isEarnedPointHidden = self.isEarnedPointHidden else { return }
        if isEarnedPointHidden {
            self.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().inset(ScreenUtils.width/2)
            }
        } else {
            self.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview()
            }
        }
    }
    
}
