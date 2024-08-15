//
//  MainViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var mainView: MainView
    
    
    // MARK: - Properties
    
    private var mainViewModel: MainViewModel
    
    private lazy var userName = mainViewModel.mainUserData.value?.name
    
    private lazy var point = mainViewModel.mainUserData.value?.point
    
    
    // MARK: - Life Cycles
    
    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        self.mainView = MainView(mainSectionData: self.mainViewModel.sectionData)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        setAddTarget()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainViewModel.fetchSectionData()
    }
    
    override func setHierarchy() {
        self.view.addSubview(mainView)
    }
    
    override func setLayout() {
        mainView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.1)
        }
    }
    
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension MainViewController {
    
    func bindViewModel() {
        self.mainViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.mainViewModel.isSuccessGetUserInfo.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        
        self.mainViewModel.isSuccessGetHotDate.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        
        self.mainViewModel.isSuccessGetBanner.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        
        self.mainViewModel.isSuccessGetNewDate.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        
        self.mainViewModel.isSuccessGetUpcomingDate.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        self.mainViewModel.currentIndex.bind { [weak self] index in
            guard let index
            else { return }
           let count = 5
            print("index \(index.row + 1)")
            self?.updateBannerCell(index: index.row, count: count)
        }
    }
    
    func registerCell() {
        self.mainView.mainCollectionView.register(UpcomingDateCell.self, forCellWithReuseIdentifier: UpcomingDateCell.cellIdentifier)
        self.mainView.mainCollectionView.register(HotDateCourseCell.self, forCellWithReuseIdentifier: HotDateCourseCell.cellIdentifier)
        self.mainView.mainCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.cellIdentifier)
        self.mainView.mainCollectionView.register(NewDateCourseCell.self, forCellWithReuseIdentifier: NewDateCourseCell.cellIdentifier)
        self.mainView.mainCollectionView.register(MainHeaderView.self, forSupplementaryViewOfKind: MainHeaderView.elementKinds, withReuseIdentifier: MainHeaderView.identifier)
    }
    
    func setDelegate() {
        self.mainView.mainCollectionView.dataSource = self
        self.mainView.mainCollectionView.delegate = self
    }
    
    func setAddTarget() {
        self.mainView.floatingButton.addTarget(self, action: #selector(pushToAddCourseVC), for: .touchUpInside)
    }
    
    func updateBannerCell(index: Int, count: Int) {
        guard let cell = self.mainView.mainCollectionView.cellForItem(at: IndexPath(item: 0, section: 2)) as? BannerCell
        else { return }
        cell.bindIndexData(currentIndex: index, count: count)
    }
    
    @objc
    func pushToAddCourseVC() {
        let addCourseVC = AddCourseFirstViewController(viewModel: AddCourseViewModel())
        self.navigationController?.pushViewController(addCourseVC, animated: false)
    }
    
    // 코스 둘러보기 뷰컨으로 이동
    @objc
    func pushToCourseVC() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc
    func pushToDateDetailVC(_ sender: UIButton) {
        let dateID = sender.tag
        print("Button with DateID \(dateID) pressed")
        let upcomingDateDetailVC = UpcomingDateDetailViewController()
        upcomingDateDetailVC.upcomingDateDetailViewModel = DateDetailViewModel(dateID: dateID)
        upcomingDateDetailVC.setColor(index: dateID)
        self.navigationController?.pushViewController(upcomingDateDetailVC, animated: true)
    }

    @objc
    func pushToDateScheduleVC() {
        print("pushToDateScheduleVC")
        self.tabBarController?.selectedIndex = 2
    }

    @objc
    func pushToPointDetailVC() {
        guard let userName = self.userName, let totalPoint = self.point else {
                print("User name or point is nil")
                return
        }
        let pointDetailVC = PointDetailViewController(pointViewModel: PointViewModel(userName: userName, totalPoint: totalPoint))
        self.navigationController?.pushViewController(pointDetailVC, animated: false)
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let cell = self.mainView.mainCollectionView.cellForItem(at: IndexPath(item: 0, section: 2)) as? BannerCell
        else { return }
        
        if scrollView == cell.bannerCollectionView {
            let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
            self.mainViewModel.currentIndex.value?.row = page
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentOffsetY = scrollView.contentOffset.y
                
            if contentOffsetY < 0 {
                // 맨 위에서 아래로 당겼을 때
                mainView.mainCollectionView.backgroundColor = UIColor(resource: .deepPurple)
            } else if contentOffsetY + scrollView.frame.size.height > scrollView.contentSize.height {
                // 맨 아래에서 위로 당겼을 때
                mainView.mainCollectionView.backgroundColor = UIColor(resource: .drWhite)
            } else {
                // 일반적인 스크롤 상태
                mainView.mainCollectionView.backgroundColor = UIColor(resource: .drWhite)
            }
        }

    
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.mainView.mainCollectionView {
            return self.mainViewModel.sectionData.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainView.mainCollectionView {
            switch self.mainViewModel.sectionData[section] {
            case .upcomingDate:
                return 1
            case .hotDateCourse:
                return self.mainViewModel.hotCourseData.value?.count ?? 0
            case .banner:
                return 1
            case .newDateCourse:
                return self.mainViewModel.newCourseData.value?.count ?? 0
            }
        } else {
            return 5
        }
    }
    
    // TODO: - 다가오는 일정 없는 경우 로직 수정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.mainCollectionView {
            switch self.mainViewModel.sectionData[indexPath.section] {
            case .upcomingDate:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingDateCell.cellIdentifier, for: indexPath) as? UpcomingDateCell else { return UICollectionViewCell() }
                cell.bindData(upcomingData: mainViewModel.upcomingData.value, mainUserData: mainViewModel.mainUserData.value)
                // Set button actions
                let pointLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(pushToPointDetailVC))
                cell.pointLabel.addGestureRecognizer(pointLabelTapGesture)
               cell.dateTicketView.moveButton.tag = mainViewModel.upcomingData.value?.dateId ?? 0
               cell.dateTicketView.moveButton.addTarget(self, action: #selector(pushToDateDetailVC(_:)), for: .touchUpInside)
               cell.emptyTicketView.moveButton.addTarget(self, action: #selector(pushToDateScheduleVC), for: .touchUpInside)
               
               // Debug prints
               print("UpcomingDateCell configured")
               print("DateTicketView Button Tag: \(cell.dateTicketView.moveButton.tag)")
               
                return cell
            case .hotDateCourse:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotDateCourseCell.cellIdentifier, for: indexPath) as? HotDateCourseCell else { return UICollectionViewCell() }
                cell.bindData(hotDateData: mainViewModel.hotCourseData.value?[indexPath.row])
                return cell
            case .banner:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.cellIdentifier, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
                cell.bannerCollectionView.register(BannerImageCollectionViewCell.self, forCellWithReuseIdentifier: BannerImageCollectionViewCell.cellIdentifier)
                cell.bannerCollectionView.dataSource = self
                cell.bannerCollectionView.delegate = self
                
                let index = mainViewModel.currentIndex.value?.row ?? 0
                cell.bindIndexData(currentIndex: index, count: 5)
                return cell
            case .newDateCourse:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewDateCourseCell.cellIdentifier, for: indexPath) as? NewDateCourseCell else { return UICollectionViewCell() }
                cell.bindData(newDateData: mainViewModel.newCourseData.value?[indexPath.row])
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.cellIdentifier, for: indexPath) as? BannerImageCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(bannerData: mainViewModel.bannerData.value?[indexPath.row])
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainHeaderView.identifier, for: indexPath)
                            as? MainHeaderView else { return UICollectionReusableView() }
                    
        switch mainViewModel.sectionData[indexPath.section] {
            case .upcomingDate, .banner:
                return header
            case .hotDateCourse:
                header.viewMoreButton.addTarget(self, action: #selector(pushToCourseVC), for: .touchUpInside)
                header.bindTitle(section: .hotDateCourse, nickname: mainViewModel.nickname.value)
            case .newDateCourse:
                header.viewMoreButton.addTarget(self, action: #selector(pushToCourseVC), for: .touchUpInside)
                header.bindTitle(section: .newDateCourse, nickname: nil)
        }
        return header
    }
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if collectionView == mainView.mainCollectionView {
           switch self.mainViewModel.sectionData[indexPath.section] {
           case .hotDateCourse:
               let courseId = mainViewModel.hotCourseData.value?[indexPath.item].courseId ?? 0
               self.navigationController?.pushViewController(CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId)), animated: true)
           case .newDateCourse:
               let courseId = mainViewModel.newCourseData.value?[indexPath.item].courseId ?? 0
               self.navigationController?.pushViewController(CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId)), animated: true)
           default:
               print("default")
           }
       } else {
          
           let id = mainViewModel.bannerData.value?[indexPath.item].advertisementId ?? 1
          let bannerDtailVC = BannerDetailViewController(viewModel: CourseDetailViewModel(courseId: 7), advertismentId: id)
                    self.navigationController?.pushViewController(bannerDtailVC, animated: false)
       }
   }
        
}
