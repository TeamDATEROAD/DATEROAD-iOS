//
//  DateScheduleDeleteView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import UIKit

protocol DateScheduleDeleteDelegate: AnyObject {
    
    func didTapDeleteSchedule()
    
}

final class DateScheduleDeleteView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel: DRTextLabel = DRTextLabel(title: StringLiterals.DateSchedule.dateSetting, textLabelType: .clear(.bold18_black))
    
    var deleteButton: DRTextButton = DRTextButton(title: StringLiterals.DateSchedule.deleteDate, buttonName: .semi_white_0)
    
    
    // MARK: - Properties
    
    weak var delegate: DateScheduleDeleteDelegate?
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(titleLabel, deleteButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        deleteButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.height.equalTo(60)
        }
    }
    
}


// MARK: - @objc Methods

extension DateScheduleDeleteView {
    
    func setAddTarget() {
        deleteButton.addTarget(self, action: #selector(didTapDeleteDateSchedule), for: .touchUpInside)
    }
    
}

// MARK: - @objc Methods

extension DateScheduleDeleteView {
    
    @objc
    func didTapDeleteDateSchedule() {
        delegate?.didTapDeleteSchedule()
    }
    
}
