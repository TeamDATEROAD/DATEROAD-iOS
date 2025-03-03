//
//  CustomAlertViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/10/24.
//

import UIKit

import SnapKit

protocol DRCustomAlertDelegate {
    
    func action(rightButtonAction: RightButtonType)
    
    func exit()
    
    func leftButtonAction(rightButtonAction: RightButtonType)
    
}

extension DRCustomAlertDelegate {
    
    func action(rightButtonAction: RightButtonType) {}
    
    func exit() {}
    
    func leftButtonAction(rightButtonAction: RightButtonType) {}
    
}

final class DRCustomAlertViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var customAlertView: DRCustomAlertView
    
    private var longButton: DRTextButton?
    
    private var leftButton: DRTextButton?
    
    private var rightButton: DRTextButton?
    
    
    // MARK: - Properties
    
    private var rightActionType: RightButtonType
    
    private var alertTextType: AlertTextType
        
    private var titleText: String
    
    private var descriptionText: String?
    
    var delegate: DRCustomAlertDelegate?
    
    
    // MARK: - LifeCycle
    
    init(rightActionType: RightButtonType,
         alertTextType: AlertTextType,
         titleText: String,
         descriptionText: String? = "",
         longButton: DRTextButton? = nil,
         leftButton: DRTextButton? = nil,
         rightButton: DRTextButton? = nil) {
        self.rightActionType = rightActionType
        self.alertTextType = alertTextType
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.longButton = longButton
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.customAlertView = DRCustomAlertView(
            longButton: longButton,
            leftButton: leftButton,
            rightButton: rightButton
        )
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(customAlertView)
    }
    
    override func setLayout() {
        customAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = .clear
    }
    
}

extension DRCustomAlertViewController {
    
    func setUI() {
        customAlertView.titleLabel.text = titleText
        
        switch alertTextType {
        case .hasDecription:
            customAlertView.descriptionLabel.isHidden = false
            customAlertView.descriptionLabel.text = descriptionText
            customAlertView.titleLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(115)
            }
            
        case .noDescription:
            customAlertView.titleLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(99)
            }
        }
        
        if let longButton = self.longButton {
            customAlertView.longButton?.addTarget(self, action: #selector(longButtonTapped), for: .touchUpInside)
        }
        
        if let leftButton = self.leftButton, let rightButton = self.rightButton {
            customAlertView.leftButton?.addTarget(self, action: #selector(longButtonTapped), for: .touchUpInside)
            customAlertView.rightButton?.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        }
    }
    
}

private extension DRCustomAlertViewController {
    
    @objc
    func longButtonTapped() {
        self.dismiss(animated: false) {
            self.delegate?.exit()
        }
    }
    
    @objc
    func leftButtonTapped() {
        self.dismiss(animated: false) {
            self.delegate?.leftButtonAction(rightButtonAction: self.rightActionType)
            self.delegate?.exit()
        }
    }
    
    @objc
    func rightButtonTapped() {
        self.dismiss(animated: false) {
            self.delegate?.action(rightButtonAction: self.rightActionType)
        }
    }
    
}
