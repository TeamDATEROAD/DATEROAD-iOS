//
//  BottomPageControllView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/2/24.
//

import UIKit

import SnapKit
import Then

class BottomPageControllView: UICollectionReusableView {
    
    private let heartButton: UIButton = UIButton()
    private let indexBox: UIButton = UIButton()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension BottomPageControllView {
    
    func setHierarchy() {
        self.addSubviews()
        
    }
    
    func setLayout() {
        
    }
    
    func setStyle() {
        
    }
    
}

