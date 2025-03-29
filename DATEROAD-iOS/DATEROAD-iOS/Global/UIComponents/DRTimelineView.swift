//
//  DRTimelineView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 3/24/25.
//

import UIKit

final class DRTimelineView: BaseView {
    
    // MARK: - UI Properties
    
    var locationLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold15_black), alignment: .left)
    
    var addressLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_gray300), alignment: .left)
    
    private let timeBoxView = UIView()
    
    var timeLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_black), alignment: .left)
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(locationLabel,
                         addressLabel,
                         timeBoxView,
                         timeLabel)
    }
    
    override func setLayout() {
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(14+59)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(13)
            $0.width.equalTo(207)
        }
        
        timeBoxView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(13)
            $0.width.equalTo(59)
            $0.height.equalTo(28)
        }
        
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(timeBoxView)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = .clear
        
        timeBoxView.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
        }
    }
    
}




