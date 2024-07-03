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
    
    private let likeBoxView = UIView()
    
    private let likeButton = UIImageView(image: .heartIcon)
    
    private let likeNumLabel = UILabel()
    
    private var likeStackView = UIStackView()
    
    private let indexBoxButton = UIButton()
    
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
        self.addSubviews(likeBoxView, likeStackView, indexBoxButton)
        likeStackView.addArrangedSubviews(likeButton, likeNumLabel)
    }
    
    func setLayout() {
        
        likeBoxView.snp.makeConstraints {
            $0.leading.trailing.equalTo(likeStackView).inset(-7)
            $0.height.equalTo(20)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(7)
        }
        
        likeStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.centerY.equalTo(indexBoxButton)
        }
        
        indexBoxButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
    }
    
    func setStyle() {
        likeBoxView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor(resource: .deepPurple)
        }
        
        likeNumLabel.do {
            $0.text = "5"
            $0.textColor = UIColor(resource: .drWhite)
            $0.font = UIFont.suit(.body_bold_13)
        }
        
        likeStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 3
        }
        
        indexBoxButton.do {
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.setTitle("3/10", for: .normal)
            $0.setTitleColor(.drWhite, for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_13)
        }
    }
    
}


