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
    
}

extension MainViewController: UICollectionViewDelegate {}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mainViewModel.sectionData.count
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
            return self.mainViewModel.bannerData.value?.count ?? 0
        }
    }
    
    // TODO: - 다가오는 일정 없는 경우 로직 수정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.mainCollectionView {
            switch self.mainViewModel.sectionData[indexPath.section] {
            case .upcomingDate:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingDateCell.cellIdentifier, for: indexPath) as? UpcomingDateCell else { return UICollectionViewCell() }
                cell.bindData(upcomingData: mainViewModel.upcomingData.value, mainUserData: mainViewModel.mainUserData.value)
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
                cell.bannerCollectionView.reloadData()
                if let count = mainViewModel.bannerData.value?.count {
                    cell.bindIndexData(currentIndex: 1, count: count)
                }
                return cell
            case .newDateCourse:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewDateCourseCell.cellIdentifier, for: indexPath) as? NewDateCourseCell else { return UICollectionViewCell() }
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.cellIdentifier, for: indexPath) as? BannerImageCollectionViewCell else { return UICollectionViewCell() }
            cell.bindData(bannerData: mainViewModel.bannerData.value?[indexPath.row])
            cell.prepareForReuse()
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
            header.setRoundedView()
            header.bindTitle(section: .hotDateCourse, nickname: mainViewModel.nickname.value)
            case .newDateCourse:
                header.bindTitle(section: .newDateCourse, nickname: nil)
        }
        return header
    }
    
    
}
