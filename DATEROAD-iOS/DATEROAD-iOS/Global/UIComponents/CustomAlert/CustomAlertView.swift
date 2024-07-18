//
//  CustomAlertView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/10/24.
//

import UIKit

class CustomAlertView: BaseView {
    
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
            $0.width.equalTo(343)
            $0.height.equalTo(162)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(21)
            $0.bottom.equalToSuperview().inset(92)
        }
        
        longButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(48)
        }
        
        leftButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(48)
            $0.width.equalTo(153)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(48)
            $0.leading.equalTo(leftButton.snp.trailing).offset(10)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.5)
    
        alertView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        titleLabel.do {
            $0.setLabel(alignment: .center, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_17))
        }
        
        descriptionLabel.do {
            $0.setLabel(alignment: .center, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_med_13))
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
