//
//  PointDetailsViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/3/24.
//

import UIKit

import SnapKit
import Then

class PointDetailsViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    private let pointView = UIView()
    
    private var namePointLabel = UILabel()
    
    private var totalPointLabel = UILabel()
    
    private let segmentControl = UISegmentedControl()
    
    private var pointCollectionView = UICollectionView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBackButton()
        setTitleLabelStyle(title: "포인트 내역")
    }
    
    override func setHierarchy() {
        // self.contentView.addSubviews(pointView, segmentControl, pointCollectionView)
        self.pointView.addSubviews(namePointLabel, totalPointLabel)
    }
    
    override func setLayout() {
    }
    
    

   

}
