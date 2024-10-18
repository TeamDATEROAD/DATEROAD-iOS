//
//  DateScheduleDeleteView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import UIKit

final class DateScheduleDeleteView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = UILabel()
    
    var deleteLabel: UILabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel, deleteLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        deleteLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.height.equalTo(60)
        }
    }
    
    override func setStyle() {
        titleLabel.do {
            $0.setLabel(text: StringLiterals.DateSchedule.dateSetting,
                        alignment: .center,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.title_bold_18))
        }
        
        deleteLabel.do {
            $0.setLabel(text: StringLiterals.DateSchedule.deleteDate,
                        alignment: .center,
                        textColor: UIColor(resource: .deepPurple),
                        font: UIFont.suit(.body_semi_15))
            $0.isUserInteractionEnabled = true
        }
    }
    
}
