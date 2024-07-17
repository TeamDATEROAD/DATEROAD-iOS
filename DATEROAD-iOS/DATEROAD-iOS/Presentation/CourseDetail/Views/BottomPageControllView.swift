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
    
    static let elementKinds: String = "bottomPageControllView"
    
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
    
}

private extension BottomPageControllView {

    func updatePageLabel() {
        indexBoxButton.setTitle("\(pageIndex + 1)/\(pageIndexSum)", for: .normal)
    }
    
    func setHierarchy() {
        self.addSubviews(likeBoxView, likeStackView, indexBoxButton)
        likeStackView.addArrangedSubviews(likeButton, likeNumLabel)
    }
    
    func setLayout() {
        likeBoxView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(likeStackView).inset(-10)
            $0.height.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(9)
        }
        
        likeStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalTo(likeBoxView)
        }
        
        indexBoxButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(47)
            $0.height.equalTo(22)
        }
    }
    
    func setStyle() {
        likeBoxView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 11
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
            $0.roundedButton(cornerRadius: 11, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.setTitle("3/10", for: .normal)
            $0.setTitleColor(.drWhite, for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
        }
    }
    
}


