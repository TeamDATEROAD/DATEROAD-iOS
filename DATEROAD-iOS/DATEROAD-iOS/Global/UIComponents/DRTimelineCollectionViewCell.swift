//
//  DRTimelineCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 3/26/25.
//

import UIKit

final class DRTimelineCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
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
        self.addSubview(timelineView)
    }
    
    override func setLayout() {
        timelineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension DRTimelineCollectionViewCell {
    
    func dataBind(_ timelineData: TimelineModel) {
        timelineView.do {
            $0.indexNumLabel.text = self.type == .course ? "\(timelineData.sequence)" : "\(timelineData.sequence+1)"
            $0.locationLabel.text = timelineData.title
            $0.timeLabel.text = "\(timelineData.duration)시간"
        }
    }
    
}
