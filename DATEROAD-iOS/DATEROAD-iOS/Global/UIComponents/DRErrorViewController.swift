//
//  DRErrorView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 8/16/24.
//

import UIKit

final class DRErrorViewController: BaseNavBarViewController {
   
   // MARK: - Properties
   // 콜백 클로저 정의
   var onDismiss: (() -> Void)?
    
    // MARK: - UI Properties
    
    private let errorImageView: UIImageView = UIImageView()
    
    private let mainErrorMessageLabel: UILabel = UILabel()
    
    private let subErrorMessageLabel: UILabel = UILabel()
    
    
    // MARK: - Life Cycles
   
   // VC 닫힐 때에 호출
   override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      
      onDismiss?()
   }
    
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
            $0.top.equalToSuperview().offset(132)
        }
        
        mainErrorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(errorImageView.snp.bottom).offset(30)
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
                        textColor: UIColor(resource: .gray500),
                        font: UIFont.suit(.title_extra_20))
        
        subErrorMessageLabel.setLabel(text: StringLiterals.Network.subErrorMessage,
                        numberOfLines: 2,
                        textColor: UIColor(resource: .gray500),
                        font: UIFont.suit(.body_med_15) )
    }
    
}
