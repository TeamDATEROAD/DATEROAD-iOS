//
//  LocationCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/4/24.
//

import UIKit

final class TimelineInfoCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let courseTimelineView = DRTimelineView()
    
    
    // MARK: - Properties
    
    var dateDetailItemRow: Int?
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubview(courseTimelineView)
    }
    
    override func setLayout() {
        courseTimelineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension TimelineInfoCell {
    
    func setCell(timelineData: TimelineModel) {
        courseTimelineView.do {
            $0.indexNumLabel.text = "\(timelineData.sequence)"
            $0.locationLabel.text = timelineData.title
            $0.timeLabel.text = "\(timelineData.duration.formatFloatTime())시간"
        }
    }
    
}

