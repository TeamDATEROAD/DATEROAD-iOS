//
//  PointSystemViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class PointSystemViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let pointSystemView: PointSystemView = PointSystemView()
    
    
    // MARK: - Properties
    
    private var pointSystemViewModel: PointSystemViewModel
    
    
    // MARK: - Life Cycle
    
    init(pointSystemViewModel: PointSystemViewModel) {
        self.pointSystemViewModel = pointSystemViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pointSystemViewModel.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.PointSystem.pointSystem, alignment: .center)
        registerCell()
        setDelegate()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(pointSystemView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        pointSystemView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension PointSystemViewController {
    
    func registerCell() {
        self.pointSystemView.pointSystemCollectionView.register(PointSystemCollectionViewCell.self, forCellWithReuseIdentifier: PointSystemCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.pointSystemView.pointSystemCollectionView.dataSource = self
        self.pointSystemView.pointSystemCollectionView.delegate = self
    }
    
}

extension PointSystemViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = ScreenUtils.width
        return CGSize(width: screenWidth - 32, height: 98)
    }
    
}

extension PointSystemViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pointSystemViewModel.pointSystemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointSystemCollectionViewCell.cellIdentifier, for: indexPath) as? PointSystemCollectionViewCell else { return UICollectionViewCell() }
        cell.bindData(image: self.pointSystemViewModel.pointSystemData[indexPath.item].illustration,
                      mainText: self.pointSystemViewModel.pointSystemData[indexPath.item].mainTitle,
                      subText: self.pointSystemViewModel.pointSystemData[indexPath.item].subTitle)
        return cell
    }
    
}
