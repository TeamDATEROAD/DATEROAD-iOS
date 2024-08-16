//
//  GradientView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/7/24.
//

import UIKit

import SnapKit
import Then

class GradientView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let gradientView = UIView()
    
    private let gradient = CAGradientLayer()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
    func setHierarchy() {
        self.addSubview(gradientView)
    }
    
    func setLayout() {
        gradientView.layer.addSublayer(gradient)
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        gradientView.backgroundColor = .clear
        
        gradient.do {
            $0.locations = [0, 1]
            $0.startPoint = CGPoint(x: 0.5, y: 0.0)
            $0.endPoint = CGPoint(x: 0.5, y: 1.0)
            $0.colors = [UIColor(resource: .drBlack).withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        }
    }
}
