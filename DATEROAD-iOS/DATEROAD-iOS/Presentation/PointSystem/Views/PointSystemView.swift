//
//  PointSystemView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class PointSystemView: BaseView {
    
    // MARK: - UI Properties
    
    private let mainLabel: UILabel = UILabel()

    private let subLabel: UILabel = UILabel()

    let pointSystemCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(mainLabel, subLabel, pointSystemCollectionView)
    }
    
    override func setLayout() {
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            
        }
        
        pointSystemCollectionView.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        mainLabel.do {
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.font = UIFont.suit(.title_extra_20)
            $0.setAttributedText(fullText: StringLiterals.Onboarding.firstMainInfoLabel,
                                 pointText: StringLiterals.Onboarding.firstMainPoint,
                                 pointColor: UIColor(resource: .deepPurple),
                                 lineHeight: 1.04)
        }
        
        subLabel.do {
            $0.numberOfLines = 0
            $0.setLabel(text: StringLiterals.PointSystem.subTitle,
                        alignment: .left,
                        textColor: UIColor(resource: .gray500),
                        font: UIFont.suit(.body_med_15) )
        }
        
        pointSystemCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
}
