//
//  DateTicketView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/11/24.
//

import UIKit

final class DateTicketView: BaseView {
    
    // MARK: - UI Properties
    
    private let ticketImage: UIImageView = UIImageView()
    
    private let dDayLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let dateNameLabel: UILabel = UILabel()
    
    private let dateLabel: UILabel = UILabel()
    
    private let startTimeLabel: UILabel = UILabel()
    
    private let emptyDateLabel: UILabel = UILabel()
    
    private let goToRegisterLabel: UILabel = UILabel()
    
    let moveButton: UIButton = UIButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(ticketImage,
                         dDayLabel,
                         dateNameLabel,
                         dateLabel,
                         startTimeLabel,
                         moveButton)
    }
    
    override func setLayout() {
        ticketImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.height.equalTo(19)
            $0.leading.equalToSuperview().inset(16)
        }
        
        dateNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(88)
            $0.top.equalTo(dDayLabel.snp.bottom).offset(6)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        startTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(19)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        moveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(44)
        }
    }
    
    override func setStyle() {
        ticketImage.do {
            $0.image = UIImage(resource: .ticket)
            $0.contentMode = .scaleAspectFill
        }
        
        dDayLabel.do {
            $0.roundedLabel(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_bold_13))
            $0.setPadding(top: 0, left: 10, bottom: 0, right: 10)
            $0.backgroundColor = UIColor(resource: .deepPurple)
        }
        
        dateNameLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.systemFont(ofSize: 20,weight: .bold))
            $0.lineBreakMode = .byTruncatingTail
            $0.numberOfLines = 1
            $0.textAlignment = .left
        }
        
        dateLabel.do {
            $0.setLabel(textColor: UIColor(resource: .lightPurple), font: UIFont.suit(.body_med_15))
        }
        
        startTimeLabel.do {
            $0.setLabel(textColor: UIColor(resource: .lightPurple), font: UIFont.suit(.body_med_15))
        }
        
        moveButton.do {
            $0.setImage(UIImage(resource: .icRightarrowPurple), for: .normal)
        }
    }
    
}

extension DateTicketView {
    
    func bindData(data: UpcomingDateModel) {
        self.dDayLabel.text = data.dDay == 0 ? "D-Day" : "D-\(data.dDay)"
        self.dateNameLabel.text = data.dateName
        self.dateLabel.text = "\(data.month)월 \(data.day)일"
        self.startTimeLabel.text = "\(data.startAt) 시작"
    }
    
}
