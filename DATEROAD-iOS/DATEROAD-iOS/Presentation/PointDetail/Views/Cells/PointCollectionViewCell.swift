//
//  PointCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/4/24.
//

import UIKit

import SnapKit
import Then

final class PointCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private var pointAmountLabel = UILabel()
    
    private var pointDescriptionLabel = UILabel()
    
    private var pointDateLabel = UILabel()
    
    private let cellDivider = UIView()
    
    // MARK: - Properties
    
    var pointItemRow: Int?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setHierarchy() {
        self.addSubviews(pointAmountLabel,
                         pointDescriptionLabel,
                         pointDateLabel,
                         cellDivider)
    }
    
    override func setLayout() {
        pointAmountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(21)
        }
        
        pointDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(105)
            $0.height.equalTo(21)
        }
        
        pointDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45)
            $0.leading.equalToSuperview().inset(105)
            $0.height.equalTo(21)
        }
        
        cellDivider.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        pointAmountLabel.do {
            $0.textColor = UIColor(resource: .drBlack)
            $0.font = UIFont.suit(.body_bold_15)
        }
        
        pointDescriptionLabel.do {
            $0.textColor = UIColor(resource: .gray500)
            $0.font = UIFont.suit(.body_bold_15)
        }
        
        pointDateLabel.do {
            $0.textColor = UIColor(resource: .gray500)
            $0.font = UIFont.suit(.body_med_15)
        }
        
        cellDivider.do {
            $0.backgroundColor = UIColor(resource: .gray100)
        }
    }
    
}

extension PointCollectionViewCell {
    func dataBind(_ pointData : PointDetailModel, _ pointItemRow: Int) {
        self.pointAmountLabel.text = "\(pointData.sign) \(pointData.point ) P"
        self.pointDescriptionLabel.text = pointData.description
        self.pointDateLabel.text = pointData.createdAt
        self.pointItemRow = pointItemRow
    }
}

