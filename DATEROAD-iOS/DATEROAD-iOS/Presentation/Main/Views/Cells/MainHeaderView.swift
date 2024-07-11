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
    
    func setHierarchy() {
        self.addSubviews(titleLabel, subLabel, viewMoreButton)
    }
    
    func setLayout() {
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
        self.backgroundColor = UIColor(resource: .drWhite)
        
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
    
    func setRoundedView() {
        self.clipsToBounds = true
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    
    func bindTitle(section: MainSection, nickname: String?) {
        let nickname = nickname ?? ""
        
        if section == .hotDateCourse {
            titleLabel.do {
                $0.setAttributedText(fullText: nickname + StringLiterals.Main.hotDateTitle, pointText: nickname+"님,", pointColor: UIColor(resource: .deepPurple), lineHeight: 1.04)
                $0.font = UIFont.suit(.title_extra_24)
                $0.textAlignment = .left
                $0.numberOfLines = 2
            }
            
            subLabel.do {
                $0.text = StringLiterals.Main.hotDateSub
            }
        } else {
            titleLabel.do {
                $0.setLabel(text: StringLiterals.Main.newDateTitle, alignment: .left, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_extra_20))
                $0.textAlignment = .left
                $0.numberOfLines = 0
            }
            
            subLabel.do {
                $0.text = StringLiterals.Main.newDateSub
            }
        }
    }
}
