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
    
    private let mainLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold15_black), alignment: .left, numberOfLines: 2)
    
    private let subLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med13_gray400), alignment: .left, numberOfLines: 1)
    
    
    // MARK: - Life Cycles
    
    override func setHierarchy() {
        self.addSubviews(
            illustrationView,
            mainLabel,
            subLabel
        )
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
    }
    
}


// MARK: - Methods

extension PointSystemCollectionViewCell {
    
    func bindData(image: UIImage, mainText: String, subText: String) {
        self.illustrationView.image = image
        self.mainLabel.text = mainText
        self.subLabel.text = subText
    }
    
}
