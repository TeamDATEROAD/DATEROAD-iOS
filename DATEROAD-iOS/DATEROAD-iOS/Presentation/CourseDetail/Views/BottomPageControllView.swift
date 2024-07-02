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
        self.addSubviews(heartButton, indexBox)
    }
    
    func setLayout() {
        heartButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
            $0.width.equalTo(31)
            $0.height.equalTo(20)
        }
        
        indexBox.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
    }
    
    func setStyle() {
        heartButton.do {
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setTitle("5", for: .normal)
        }
        
        indexBox.do {
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.setTitle("3/10", for: .normal)
        }
    }
    
}

