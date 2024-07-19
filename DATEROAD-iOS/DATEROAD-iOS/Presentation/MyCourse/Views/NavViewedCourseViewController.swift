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
    
    private var navViewedCourseView = MyCourseListView()
    
    // MARK: - Properties
    
    private let viewedCourseViewModel = MyCourseListViewModel()
    
    // MARK: - LifeCycle
    
   override func viewWillAppear(_ animated: Bool) {
      viewedCourseViewModel.setMyRegisterCourseData()
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.ViewedCourse.title, alignment: .center)
        register()
        setDelegate()
        bindViewModel()
        setEmptyView()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(navViewedCourseView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        navViewedCourseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        self.view.backgroundColor = UIColor(resource: .drWhite)
    }

}

// MARK: - EmptyView Methods

extension NavViewedCourseViewController {
    private func setEmptyView() {
        if viewedCourseViewModel.viewedCourseData.value?.count == 0 {
            navViewedCourseView.emptyView.do {
                $0.isHidden = false
                $0.setEmptyView(emptyImage: UIImage(resource: .emptyPastSchedule),
                                emptyTitle: StringLiterals.EmptyView.emptyNavViewedCourse)
            }
        } else {
            navViewedCourseView.emptyView.do {
                $0.isHidden = true
            }
        }
    }
}

// MARK: - DataBind

extension NavViewedCourseViewController {
    func bindViewModel() {
        self.viewedCourseViewModel.isSuccessGetViewedCourseInfo.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.navViewedCourseView.myCourseListCollectionView.reloadData()
                self?.setEmptyView()
            }
        }
    }
}


// MARK: - CollectionView Methods

extension NavViewedCourseViewController {
    private func register() {
        navViewedCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        navViewedCourseView.myCourseListCollectionView.delegate = self
        navViewedCourseView.myCourseListCollectionView.dataSource = self
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
        return viewedCourseViewModel.viewedCourseData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(viewedCourseViewModel.viewedCourseData.value?[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
        return cell
    }
    
    @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: navViewedCourseView.myCourseListCollectionView)
        let indexPath = navViewedCourseView.myCourseListCollectionView.indexPathForItem(at: location)
       
       if let index = indexPath {
          guard let courseId = viewedCourseViewModel.viewedCourseData.value?[indexPath?.item ?? 0].courseId else {return}
          
          let courseDetailViewModel = CourseDetailViewModel(courseId: courseId)
          let addScheduleViewModel = AddScheduleViewModel()
          addScheduleViewModel.viewedDateCourseByMeData = courseDetailViewModel
          addScheduleViewModel.isImporting = true
          
          let vc = AddScheduleFirstViewController(viewModel: addScheduleViewModel)
          self.navigationController?.pushViewController(vc, animated: true)
          
          // 데이터를 바인딩합니다.
          vc.pastDateBindViewModel()
       }
    }
    
}
