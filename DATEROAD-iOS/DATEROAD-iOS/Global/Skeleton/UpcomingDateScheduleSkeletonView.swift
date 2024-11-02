//
//  UpcomingDateScheduleSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 11/1/24.
//

import UIKit

final class UpcomingDateScheduleSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = UILabel()
    
    private let cardImageView: UIImageView = UIImageView()
    
    private let dateRegisterButton: UIButton = UIButton()
    
    private let pastDateButton: UIView = UIView()
    
    
    // MARK: - LifeCycle
    
    override func setHierarchy() {
        self.addSubviews(titleLabel,
                         cardImageView,
                         dateRegisterButton,
                         pastDateButton)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateRegisterButton)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        dateRegisterButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(44)
        }
        
        cardImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(178)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width * 0.77)
            $0.height.equalTo(ScreenUtils.height*0.5)
        }
        
        pastDateButton.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(ScreenUtils.height*0.07)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height*0.0541)
            $0.width.equalTo(ScreenUtils.width*0.472)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        titleLabel.setLabel(
            text: StringLiterals.DateSchedule.upcomingDate,
            textColor: UIColor(resource: .drBlack),
            font: UIFont.suit(.title_bold_20)
        )
        
        cardImageView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.image = UIImage(resource: .card)
        }

        dateRegisterButton.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setImage(UIImage(resource: .plusSchedule), for: .normal)
            $0.roundedButton(cornerRadius: 15, maskedCorners: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ])
        }
        
        pastDateButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 13, maskedCorners: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ])
        }
    }

}
