//
//  CustomBarViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/1/24.
//

import UIKit

import SnapKit
import Then

class CustomBarViewController: UIViewController {

    // MARK: - UI Properties
    private let topInsetView = UIView()
    
    private var navigationBarView = UIView()
    
    private var contentView = UIView()
    
    private var leftButton = UIButton()
    
    private var rightButton = UIButton()
    
    private var titleLabel = UILabel()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }

}

private extension CustomBarViewController {
    func setHierarchy() {
        self.view.addSubviews(topInsetView, navigationBarView, contentView)
        self.navigationBarView.addSubviews(leftButton, titleLabel, titleLabel)
    }
    
    func setLayout() {
        topInsetView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(topInsetView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(55) //임시 네비바 높이
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18) //탭바 확정 후 다시 수정 - 메인화면 로고 패딩과 다른 백버튼 패딩이 다름
        }
        
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)//탭바 확정 후 다시 수정 - 메인화면 로고 패딩과 다른 백버튼 패딩이 다름 22
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setStyle() {
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        leftButton.do {
            $0.isHidden = true
        }
        
        rightButton.do {
            $0.isHidden = true
        }
        
        titleLabel.do {
            $0.isHidden = true
        }
    }
    
    func setLeftBackButton() {
        leftButton.do {
            $0.isHidden = false
            $0.setImage(UIImage(named: "leftArrow"), for: .normal)
        }
    }
    
    func setLeftCustomButton(image: UIImage) {
        leftButton.do {
            $0.isHidden = false
            $0.setImage(image, for: .normal)
        }
    }
    
    func setRightCustomButton(image: UIImage) {
        rightButton.do {
            $0.isHidden = false
            $0.setImage(image, for: .normal)
        }
    }
    
    func setLeftButtonAction(target: Any, action: Selector) {
        leftButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setRightButtonAction(target: Any, action: Selector) {
        rightButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
