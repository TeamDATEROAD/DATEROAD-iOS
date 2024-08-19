//
//  BannerImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/11/24.
//

import UIKit

final class BannerIndexFooterView: UICollectionReusableView {
    
    // MARK: - UI Properties
            
    let indexLabel: DRPaddingLabel = DRPaddingLabel()
    
    
    // MARK: - Properties

    static let elementKinds: String = StringLiterals.Common.footer

    static let identifier: String = StringLiterals.Identifier.bannerFooter
    
    
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
    
    func setHierarchy() {
        self.addSubview(indexLabel)
    }
    
    func setLayout() {
        indexLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.width.equalTo(35)
        }
    }
    
    func setStyle() {
        self.backgroundColor = .clear

        indexLabel.do {
            $0.textAlignment = .center
            $0.backgroundColor = UIColor(resource: .gray400)
            $0.textColor = UIColor(resource: .drWhite)
            $0.font = UIFont.suit(.cap_reg_11)
            $0.setPadding(top: 2, left: 0, bottom: 2, right: 0)
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
    }
}

extension BannerIndexFooterView {
    
    func bindIndexData(currentIndex: Int, count: Int) {
        self.indexLabel.text = "\(currentIndex + 1)/\(count)"
    }
}
