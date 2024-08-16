//
//  DRErrorView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/16/24.
//

import UIKit

final class DRErrorView: BaseView {
    
    // MARK: - UI Properties
    
    private let errorImageView: UIImageView = UIImageView()
    
    private let errorMessageLabel: UILabel = UILabel()
    

    override func setHierarchy() {
        self.addSubviews(errorImageView, errorMessageLabel)
    }
    
    override func setLayout() {
        errorImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(202 + UIApplication.shared.statusBarFrame.size.height)
        }
        
        errorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(errorImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(170)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        errorImageView.do {
            $0.image = UIImage(resource: .error)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        errorMessageLabel.setLabel(text: StringLiterals.Network.errorMessage,
                        numberOfLines: 2,
                        textColor: UIColor(resource: .gray500),
                        font: UIFont.suit(.title_bold_18) )
    }
}
