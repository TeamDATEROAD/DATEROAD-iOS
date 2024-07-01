//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/1/24.
//


import UIKit

import SnapKit
import Then

class CourseDetailViewViewController: UIViewController {

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
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

