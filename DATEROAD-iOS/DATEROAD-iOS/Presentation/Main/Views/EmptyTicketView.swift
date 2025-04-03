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
    
    private let emptyDateLabel: DRTextLabel = DRTextLabel(
        textLabelType: .clear(.systemBold20_white),
        alignment: .left,
        numberOfLines: 1
    )
    
    private let goToRegisterLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.med15_purple400))
    
    let moveButton: DRImageButton = DRImageButton(image: UIImage(resource: .icPlus), buttonName: .clear_mediumPurple_0)
    
    
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
    }
    
}
