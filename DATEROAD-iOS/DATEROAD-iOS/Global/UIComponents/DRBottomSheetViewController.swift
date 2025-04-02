//
//  DRAlertViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class DRBottomSheetViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let dimmedView: DRDimmedView = DRDimmedView()

    private let bottomSheetView: UIView = UIView()
    
    var contentView: UIView
    
    private let bottomButton: DRTextButton
    
    
    // MARK: - Properties
    
    private var height: CGFloat
            
    weak var delegate: DRBottomSheetDelegate?
    
    
    // MARK: - Life Cycle
    
    init(contentView: UIView, height: CGFloat, buttonType: DRTextButton) {
        self.contentView = contentView
        self.height = height
        self.bottomButton = buttonType
        
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
        self.view.addSubviews(dimmedView, bottomSheetView)
        
        bottomSheetView.addSubviews(contentView, bottomButton)
    }
    
    override func setLayout() {
        dimmedView.snp.makeConstraints {
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
        self.bottomSheetView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        self.contentView.do {
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
    func setBottomButtonByType() {
        switch bottomButton.titleLabel?.text {
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
        self.delegate?.didTapBottomButton()
    }
    
    // TODO: - 이거 사용 안하는 거 같은데,,,,? 추후 수정
    @objc
    func didTapTopLabel() {
        self.delegate?.didTapFirstLabel()
    }
    
    // TODO: - 이거 사용 안하는 거 같은데,,,,? 추후 수정
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
                self.dimmedView.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: false, completion: completion)
            })
        } else {
            self.dimmedView.alpha = 0
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    private func animateBottomSheetPresentation(animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: self.height)
            self.dimmedView.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.dimmedView.alpha = 1
                self.bottomSheetView.transform = .identity
            }, completion: { _ in
                completion?()
            })
        } else {
            self.dimmedView.alpha = 1
            completion?()
        }
    }
    
}
