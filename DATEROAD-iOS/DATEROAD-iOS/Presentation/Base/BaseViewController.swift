//
//  BaseViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import UIKit

import Lottie
import SnapKit
import Then

class BaseViewController: UIViewController {
   
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    let lottieView = LottieAnimationView(name: "loading")
    
    
   // MARK: - Life Cycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setHierarchy()
      setLayout()
      setStyle()
   }
   
   func setHierarchy() {}
   
   func setLayout() {}
   
   func setStyle() {
      self.view.backgroundColor = .drWhite
      self.navigationController?.navigationBar.isHidden = true
      self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
   }
    
    func showLoadingView() {
        // 로딩 뷰 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()
        
        backgroundView.backgroundColor = UIColor(resource: .drWhite)
        
        // 로딩 뷰를 화면에 추가
        self.view.addSubviews(backgroundView, lottieView)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func hideLoadingView() {
        // 로딩 뷰 중지 및 제거
        lottieView.stop()
        backgroundView.removeFromSuperview()
        lottieView.removeFromSuperview()
    }
   
    func presentAlertVC(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: StringLiterals.Alert.confirm, style: .cancel))
        self.present(alert, animated: true)
    }
}
