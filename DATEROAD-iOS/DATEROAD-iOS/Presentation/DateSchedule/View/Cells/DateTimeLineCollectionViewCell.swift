//
//  DateTimeLineCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

final class DateTimeLineCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    let dateTimelineView = DRTimelineView()
    
    
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
        self.addSubview(dateTimelineView)
    }
    
    override func setLayout() {
        dateTimelineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension DateTimeLineCollectionViewCell {
    
    func dataBind(_ placeData: DatePlaceModel, _ dateDetailItemRow: Int) {
        dateTimelineView.do {
            $0.indexNumLabel.text = "\(placeData.sequence+1)"
            $0.locationLabel.text = placeData.name
            $0.timeLabel.text = "\(placeData.duration) 시간"
        }
        self.dateDetailItemRow = dateDetailItemRow
    }
    
}







