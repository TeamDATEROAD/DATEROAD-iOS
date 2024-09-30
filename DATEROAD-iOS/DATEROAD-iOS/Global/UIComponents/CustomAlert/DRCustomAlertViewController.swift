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
    
    private var customAlertView = DRCustomAlertView()
    
    
    // MARK: - Properties
    
    private var rightActionType: RightButtonType
    
    private var alertTextType: AlertTextType
    
    private var alertButtonType: AlertButtonType
    
    private var titleText: String
    
    private var descriptionText: String?
    
    private var longButtonText: String?
    
    private var leftButtonText: String?
    
    private var rightButtonText: String?
    
    var delegate: DRCustomAlertDelegate?
    
    
    // MARK: - LifeCycle
    
    init(rightActionType: RightButtonType,
         alertTextType: AlertTextType,
         alertButtonType: AlertButtonType,
         titleText: String,
         descriptionText: String? = "",
         longButtonText: String? = "",
         leftButtonText: String? = "취소",
         rightButtonText: String? = "") {
        
        self.rightActionType = rightActionType
        self.alertTextType = alertTextType
        self.alertButtonType = alertButtonType
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.longButtonText = longButtonText
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        
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
        
        switch alertButtonType {
        case .oneButton:
            setLongButton(text: longButtonText)
        case .twoButton:
            setLeftButton(text: leftButtonText)
            setRightButton(text: rightButtonText)
        }
    }
    
}

private extension DRCustomAlertViewController {
    
    func setLongButton(text: String?) {
        customAlertView.longButton.isHidden = false
        customAlertView.longButton.setTitle(text, for: .normal)
        customAlertView.longButton.addTarget(self, action: #selector(longButtonTapped), for: .touchUpInside)
    }
    
    func setLeftButton(text: String?) {
        customAlertView.leftButton.isHidden = false
        customAlertView.leftButton.setTitle(text, for: .normal)
        customAlertView.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
    }
    
    func setRightButton(text: String?) {
        customAlertView.rightButton.isHidden = false
        customAlertView.rightButton.setTitle(text, for: .normal)
        customAlertView.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
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
