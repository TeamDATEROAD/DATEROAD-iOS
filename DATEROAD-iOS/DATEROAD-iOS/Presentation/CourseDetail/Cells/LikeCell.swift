//
//  LikeCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class LikeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "LikeCell"

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
private extension LikeCell {
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
     
    }
    
    func setStyle() {

    }

}




