//
//  NavViewedCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

import SnapKit
import Then

final class NavViewedCourseViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private var navViewedCourseView = MyCourseListView(type: StringLiterals.NavType.nav)
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    private var viewedCourseViewModel: MyCourseListViewModel
    
    
    // MARK: - LifeCycle
    
    init(viewedCourseViewModel: MyCourseListViewModel) {
        self.viewedCourseViewModel = viewedCourseViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewedCourseViewModel.setNavViewedCourseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftButtonStyle(image: UIImage(named: "leftArrow"))
        setLeftButtonAction(target: self, action: #selector(leftButtonTapped))
        setTitleLabelStyle(title: StringLiterals.ViewedCourse.title, alignment: .center)
        register()
        setDelegate()
        bindViewModel()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(navViewedCourseView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        navViewedCourseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension NavViewedCourseViewController {
    
    @objc
    func leftButtonTapped() {
        navigationController?.popViewController(animated: false)
        AmplitudeManager.shared.trackEvent(StringLiterals.Amplitude.EventName.clickPurchasedBack)
    }
    
}


// MARK: - EmptyView Methods

private extension NavViewedCourseViewController {
    
    func setEmptyView() {
        let isEmpty = (viewedCourseViewModel.viewedCourseData.value?.count == 0)
        navViewedCourseView.emptyView.isHidden = !isEmpty
        navViewedCourseView.myCourseListCollectionView.isHidden = isEmpty
        if isEmpty {
            DispatchQueue.main.async {
                self.navViewedCourseView.emptyView.setEmptyView(emptyImage: UIImage(resource: .emptyPastSchedule), emptyTitle: StringLiterals.EmptyView.emptyNavViewedCourse)
            }
        } else {
            DispatchQueue.main.async {
                self.navViewedCourseView.myCourseListCollectionView.reloadData()
            }
        }
    }
    
}


// MARK: - DataBind

extension NavViewedCourseViewController {
    
    func bindViewModel() {
        self.viewedCourseViewModel.broughtViewedCoursesModelIsUpdate.bind { [weak self] flag in
            guard let flag else { return }
            if flag {
                DispatchQueue.main.async {
                    self?.navViewedCourseView.myCourseListCollectionView.reloadData()
                }
                self?.viewedCourseViewModel.broughtViewedCoursesModelIsUpdate.value = false
            }
        }
        
        self.viewedCourseViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.viewedCourseViewModel.setNavViewedCourseLoading()
                self?.viewedCourseViewModel.setNavViewedCourseData()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.viewedCourseViewModel.onNavViewedCourseFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                errorVC.onDismiss = {
                    self?.viewedCourseViewModel.onNavViewedCourseFailNetwork.value = false
                    self?.viewedCourseViewModel.onNavViewedCourseLoading.value = false
                }
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.viewedCourseViewModel.onNavViewedCourseLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.viewedCourseViewModel.onViewedCourseFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView(type: StringLiterals.ViewedCourse.title)
                    self?.navViewedCourseView.isHidden = onLoading
                } else {
                    DispatchQueue.main.async {
                        self?.setEmptyView()
                        self?.navViewedCourseView.isHidden = onLoading
                        self?.tabBarController?.tabBar.isHidden = false
                        self?.hideLoadingView()
                    }
                }
            }
        }
        
        self.viewedCourseViewModel.isSuccessGetNavViewedCourseInfo.bind { [weak self] _ in
            self?.viewedCourseViewModel.setNavViewedCourseLoading()
        }
    }
    
}


// MARK: - CollectionView Methods

private extension NavViewedCourseViewController {
    
    func register() {
        navViewedCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
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
    
    @objc
    func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: navViewedCourseView.myCourseListCollectionView)
        let indexPath = navViewedCourseView.myCourseListCollectionView.indexPathForItem(at: location)
        
        if indexPath != nil {
            guard let courseId = viewedCourseViewModel.viewedCourseData.value?[indexPath?.item ?? 0].courseId else {return}
            
            let courseDetailViewModel = CourseDetailViewModel(courseId: courseId)
            let addScheduleViewModel = AddScheduleViewModel()
            addScheduleViewModel.viewedDateCourseByMeData = courseDetailViewModel
            addScheduleViewModel.isBroughtData = true
            
            let vc = AddScheduleFirstViewController(viewModel: addScheduleViewModel, viewPath: StringLiterals.Amplitude.ViewPath.viewedCourse)
            // 데이터를 바인딩합니다.
            vc.pastDateBindViewModel()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
