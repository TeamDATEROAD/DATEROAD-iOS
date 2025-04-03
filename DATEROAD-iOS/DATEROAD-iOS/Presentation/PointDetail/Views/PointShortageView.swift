//
//  PointShortageView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/2/25.
//

import UIKit

final class PointShortageView: BaseView {
    
    // MARK: - UI Properties
    
    let pointImageView: UIImageView = UIImageView()
    
    let titleLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold15_black))
    
    let descriptionLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.semi13_gray400))

    let rightArrowImageView: UIImageView = UIImageView()
    
    
    // MARK: - LifeCycle
    
    init(pointImage: UIImage, titleText: String, descriptionText: String) {
        self.pointImageView.image = pointImage
        self.titleLabel.text = titleText
        self.descriptionLabel.text = descriptionText
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(pointImageView,
                         titleLabel,
                         descriptionLabel,
                         rightArrowImageView)
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(78)
        }
        
        pointImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(85)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(17)
            $0.leading.equalToSuperview().inset(85)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.verticalEdges.equalToSuperview().inset(31)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setStyle() {
        pointImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
        
        rightArrowImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(resource: .icRightarrowPurple)
        }
    }
    
}

