//
//  PointSystemCollectionView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class PointSystemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let illustrationView: UIImageView = UIImageView()
    
    private let mainLabel: UILabel = UILabel()
    
    private let subLabel: UILabel = UILabel()
    
    override func setHierarchy() {
        self.addSubviews(illustrationView, mainLabel, subLabel)
    }
    
    override func setLayout() {

        illustrationView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(70)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(14)
            $0.leading.equalTo(illustrationView.snp.trailing).offset(15)
        }
        
        subLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(14)
            $0.leading.equalTo(illustrationView.snp.trailing).offset(15)
        }
    }
    
    // TODO: - 이미지 바인딩 수정 예정
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 14
        }
        
        illustrationView.do {
            $0.clipsToBounds = true
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.layer.cornerRadius = 35
        }
        
        mainLabel.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .drBlack), font: UIFont.suit(.body_bold_15))
            $0.numberOfLines = 2
        }
        
        subLabel.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .gray500), font: UIFont.suit(.body_med_13))
            $0.numberOfLines = 1
        }
    }
    
}

extension PointSystemCollectionViewCell {
    
    func bindData(mainText: String, subText: String) {
        self.mainLabel.text = mainText
        self.subLabel.text = subText
    }
}
