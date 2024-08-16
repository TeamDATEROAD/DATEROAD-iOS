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
    
    private let loadingMessageLabel: UILabel = UILabel()
    

    override func setHierarchy() {
        self.addSubviews(loadingImageView, loadingMessageLabel)
    }
    
    override func setLayout() {
        loadingImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(142 + UIApplication.shared.statusBarFrame.size.height)
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
        
        loadingMessageLabel.setLabel(text: StringLiterals.Network.loadingMessage,
                        numberOfLines: 2,
                        textColor: UIColor(resource: .gray500),
                        font: UIFont.suit(.title_bold_18) )
    }
}
