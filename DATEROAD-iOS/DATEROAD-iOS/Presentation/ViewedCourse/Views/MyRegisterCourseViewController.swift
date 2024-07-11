//
//  MyRegisterCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import UIKit

import SnapKit
import Then

class MyRegisterCourseViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    private var courseCollectionView = MyCourseListCollectionView()
    
    // MARK: - Properties
    
    private let myRegisterCourseViewModel = MyCourseListViewModel()
    
    private lazy var myRegisterCourseData = myRegisterCourseViewModel.myRegisterCourseDummyData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: "내가 등록한 코스", alignment: .center)
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

extension MyRegisterCourseViewController {
    private func register() {
        courseCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
    }
}

// MARK: - Delegate

extension MyRegisterCourseViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 140)
    }
}

// MARK: - DataSource

extension MyRegisterCourseViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRegisterCourseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(myRegisterCourseData[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
        return cell
    }
    
    @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: courseCollectionView)
        let indexPath = courseCollectionView.indexPathForItem(at: location)

       if let index = indexPath {
           print("코스 상세 페이지로 이동 \(myRegisterCourseData[indexPath?.item ?? 0].courseID ?? 0)")
       }
    }
    
}
