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
    
    private let dDayLabel: DRTextLabel = DRTextLabel(textLabelType: .background(.bold13_white, .deepPurple_10))
    
    private let dateNameLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold20_white),
        alignment: .left,
        numberOfLines: 1
    )
    
    private let dateLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med15_purple400))
    
    private let startTimeLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med15_purple400))
    
    let moveButton: DRImageButton = DRImageButton(image: UIImage(resource: .icRightarrowPurple), buttonName: .clear_mediumPurple_0)
    
    
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
        
        dDayLabel.setPadding(top: 0, left: 10, bottom: 0, right: 10)
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
