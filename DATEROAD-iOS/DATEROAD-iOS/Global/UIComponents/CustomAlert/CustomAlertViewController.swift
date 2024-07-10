//
//  CustomAlertViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/10/24.
//

import UIKit

class CustomAlertViewController: BaseViewController {
    // MARK: - UI Properties
    
    private var customAlertView = CustomAlertView()
    
    
    // MARK: - Properties
    
    private var alertTextType: AlertTextType
    
    private var alertButtonType: AlertButtonType

    private var titleText: String
    
    private var descriptionText: String?
    
    private var longButtonText: String?
    
    private var longButtonAction: Selector?
    
    private var leftButtonText: String?
    
    private var leftButtonAction: Selector?
    
    private var rightButtonText: String?
    
    private var rightButtonAction: Selector?
    
    
    // MARK: - LifeCycle
    
    init(alertTextType: AlertTextType,
         alertButtonType: AlertButtonType,
         titleText: String,
         descriptionText: String?,
         longButtonText: String?,
         longButtonAction: Selector?,
         leftButtonText: String?,
         leftButtonAction: Selector?,
         rightButtonText: String?,
         rightButtonAction: Selector?) {
        
        self.alertTextType = alertTextType
        self.alertButtonType = alertButtonType
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.longButtonText = longButtonText
        self.longButtonAction = longButtonAction
        self.leftButtonText = leftButtonText
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
        self.rightButtonText = rightButtonText
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setHierarchy() {
        self.view.addSubviews(customAlertView)
    }
    
    override func setLayout() {
        customAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension CustomAlertViewController {
    func setUI() {
        customAlertView.titleLabel.text = titleText
        
        switch alertTextType {
        case .hasDecription:
            customAlertView.descriptionLabel.text = descriptionText
            customAlertView.titleBottomInset = 92
        case .noDescription:
            customAlertView.titleBottomInset = 99
        }
        
        switch alertButtonType {
        case .oneButton:
            setLongButton(text: longButtonText, action: longButtonAction ?? #selector(defaultAction))
        case .twoButton:
            setLeftButton(text: leftButtonText, action: leftButtonAction ?? #selector(defaultAction))
            setLeftButton(text: rightButtonText, action: rightButtonAction ?? #selector(defaultAction))
        }
    }
}

private extension CustomAlertViewController {
    func setLongButton(text: String?, action: Selector) {
        customAlertView.longButton.isHidden = false
        customAlertView.longButton.setTitle(text, for: .normal)
        customAlertView.longButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func setLeftButton(text: String?, action: Selector) {
        customAlertView.leftButton.isHidden = false
        customAlertView.leftButton.setTitle(text, for: .normal)
        customAlertView.leftButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func setRightButton(text: String?,action: Selector) {
        customAlertView.rightButton.isHidden = false
        customAlertView.rightButton.setTitle(text, for: .normal)
        customAlertView.rightButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    @objc
    func defaultAction() {
        print("저런...에러남...ㅜㅜ")
    }
    
}
