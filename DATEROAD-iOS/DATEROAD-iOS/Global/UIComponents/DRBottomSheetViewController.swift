//
//  DRAlertViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class DRBottomSheetViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    private let bottomSheetView: UIView = UIView()
    
    var contentView: UIView
    
    private let bottomButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private var height: CGFloat
    
    private var buttonType: DRButtonType
    
    private var buttonTitle: String
    
    weak var delegate: DRBottomSheetDelegate?
    
    
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
        self.view.addSubview(backgroundView)
        self.view.addSubview(bottomSheetView)
        bottomSheetView.addSubviews(contentView, bottomButton)
    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(self.height)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomButton.snp.top).offset(-14)
        }
        
        bottomButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(38)
        }
    }
    
    override func setStyle() {
        self.backgroundView.do {
            $0.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.4)
            $0.alpha = 0
        }
        
        self.bottomSheetView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.contentView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.bottomButton.do {
            $0.setButtonStatus(buttonType: buttonType)
            $0.setTitle(self.buttonTitle, for: .normal)
        }
    }
    
    func setBottomButtonByType() {
        switch buttonTitle {
        case StringLiterals.Common.cancel, StringLiterals.AddCourseOrSchedule.AddBottomSheetView.datePickerBtnTitle:
            self.bottomButton.isEnabled = true
            self.bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        case StringLiterals.Common.close:
            self.bottomButton.isEnabled = true
            self.bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        default:
            self.bottomButton.isEnabled = false
        }
    }
    
    @objc
    func didTapBottomButton() {
        print("Bottom button tapped")
        self.delegate?.didTapBottomButton()
    }
    
    @objc
    func didTapTopLabel() {
        self.delegate?.didTapFirstLabel()
    }
    
    @objc
    func didTapBottomLabel() {
        self.delegate?.didTapSecondLabel()
    }
    
}

extension DRBottomSheetViewController {
    
    func presentBottomSheet(in viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false) {
            self.animateBottomSheetPresentation(animated: animated, completion: completion)
        }
    }
    
    func dismissBottomSheet(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: self.height)
            }, completion: { _ in
                self.backgroundView.alpha = 0
                self.dismiss(animated: false, completion: completion)
            })
        } else {
            self.backgroundView.alpha = 0
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    private func animateBottomSheetPresentation(animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: self.height)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.backgroundView.alpha = 1
                self.bottomSheetView.transform = .identity
            }, completion: { _ in
                completion?()
            })
        } else {
            self.backgroundView.alpha = 1
            completion?()
        }
    }
    
}
