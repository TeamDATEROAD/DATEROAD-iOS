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
    
    // MARK: - UI Properties
    
    private let heartButton: UIButton = UIButton()
    private let indexBoxButton: UIButton = UIButton()
    
    // MARK: - Properties
    
    static let elementKinds: String = "footer"
    static let identifier: String = "BottomPageControllView"
    
    var pageIndex: Int = 0 {
        didSet {
            updatePageLabel()
        }
    }
    
    var pageIndexSum: Int = 0 {
        didSet {
            updatePageLabel()
        }
    }
    
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
    
    private func updatePageLabel() {
        indexBoxButton.setTitle("\(pageIndex + 1)/\(pageIndexSum)", for: .normal)
    }
    
}

private extension BottomPageControllView {
    
    func setHierarchy() {
        self.addSubviews(heartButton, indexBoxButton)
    }
    
    func setLayout() {
        heartButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(31)
            $0.height.equalTo(20)
        }
        
        indexBoxButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
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
        
        indexBoxButton.do {
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.setTitle("3/10", for: .normal)
        }
    }
    
}


