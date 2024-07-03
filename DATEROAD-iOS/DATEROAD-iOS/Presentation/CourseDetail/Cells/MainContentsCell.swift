//
//  MainContentsCell.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//

import UIKit

import SnapKit
import Then


final class MainContentsCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "MainContentsCell"

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
private extension MainContentsCell {
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
     
    }
    
    func setStyle() {

    }

}




