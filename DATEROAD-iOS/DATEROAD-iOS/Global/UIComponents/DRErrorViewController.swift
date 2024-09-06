//
//  DRErrorView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/16/24.
//

import UIKit

final class DRErrorViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let errorImageView: UIImageView = UIImageView()
    
    private let mainErrorMessageLabel: UILabel = UILabel()
    
    private let subErrorMessageLabel: UILabel = UILabel()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
    }

    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(errorImageView, mainErrorMessageLabel, subErrorMessageLabel)
    }
    
    override func setLayout() {
        super.setLayout()
        
        errorImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(206)
        }
        
        mainErrorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(errorImageView.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
        }
        
        subErrorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(mainErrorMessageLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
                
        errorImageView.do {
            $0.image = UIImage(resource: .error)
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        mainErrorMessageLabel.setLabel(text: StringLiterals.Network.mainErrorMessage,
                        numberOfLines: 1,
                        textColor: UIColor(resource: .gray300),
                        font: UIFont.suit(.title_extra_20))
        
        subErrorMessageLabel.setLabel(text: StringLiterals.Network.subErrorMessage,
                        numberOfLines: 2,
                        textColor: UIColor(resource: .gray300),
                        font: UIFont.suit(.body_med_15) )
    }
    
}
