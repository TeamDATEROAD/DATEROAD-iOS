//
//  SplashView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import UIKit

final class SplashView: BaseView {
    
    // MARK: - UI Properties
    
    private let splashLogo: UIImageView = UIImageView()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(splashLogo)
    }
    
    override func setLayout() {
        splashLogo.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .deepPurple)
        
        splashLogo.do {
            $0.image = UIImage(resource: .splashLogo)
            $0.contentMode = .scaleAspectFit
        }
    }
    
}
