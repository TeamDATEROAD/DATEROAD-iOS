//
//  BaseViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 6/26/24.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }

    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        self.view.backgroundColor = .drWhite
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
