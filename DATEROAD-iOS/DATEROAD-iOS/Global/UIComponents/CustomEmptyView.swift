//
//  CustomEmptyView.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class CustomEmptyView: BaseView {
    
    // MARK: - UI Properties

    let imageView = UIImageView()
    
    let titleLabel = UILabel()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(imageView, titleLabel)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height * 394 / 812)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(50)
        }
    }
    
    override func setStyle() {
        imageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.setLabel(alignment: .center, textColor: UIColor(resource: .gray300), font: UIFont.suit(.title_bold_18))
            $0.lineBreakMode = .byWordWrapping
        }
    }
    
}

extension CustomEmptyView {
    func setEmptyView(emptyImage: UIImage, emptyTitle: String) {
        imageView.image = emptyImage
        titleLabel.text = emptyTitle
    }
}

