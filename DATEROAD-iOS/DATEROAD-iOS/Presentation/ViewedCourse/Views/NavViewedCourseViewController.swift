//
//  NavViewedCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

import SnapKit
import Then

class NavViewedCourseViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    private var courseCollectionView = MyCourseListCollectionView()
    
    // MARK: - Properties
    
    private let viewedCourseViewModel = MyCourseListViewModel()
    
    private lazy var viewedCourseData = viewedCourseViewModel.viewedCourseDummyData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: "내가 열람한 코스", alignment: .center)
        register()
        setDelegate()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(courseCollectionView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        courseCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        self.view.backgroundColor = UIColor(resource: .drWhite)
    }

}

// MARK: - CollectionView Methods

extension NavViewedCourseViewController {
    private func register() {
        courseCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
    }
}

// MARK: - Delegate

extension NavViewedCourseViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 140)
    }
}

// MARK: - DataSource

extension NavViewedCourseViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewedCourseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(viewedCourseData[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
        return cell
    }
    
    @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: courseCollectionView)
        let indexPath = courseCollectionView.indexPathForItem(at: location)

       if let index = indexPath {
           print("일정 등록 페이지로 이동 \(viewedCourseData[indexPath?.item ?? 0].courseID ?? 0)")
       }
    }
    
}
