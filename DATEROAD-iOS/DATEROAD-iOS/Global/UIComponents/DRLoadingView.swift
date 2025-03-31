//
//  DRLoadingView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/16/24.
//

import UIKit

final class DRLoadingView: BaseView {
    
    // MARK: - UI Properties
    
    private let loadingImageView: UIImageView = UIImageView()
    
    private let loadingMessageLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.Network.loadingMessage,
        textLabelType: .clear(.bold18_gray500),
        numberOfLines: 2
    )
    
    override func setHierarchy() {
        self.addSubviews(loadingImageView, loadingMessageLabel)
    }
    
    override func setLayout() {
        loadingImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(176)
        }
        
        loadingMessageLabel.snp.makeConstraints {
            $0.top.equalTo(loadingImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(146)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        loadingImageView.do {
            $0.image = UIImage(resource: .loading)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
    }
    
}
