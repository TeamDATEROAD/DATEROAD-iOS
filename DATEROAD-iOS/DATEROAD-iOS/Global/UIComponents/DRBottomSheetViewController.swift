//
//  DRAlertViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class DRBottomSheetViewController: BaseViewController {
    
    // MARK: - UI Properties
        
    private let bottomSheetView: UIView = UIView()
    
    var contentView: UIView
    
    private let bottomButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private var height: CGFloat
    
    private var buttonType: DRButtonType
    
    private var buttonTitle: String
    
    
    // MARK: - Life Cycle
    
    init(contentView: UIView, height: CGFloat, buttonType: DRButtonType, buttonTitle: String) {
        self.contentView = contentView
        self.height = height
        self.buttonType = buttonType
        self.buttonTitle = buttonTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBottomButtonByType()
    }
    
    override func setHierarchy() {
        self.view.addSubview(bottomSheetView)
        bottomSheetView.addSubviews(contentView, bottomButton)
    }
    
    override func setLayout() {
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(self.height)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(bottomButton.snp.top).offset(-14)
        }
        
        bottomButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.4)
        }
        
        self.bottomSheetView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.contentView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.contentView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.bottomButton.do {
            $0.setButtonStatus(buttonType: buttonType)
            $0.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    func setBottomButtonByType() {
        switch buttonTitle {
        case StringLiterals.Common.cancel:
            self.bottomButton.isEnabled = true
            self.bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        default:
            self.bottomButton.isEnabled = false
        }
    }
    
    @objc
    func didTapBottomButton() {
        self.dismiss(animated: true)
    }
    
}
