//
//  PointSystemView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class PointSystemView: BaseView {
    
    // MARK: - UI Properties
    
    private let mainLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.extra20_black), alignment: .left, numberOfLines: 2)
    
    private let subLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.PointSystem.subTitle,
        textLabelType: .clear(.med15_gray500),
        alignment: .left
    )
    
    let pointSystemCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(
            mainLabel,
            subLabel,
            pointSystemCollectionView
        )
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
        mainLabel.setAttributedText(
            fullText: StringLiterals.Onboarding.firstMainInfoLabel,
            pointText: StringLiterals.Onboarding.firstMainPoint,
            pointColor: UIColor(resource: .purple600),
            lineHeight: 1.04
        )
        
        pointSystemCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = UIColor(resource: .drWhite)
        }
    }
    
}
