//
//  DRCustomeAlertView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/18/24.
//

import UIKit

final class DRCustomAlertView: BaseView {
    
    // MARK: - UI Properties
    
    private var alertView = UIView()
    
    var titleLabel = UILabel()
    
    var descriptionLabel = UILabel()
    
    var longButton = UIButton()
    
    var leftButton = UIButton()
    
    var rightButton = UIButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(alertView)
        
        alertView.addSubviews(titleLabel,
                              descriptionLabel,
                              longButton,
                              leftButton,
                              rightButton)
    }
    
    override func setLayout() {
        alertView.snp.makeConstraints {
            $0.width.equalTo(ScreenUtils.width * 343 / 375)
            $0.height.equalTo(ScreenUtils.height * 162 / 812)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(ScreenUtils.height * 23 / 812)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(ScreenUtils.height * 52 / 812)
        }
        
        longButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
        }
        
        leftButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
            $0.width.equalTo(ScreenUtils.width * 152 / 375)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
            $0.width.equalTo(ScreenUtils.width * 152 / 375)
            $0.leading.equalTo(leftButton.snp.trailing).offset(ScreenUtils.width * 11 / 375)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.5)
        
        alertView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner,
                                                              .layerMaxXMinYCorner,
                                                              .layerMinXMaxYCorner,
                                                              .layerMinXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        titleLabel.setLabel(alignment: .center,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.body_bold_17))
        
        descriptionLabel.do {
            $0.setLabel(alignment: .center,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.body_med_13))
            $0.isHidden = true
        }
        
        longButton.do {
            $0.setButtonStatus(buttonType: AlertRightButton())
            $0.isHidden = true
        }
        
        leftButton.do {
            $0.setButtonStatus(buttonType: AlertLeftButton())
            $0.isHidden = true
        }
        
        rightButton.do {
            $0.setButtonStatus(buttonType: AlertRightButton())
            $0.isHidden = true
        }
    }
    
}
