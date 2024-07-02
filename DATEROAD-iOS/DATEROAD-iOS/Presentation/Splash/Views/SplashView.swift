//
//  SplashView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

final class SplashView: BaseView {
    
    // MARK: - UI Properties
    
    private let splashLabel: UILabel = UILabel()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(splashLabel)
    }
    
    override func setLayout() {
        splashLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        splashLabel.do {
            $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            $0.textColor = .black
            $0.text = StringLiterals.Login.splash
        }
    }

}
