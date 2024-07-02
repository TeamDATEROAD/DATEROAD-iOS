//
//  ImageCarouselCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class ImageCarouselCell: UICollectionViewCell {
    
    let pageControlView = BottomPageControllView()
    
    static let identifier: String = "ImageCarouselCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Private Methods
private extension ImageCarouselCell {
    func setHierarchy() {
        addSubview(pageControlView)
    }
    
    func setLayout() {
        
    }
    
    func setStyle() {
        pageControlView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)  
        }
    }
    
}



