//
//  SplashViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

final class SplashViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let splashView = SplashView()
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.pushToLoginVC()
        }
    }

    override func setHierarchy() {
        self.view.addSubview(splashView)
    }

    override func setLayout() {
        splashView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(ScreenUtils.height / 812 * 210)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = UIColor(resource: .deepPurple)
    }
    
}

extension SplashViewController {
    
    func pushToLoginVC() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}

