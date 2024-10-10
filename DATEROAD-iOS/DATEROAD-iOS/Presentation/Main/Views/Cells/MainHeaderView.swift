//
//  MainHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

import SnapKit
import Then

final class MainHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    let titleLabel: UILabel = UILabel()
    
    let subLabel: UILabel = UILabel()
    
    let viewMoreButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    static let elementKinds: String = StringLiterals.Common.header
    
    static let identifier: String = String(describing: MainHeaderView.self)
    
    
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
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subLabel.text = nil
    }
    
    func setHierarchy() {
        self.addSubview(backgroundView)
        backgroundView.addSubviews(titleLabel, subLabel, viewMoreButton)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
        }
        
        viewMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(subLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .deepPurple)
        
        backgroundView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
        
        subLabel.do {
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .gray400), font: UIFont.suit(.body_med_13))
        }
        
        viewMoreButton.do {
            $0.setTitle(StringLiterals.Main.viewMore, for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_13)
            $0.setTitleColor(UIColor(resource: .mediumPurple), for: .normal)
        }
    }
    
}


// MARK: - Extensions

extension MainHeaderView {
    
    func bindTitle(section: MainSection, nickname: String?) {
        let nickname = nickname ?? ""
        
        if section == .hotDateCourse {
            titleLabel.do {
                $0.setAttributedText(fullText: nickname + StringLiterals.Main.hotDateTitle,
                                     pointText: nickname+"님,",
                                     pointColor: UIColor(resource: .deepPurple), lineHeight: 1.04)
                $0.font = UIFont.suit(.title_extra_24)
                $0.textAlignment = .left
                $0.numberOfLines = 2
            }
            self.backgroundView.clipsToBounds = true
            self.backgroundView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
            subLabel.text = StringLiterals.Main.hotDateSub
        } else {
            self.backgroundView.clipsToBounds = false
            self.backgroundView.roundCorners(cornerRadius: 0, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
            titleLabel.do {
                $0.setLabel(text: StringLiterals.Main.newDateTitle,
                            alignment: .left,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.suit(.title_extra_20))
                $0.textAlignment = .left
                $0.numberOfLines = 0
            }
            subLabel.text = StringLiterals.Main.newDateSub
        }
    }
    
}
