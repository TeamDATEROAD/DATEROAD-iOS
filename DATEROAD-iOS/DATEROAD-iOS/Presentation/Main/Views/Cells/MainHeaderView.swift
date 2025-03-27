//
//  MainHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

import SnapKit
import Then

protocol MainHeaderDelegate: AnyObject {
    
    func didTapViewMoreButton()
    
}

final class MainHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let backgroundView: UIView = UIView()
    
    let titleLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold24_black),
        alignment: .left,
        numberOfLines: 2
    )
    
    let subLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_gray400), alignment: .left)
    
    let viewMoreButton: DRTextButton = DRTextButton(title: StringLiterals.Main.viewMore, buttonName: .bold_white_0)
    
    
    // MARK: - Properties
    
    weak var delegate: MainHeaderDelegate?
    
    static let elementKinds: String = StringLiterals.Common.header
    
    static let identifier: String = String(describing: MainHeaderView.self)
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
        setAddTarget()
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
        backgroundView.addSubviews(
            titleLabel,
            subLabel,
            viewMoreButton
        )
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
        self.backgroundColor = UIColor(resource: .purple600)
        
        backgroundView.backgroundColor = UIColor(resource: .drWhite)
    }
    
}


// MARK: - Extensions

extension MainHeaderView {
    
    func setAddTarget() {
        viewMoreButton.addTarget(self, action: #selector(didTapViewMoreButton), for: .touchUpInside)
    }
    
    func bindTitle(section: MainSection, nickname: String?) {
        let nickname = nickname ?? ""
        
        if section == .hotDateCourse {
            self.backgroundView.clipsToBounds = true
            self.backgroundView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
            titleLabel.setProperties(nickname + StringLiterals.Main.hotDateTitle, .clear(.systemBold24_black), .left, 2)
            titleLabel.setAttributedText(fullText: nickname + StringLiterals.Main.hotDateTitle,
                                     pointText: nickname+"님,",
                                     pointColor: UIColor(resource: .purple600),
                                     lineHeight: 1.04)
            subLabel.text = StringLiterals.Main.hotDateSub
        } else {
            self.backgroundView.clipsToBounds = false
            self.backgroundView.roundCorners(cornerRadius: 0, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
            titleLabel.setProperties(StringLiterals.Main.newDateTitle, .clear(.extra20_black), .left, 0)
            subLabel.text = StringLiterals.Main.newDateSub
        }
    }
    
}


// MARK: - @objc Methods

private extension MainHeaderView {
    
    @objc
    func didTapViewMoreButton() {
        delegate?.didTapViewMoreButton()
    }
    
}
