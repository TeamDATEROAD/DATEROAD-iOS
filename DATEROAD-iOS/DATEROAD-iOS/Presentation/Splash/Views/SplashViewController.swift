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
    
    
    // MARK: - UI Properties
    
    private var splashViewModel: SplashViewModel
    
    
    // MARK: - Life Cycle
    
    init(splashViewModel: SplashViewModel) {
        self.splashViewModel = splashViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.splashViewModel.checkIsLoginned()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.checkIsLoginned()
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
    
    func checkIsLoginned() {
        guard let isLoginned = self.splashViewModel.isLoginned.value else { return }
        isLoginned ? pushToMainVC() : pushToLoginVC()
    }
    
    func pushToLoginVC() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
    func pushToMainVC() {
        let mainVC = TabBarController()
        self.navigationController?.pushViewController(mainVC, animated: false)
    }
    
}

