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
    
    
    // MARK: - UI Properties
    
    var onDismiss: (() -> Void)?
    
    
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
    
    func showLoadingView(type: String? = nil) {
        // 로딩 뷰 설정
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play()
        
        backgroundView.backgroundColor = UIColor(resource: .drWhite)
        
        // 로딩 뷰를 화면에 추가
        self.view.addSubviews(backgroundView, lottieView)
        
        if type == nil {
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            lottieView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        } else {
            backgroundView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(188)
                $0.bottom.equalToSuperview().inset(view.frame.height * 0.11)
                $0.horizontalEdges.equalToSuperview()
            }
            
            lottieView.snp.makeConstraints {
                $0.verticalEdges.equalTo(backgroundView)
                $0.horizontalEdges.equalToSuperview()
            }
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
        let alertAction = UIAlertAction(title: StringLiterals.Alert.confirm, style: .cancel) { _ in
            self.navigationController?.popToRootViewController(animated: false)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
}
