//
//  EmptyTicketView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/11/24.
//

import UIKit

final class EmptyTicketView: BaseView {
    
    // MARK: - UI Properties
    
    private let ticketImage: UIImageView = UIImageView()
    
    private let emptyDateLabel: UILabel = UILabel()
    
    private let goToRegisterLabel: UILabel = UILabel()
    
    let moveButton: UIButton = UIButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(ticketImage,
                         emptyDateLabel,
                         goToRegisterLabel,
                         moveButton)
    }
    
    override func setLayout() {
        ticketImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(23)
        }
        
        goToRegisterLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(23)
        }
        
        moveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(44)
        }
    }
    
    override func setStyle() {
        ticketImage.do {
            $0.image = UIImage(resource: .ticket)
            $0.contentMode = .scaleAspectFill
        }
        
        emptyDateLabel.setLabel(text: StringLiterals.Main.emptyDateTitle,
                                alignment: .left,
                                textColor: UIColor(resource: .drWhite),
                                font: UIFont.suit(.title_bold_18))
        
        goToRegisterLabel.setLabel(text: StringLiterals.Main.emptyDateSub,
                                   alignment: .left,
                                   textColor: UIColor(resource: .lightPurple),
                                   font: UIFont.suit(.body_med_15))
        
        moveButton.setImage(UIImage(resource: .icPlus), for: .normal)
    }
    
}
