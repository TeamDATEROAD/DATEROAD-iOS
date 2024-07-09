//
//  BaseNavBarViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/1/24.
//

import UIKit

import SnapKit
import Then

class BaseNavBarViewController: UIViewController {
   
   // MARK: - UI Properties
   
    let topInsetView = UIView()
   
    var navigationBarView = UIView()
   
   var contentView = UIView()
   
   private var leftButton = UIButton()
   
   private var rightButton = UIButton()
   
    var titleLabel = UILabel()
   
   // MARK: - Life Cycles
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
   }
   
   func setHierarchy() {
      self.view.addSubviews(topInsetView, navigationBarView, contentView)
      self.navigationBarView.addSubviews(leftButton, titleLabel, rightButton)
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
          $0.centerY.equalToSuperview()
          $0.horizontalEdges.equalToSuperview().inset(16)
      }
   }
   
   func setStyle() {
      self.view.backgroundColor = .drWhite
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
   
}

// MARK: - NavigationBar Custom Methods

extension BaseNavBarViewController {
   
   func setLeftButtonStyle(image: UIImage?) {
      leftButton.do {
         $0.isHidden = false
         $0.setImage(image, for: .normal)
         setLeftButtonAction(target: self, action: #selector(backButtonTapped))
      }
   }
   
   func setRightButtonStyle(image: UIImage?) {
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
   
   func setLeftBackButton() {
      setLeftButtonStyle(image: UIImage(named: "leftArrow"))
      setLeftButtonAction(target: self, action: #selector(backButtonTapped))
   }
   
    func setTitleLabelStyle(title: String?, alignment: NSTextAlignment) {
      titleLabel.do {
          $0.isHidden = false
          $0.text = title
          $0.font = UIFont(name: "SUIT-Bold", size: 20)
          $0.textColor = .black
          $0.textAlignment = alignment
      }
   }
   
   /// 키보드 외 영역 터치시 키보드 닫기
   func setupKeyboardDismissRecognizer() {
      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      tapRecognizer.cancelsTouchesInView = false
      view.addGestureRecognizer(tapRecognizer)
   }
   
   @objc
   private func dismissKeyboard() {
      view.endEditing(true)
   }
   
   @objc
   func backButtonTapped() {
      navigationController?.popViewController(animated: true)
   }
}
