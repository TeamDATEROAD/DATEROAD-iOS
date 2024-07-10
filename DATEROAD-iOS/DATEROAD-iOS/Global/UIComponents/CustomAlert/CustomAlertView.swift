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
    
    var titleBottomInset: Int = 115
    
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
            $0.width.equalToSuperview()
            $0.height.equalTo(24)
            
            $0.bottom.equalToSuperview().inset(titleBottomInset)
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
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(48)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.5)
        
        titleLabel.do {
            $0.setLabel(alignment: .center, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_17))
        }
        
        descriptionLabel.do {
            $0.setLabel(alignment: .center, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_med_13))
            $0.isHidden = true
        }
        
        longButton.do {
            $0.setButtonStatus(buttonType: AlertRightButton())
        }
        
        leftButton.do {
            $0.setButtonStatus(buttonType: AlertLeftButton())
        }
        
        rightButton.do {
            $0.setButtonStatus(buttonType: AlertRightButton())
        }
    }
        
    
}
