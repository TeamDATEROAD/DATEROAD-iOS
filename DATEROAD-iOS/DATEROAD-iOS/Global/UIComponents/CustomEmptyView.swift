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
    
    let titleLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.bold18_gray300))
    
    var height: CGFloat
    
    init(height: CGFloat = ScreenUtils.height * 394 / 812) {
        self.height = height
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(imageView, titleLabel)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(-40)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        imageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
    }
    
}

extension CustomEmptyView {
    
    func setEmptyView(emptyImage: UIImage, emptyTitle: String) {
        imageView.image = emptyImage
        titleLabel.text = emptyTitle
    }
    
}

