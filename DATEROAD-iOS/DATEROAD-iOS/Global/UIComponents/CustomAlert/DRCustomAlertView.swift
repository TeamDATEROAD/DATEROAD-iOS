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
    
    var titleLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold17_black))
    
    var descriptionLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_black), hidden: true)
    
    var longButton: DRTextButton?
    
    var leftButton: DRTextButton?
    
    var rightButton: DRTextButton?
    
    
    init(longButton: DRTextButton?, leftButton: DRTextButton?, rightButton: DRTextButton?) {
        self.longButton = longButton
        self.leftButton = leftButton
        self.rightButton = rightButton
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(alertView)
        
        alertView.addSubviews(titleLabel, descriptionLabel)

        if let longButton = self.longButton {
            alertView.addSubview(longButton)
        }
        
        if let leftButton = self.leftButton {
            alertView.addSubview(leftButton)
        }
        
        if let rightButton = self.rightButton {
            alertView.addSubview(rightButton)
        }
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
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).inset(5)
            $0.height.equalTo(18)
        }
        
        longButton?.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
        }
        
        leftButton?.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
            $0.width.equalTo(ScreenUtils.width * 152 / 375)
        }
        
        rightButton?.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(ScreenUtils.width * 14 / 375)
            $0.height.equalTo(ScreenUtils.height * 48 / 812)
            $0.width.equalTo(ScreenUtils.width * 152 / 375)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.5)
        
        alertView.do {
            $0.roundCorners(cornerRadius: 20)
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
}
