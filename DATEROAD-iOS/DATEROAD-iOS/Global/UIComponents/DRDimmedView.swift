//
//  DRDimmedView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

protocol DimmedViewDelegate: AnyObject {
    
    func didTapDimmedView()
    
}

extension DimmedViewDelegate {
    
    func didTapDimmedView() {}
    
}

final class DRDimmedView: BaseView {    
    
    // MARK: - Properties
    
    weak var delegate: DimmedViewDelegate?
    
    
    // MARK: - Life Cycles
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = UIColor(resource: .drBlack).withAlphaComponent(0.4)
            $0.alpha = 0
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
    }
    
}


// MARK: - @objc Methods

extension DRDimmedView {
    
    @objc
    func didTapDimmedView() {
        delegate?.didTapDimmedView()
    }
    
}
