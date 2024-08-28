//
//  BannerInfoHeaderView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/19/24.
//

import UIKit

import SnapKit
import Then

final class BannerInfoHeaderView: UICollectionReusableView {

    // MARK: - UI Properties
    
    private let tagLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let visitDateLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    static let elementKinds: String = StringLiterals.Elementkinds.bannerInfoHeaderView
    
    static let identifier: String = String(describing: BannerInfoHeaderView.self)

    
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
    
    func bindTitle(tagLabel: String, visitDate: String) {
        self.tagLabel.text = tagLabel
        
        if let formattedDate = visitDate.formatDateFromString(inputFormat: "yyyy.MM.dd", outputFormat: "yyyy년 M월 d일 방문") {
            visitDateLabel.text = formattedDate
        } else {
            print("날짜 포맷 변환에 실패했습니다.")
        }
    }
    
}

private extension BannerInfoHeaderView {
    
    func setHierarchy() {
        self.addSubviews(tagLabel, visitDateLabel)
    }
    
    func setLayout() {
        tagLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    func setStyle() {
        tagLabel.do {
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.setPadding(top: 2, left: 10, bottom: 2, right: 10)
            $0.backgroundColor = UIColor(resource: .mediumPurple)
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_semi_13))
        }
        
        visitDateLabel.do {
            $0.setLabel(textColor: UIColor(resource: .gray400), font: UIFont.suit(.body_semi_15))
        }
    }
    
}
