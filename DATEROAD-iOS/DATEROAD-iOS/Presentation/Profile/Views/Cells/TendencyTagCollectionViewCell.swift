//
//  TendencyTagCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class TendencyTagCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
     var tendencyTagButton:  DRTagButton
    
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        self.tendencyTagButton = DRTagButton(tendencyType: "")
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.contentView.addSubview(tendencyTagButton)
    }
    
    override func setLayout() {
        tendencyTagButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }

    func updateButtonTitle(title: String) {
        self.tendencyTagButton.setTitle(title, for: .normal)
    }
    
}