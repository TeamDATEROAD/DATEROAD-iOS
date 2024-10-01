//
//  MyRegisterCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/11/24.
//

import UIKit

import SnapKit
import Then

final class MyRegisterCourseViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private var myRegisterCourseView = MyCourseListView(type: StringLiterals.NavType.nav)
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    private let myRegisterCourseViewModel = MyCourseListViewModel()
    
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.myRegisterCourseViewModel.setMyRegisterCourseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.MyRegisterCourse.title, alignment: .center)
        bindViewModel()
        register()
        setDelegate()
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

private extension MyRegisterCourseViewController {
    
    func setEmptyView() {
        let isEmpty = (myRegisterCourseViewModel.myRegisterCourseData.value?.count == 0)
        myRegisterCourseView.emptyView.isHidden = !isEmpty
        if isEmpty {
            myRegisterCourseView.emptyView.do {
                $0.setEmptyView(emptyImage: UIImage(resource: .emptyDateSchedule),
                                emptyTitle: StringLiterals.EmptyView.emptyMyRegisterCourse)
            }
        }
    }
    
}


// MARK: - DataBind

extension MyRegisterCourseViewController {
    
    func bindViewModel() {
        self.myRegisterCourseViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.myRegisterCourseViewModel.setMyRegisterCourseData()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.myRegisterCourseViewModel.onMyRegisterCourseFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.myRegisterCourseViewModel.onMyRegisterCourseFailNetwork.value = false
                    self?.myRegisterCourseViewModel.onMyRegisterCourseLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.myRegisterCourseViewModel.onMyRegisterCourseLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.myRegisterCourseViewModel.onMyRegisterCourseFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView()
                    self?.contentView.isHidden = onLoading
                } else {
                    self?.setEmptyView()
                    self?.myRegisterCourseView.myCourseListCollectionView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self?.contentView.isHidden = onLoading
                        self?.hideLoadingView()
                    }
                }
            }
        }
        
        self.myRegisterCourseViewModel.isSuccessGetMyRegisterCourseInfo.bind { [weak self] _ in
            self?.myRegisterCourseViewModel.setMyRegisterCourseLoading()
        }
    }
    
}


// MARK: - CollectionView Methods

private extension MyRegisterCourseViewController {
    
    func register() {
        myRegisterCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
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
    
    @objc
    func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: myRegisterCourseView.myCourseListCollectionView)
        let indexPath = myRegisterCourseView.myCourseListCollectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            let courseId = myRegisterCourseViewModel.myRegisterCourseData.value?[indexPath?.item ?? 0].courseId ?? 0
            self.navigationController?.pushViewController(CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId)), animated: false)
        }
    }
    
}
