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
        
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    private var timer: Timer?
    
    
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
    
    override func viewIsAppearing(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.mainViewModel.fetchSectionData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.stopBannerAutoScroll()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubview(mainView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        mainView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.1)
        }
    }

}

extension MainViewController {
    
    func bindViewModel() {
        self.mainViewModel.onFailNetwork.bind { [weak self] onFailure in
           guard let onFailure else { return }
           if onFailure {
              let errorVC = DRErrorViewController(type: StringLiterals.Common.main)
              self?.navigationController?.pushViewController(errorVC, animated: false)
           }
        }
        
        self.mainViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.mainViewModel.onFailNetwork.value else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView()
                    self?.mainView.isHidden = onLoading
                    self?.tabBarController?.tabBar.isHidden = onLoading
                } else {
                    self?.mainView.mainCollectionView.reloadData()
                    let initialIndexPath = IndexPath(item: 1, section: 2)
                    self?.mainView.mainCollectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
                    self?.startAutoScrollTimer()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self?.mainView.isHidden = onLoading
                        self?.tabBarController?.tabBar.isHidden = onLoading
                        self?.hideLoadingView()
                    }
                }
            }
        }
        
        self.mainViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                self?.mainViewModel.fetchSectionData()
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.mainViewModel.currentIndex.bind { [weak self] index in
            guard let index else { return }
            self?.updateBannerCell(index: index.row, count: 5)
        }
    }
    
    func registerCell() {
        self.mainView.mainCollectionView.register(UpcomingDateCell.self, forCellWithReuseIdentifier: UpcomingDateCell.cellIdentifier)
        self.mainView.mainCollectionView.register(HotDateCourseCell.self, forCellWithReuseIdentifier: HotDateCourseCell.cellIdentifier)
        self.mainView.mainCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.cellIdentifier)
        self.mainView.mainCollectionView.register(NewDateCourseCell.self, forCellWithReuseIdentifier: NewDateCourseCell.cellIdentifier)
        self.mainView.mainCollectionView.register(MainHeaderView.self, forSupplementaryViewOfKind: MainHeaderView.elementKinds, withReuseIdentifier: MainHeaderView.identifier)
        self.mainView.mainCollectionView.register(BannerIndexFooterView.self, forSupplementaryViewOfKind: BannerIndexFooterView.elementKinds, withReuseIdentifier: BannerIndexFooterView.identifier)

    }
    
    func setDelegate() {
        self.mainView.mainCollectionView.dataSource = self
        self.mainView.mainCollectionView.delegate = self
        self.mainView.delegate = self
    }
    
    func setAddTarget() {
        self.mainView.floatingButton.addTarget(self, action: #selector(pushToAddCourseVC), for: .touchUpInside)
    }
    
    func updateBannerCell(index: Int, count: Int) {
        guard let bannerIndexView = self.mainView.mainCollectionView.supplementaryView(forElementKind: BannerIndexFooterView.elementKinds, at: IndexPath(item: 0, section: 2)) as? BannerIndexFooterView
        else { return }
        bannerIndexView.bindIndexData(currentIndex: index, count: count)
        var targetIndexPath = IndexPath(item: index, section: 2)

        switch index {
        case 0:
            targetIndexPath = IndexPath(item: 5, section: 2)
        case 6:
            targetIndexPath = IndexPath(item: 1, section: 2)
        default:
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.mainView.mainCollectionView.scrollToItem(at: targetIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func startAutoScrollTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScrollBanner), userInfo: nil, repeats: true)
    }
    
    func stopBannerAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func autoScrollBanner() {
        guard let currentIndex = self.mainViewModel.currentIndex.value?.row else { return }
        let targetIndexPath = IndexPath(item: currentIndex + 1, section: 2)
        if currentIndex >= 0 && currentIndex <= 5 {
            self.mainView.mainCollectionView.scrollToItem(at: targetIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc
    func pushToAddCourseVC() {
       let addCourseVC = AddCourseFirstViewController(viewModel: AddCourseViewModel(), viewPath: StringLiterals.Amplitude.ViewPath.home)
        self.navigationController?.pushViewController(addCourseVC, animated: false)
    }
    
    @objc
    func pushToCourseVC() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc
    func pushToDateDetailVC(_ sender: UIButton) {
        let dateID = sender.tag
        let upcomingDateDetailVC = UpcomingDateDetailViewController(dateID: dateID, viewPath: StringLiterals.TabBar.home, upcomingDateDetailViewModel: DateDetailViewModel())
        upcomingDateDetailVC.setColor(index: dateID)
        self.navigationController?.pushViewController(upcomingDateDetailVC, animated: false)
    }
    
    @objc
    func pushToDateScheduleVC() {
        self.tabBarController?.selectedIndex = 2
    }
    
    @objc
    func pushToPointDetailVC() {
        guard let userName = self.userName, let totalPoint = self.point else { return }
        let pointDetailVC = PointDetailViewController(pointViewModel: PointViewModel(userName: userName, totalPoint: totalPoint))
        self.navigationController?.pushViewController(pointDetailVC, animated: false)
    }
    
    @objc 
    func handleLongPress(_ gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began, .changed, .ended:
            stopBannerAutoScroll()
        default:
            startAutoScrollTimer()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        mainView.mainCollectionView.backgroundColor = contentOffsetY < 0 ? UIColor(resource: .deepPurple) : UIColor(resource: .drWhite)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mainViewModel.sectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.mainViewModel.sectionData[section] {
        case .upcomingDate:
            return 1
        case .hotDateCourse:
            return self.mainViewModel.hotCourseData.value?.count ?? 0
        case .banner:
            return self.mainViewModel.bannerData.value?.count ?? 0
        case .newDateCourse:
            return self.mainViewModel.newCourseData.value?.count ?? 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.mainViewModel.sectionData[indexPath.section] {
        case .upcomingDate:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingDateCell.cellIdentifier, for: indexPath) as? UpcomingDateCell 
            else { return UICollectionViewCell() }
            DispatchQueue.main.async {
                cell.bindData(upcomingData: self.mainViewModel.upcomingData.value, mainUserData: self.mainViewModel.mainUserData.value)
            }
            // Set button actions
            let pointLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(pushToPointDetailVC))
            cell.pointLabel.addGestureRecognizer(pointLabelTapGesture)
            cell.dateTicketView.moveButton.tag = mainViewModel.upcomingData.value?.dateId ?? 0
            cell.dateTicketView.moveButton.addTarget(self, action: #selector(pushToDateDetailVC(_:)), for: .touchUpInside)
            cell.emptyTicketView.moveButton.addTarget(self, action: #selector(pushToDateScheduleVC), for: .touchUpInside)
            return cell
            
        case .hotDateCourse:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotDateCourseCell.cellIdentifier, for: indexPath) as? HotDateCourseCell 
            else { return UICollectionViewCell() }
            cell.bindData(hotDateData: mainViewModel.hotCourseData.value?[indexPath.row])
            return cell
            
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.cellIdentifier, for: indexPath) as? BannerCell 
            else { return UICollectionViewCell() }
            cell.bindData(bannerData: mainViewModel.bannerData.value?[indexPath.row])
            let longPressGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            cell.addGestureRecognizer(longPressGesture)
            return cell
            
        case .newDateCourse:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewDateCourseCell.cellIdentifier, for: indexPath) as? NewDateCourseCell 
            else { return UICollectionViewCell() }
            cell.bindData(newDateData: mainViewModel.newCourseData.value?[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == StringLiterals.Common.header {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainHeaderView.identifier, for: indexPath) as? MainHeaderView
            else { return UICollectionReusableView() }
            
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
        } else {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerIndexFooterView.identifier, for: indexPath) as? BannerIndexFooterView
            else { return UICollectionReusableView() }
            let index = mainViewModel.currentIndex.value?.row ?? 0
            footer.bindIndexData(currentIndex: index, count: 5)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.mainViewModel.sectionData[indexPath.section] {
        case .hotDateCourse:
            let courseId = mainViewModel.hotCourseData.value?[indexPath.item].courseId ?? 0
            let courseDetailVC = CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId))
            courseDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(courseDetailVC, animated: false)
            
        case .newDateCourse:
            let courseId = mainViewModel.newCourseData.value?[indexPath.item].courseId ?? 0
            let courseDetailVC = CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId))
            courseDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(courseDetailVC, animated: false)
            
        case .banner:
            let id = mainViewModel.bannerData.value?[indexPath.item].advertisementId ?? 1
            let bannerDtailVC = BannerDetailViewController(viewModel: CourseDetailViewModel(courseId: 7), advertismentId: id)
            bannerDtailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(bannerDtailVC, animated: false)
            
        default:
            print("default")
        }
    }
    
}

extension MainViewController: BannerIndexDelegate {
    
    func bindIndex(currentIndex: Int) {
        self.mainViewModel.currentIndex.value?.row = currentIndex
    }
}
