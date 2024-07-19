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
    
    private var myRegisterCourseView = MyCourseListView()
    
    // MARK: - Properties
    
    private let myRegisterCourseViewModel = MyCourseListViewModel()
    
    // MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        bindViewModel()
        loadDataAndReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.MyRegisterCourse.title, alignment: .center)
        bindViewModel()
        register()
        setDelegate()
        loadDataAndReload()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(myRegisterCourseView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        myRegisterCourseView.snp.makeConstraints {
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

// MARK: - EmptyView Methods

extension MyRegisterCourseViewController {
    private func setEmptyView() {
        if let dataCount = myRegisterCourseViewModel.myRegisterCourseData.value?.count, dataCount == 0 {
            myRegisterCourseView.emptyView.do {
                $0.isHidden = false
                $0.setEmptyView(emptyImage: UIImage(resource: .emptyMyRegisterCourse),
                 emptyTitle: StringLiterals.EmptyView.emptyMyRegisterCourse)
            }
        } else {
            myRegisterCourseView.emptyView.isHidden = true
        }
    }
}

// MARK: - DataBind

extension MyRegisterCourseViewController {
    func bindViewModel() {
        self.myRegisterCourseViewModel.isSuccessGetMyRegisterCourseInfo.bind { [weak self] isSuccess in
            guard let self = self else { return }
            guard let isSuccess else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    self.myRegisterCourseView.myCourseListCollectionView.reloadData()
                    self.setEmptyView()
                }
            }
        }
    }

    private func loadDataAndReload() {
        self.myRegisterCourseViewModel.setMyRegisterCourseData()
    }
    
}

// MARK: - CollectionView Methods

extension MyRegisterCourseViewController {
    private func register() {
        myRegisterCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        myRegisterCourseView.myCourseListCollectionView.delegate = self
        myRegisterCourseView.myCourseListCollectionView.dataSource = self
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
        return myRegisterCourseViewModel.myRegisterCourseData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(myRegisterCourseViewModel.myRegisterCourseData.value?[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
        return cell
    }
    
    @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: myRegisterCourseView.myCourseListCollectionView)
        let indexPath = myRegisterCourseView.myCourseListCollectionView.indexPathForItem(at: location)

       if let index = indexPath {
           let courseId = myRegisterCourseViewModel.myRegisterCourseData.value?[indexPath?.item ?? 0].courseId ?? 0
           self.navigationController?.pushViewController(CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId)), animated: true)
       }
    }
    
}
