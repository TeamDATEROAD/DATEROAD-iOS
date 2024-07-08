//
//  BaseTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var cellIdentifier: String {
        return String(describing: BaseCollectionViewCell.self)
    }
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
    }
    
}
