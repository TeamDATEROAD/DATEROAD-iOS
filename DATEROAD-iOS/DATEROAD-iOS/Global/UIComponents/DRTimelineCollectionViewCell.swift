//
//  DRTimelineCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 3/26/25.
//

import UIKit

final class DRTimelineCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let sequenceLabel = DRTextLabel(textLabelType: .background(.bold13_white, .purple600_12_circle))
    
    let timelineView = DRTimelineView()
    
    
    // MARK: - Properties
    
    var dateDetailItemRow: Int?
    
    var type: TimelineType
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        self.type = .course
        
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(sequenceLabel, timelineView)
    }
    
    override func setLayout() {
        sequenceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        timelineView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(14)
        }
    }
    
    override func setStyle() {
        self.roundCorners(cornerRadius: 14)
        self.backgroundColor = .gray100
    }
}


// MARK: - dataBind

extension DRTimelineCollectionViewCell {
    
    func dataBind(_ timelineData: TimelineModel) {
        self.sequenceLabel.text = self.type == .course ? "\(timelineData.sequence)" : "\(timelineData.sequence+1)"
        timelineView.do {
            $0.locationLabel.text = timelineData.title
            // TODO: 추후 수정
            $0.addressLabel.text = "서울특별시 데로구 데로로 1"
            $0.timeLabel.text = "\(timelineData.duration)시간"
        }
    }
    
}
