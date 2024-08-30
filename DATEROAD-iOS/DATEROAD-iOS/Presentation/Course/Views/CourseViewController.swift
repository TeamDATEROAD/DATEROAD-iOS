//
//  CourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

import SnapKit
import Then


final class CourseViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let loadingView: DRLoadingView = DRLoadingView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()

    private let courseView = CourseView()
    
    // MARK: - Properties
    
    private var courseViewModel: CourseViewModel
    
    private var courseListModel = CourseListModel.courseContents
    
    private var selectedButton: UIButton?
    
    
    // MARK: - Life Cycle
    
    init(courseViewModel: CourseViewModel) {
        self.courseViewModel = courseViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCourse()
        registerCell()
        setDelegate()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCourse()
        courseViewModel.fetchPriceData()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(loadingView, courseView)
    }
    
    override func setLayout() {
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        courseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func registerCell() {
        self.courseView.courseFilterView.priceCollectionView.register(PriceButtonCollectionViewCell.self, forCellWithReuseIdentifier: PriceButtonCollectionViewCell.cellIdentifier)
        self.courseView.courseListView.courseListCollectionView.register(CourseListCollectionViewCell.self, forCellWithReuseIdentifier: CourseListCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.courseView.courseFilterView.priceCollectionView.dataSource = self
        self.courseView.courseFilterView.priceCollectionView.delegate = self
        self.courseView.courseListView.courseListCollectionView.dataSource = self
        self.courseView.courseListView.courseListCollectionView.delegate = self
        self.courseView.courseFilterView.delegate = self
        self.courseView.courseNavigationBarView.delegate = self
        self.courseView.courseFilterView.resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    func bindViewModel() {
        
        self.courseViewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.courseViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.courseViewModel.onFailNetwork.value else { return }
            if !onFailNetwork {
                self?.loadingView.isHidden = !onLoading
                self?.courseView.isHidden = onLoading
                self?.tabBarController?.tabBar.isHidden = onLoading
            }
        }
        
        self.courseViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        courseViewModel.isSuccessGetData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }

            if isSuccess {
                self?.courseView.courseListView.courseListCollectionView.reloadData()
            }
        }
        
        self.courseViewModel.selectedPriceIndex.bind { [weak self] index in
            self?.courseViewModel.didUpdateSelectedPriceIndex?(index)
        }
        
        self.courseViewModel.selectedCityName.bind { [weak self] index in
            
            self?.courseViewModel.didUpdateselectedCityName?(index)
        }
        
        self.courseViewModel.didUpdateCourseList = { [weak self] in
            self?.courseListModel = self?.courseViewModel.courseListModel ?? []
            
            DispatchQueue.main.async {
                self?.courseView.courseListView.courseListCollectionView.reloadData()
            }
        }
    }
    
}

// MARK: - Extensions

extension CourseViewController {
    
    func isCellEmpty(cellCount: Int) {
        let isEmpty = cellCount == 0
        self.courseView.courseListView.courseListCollectionView.isHidden = isEmpty
        self.courseView.courseListView.courseEmptyImageView.isHidden = !isEmpty
        self.courseView.courseListView.courseEmptyLabel.isHidden = !isEmpty
    }
    
}

extension CourseViewController: CourseFilterViewDelegate {
    
    func didTapLocationFilter() {
        let locationFilterVC = LocationFilterViewController()
        locationFilterVC.modalPresentationStyle = .overFullScreen
        locationFilterVC.delegate = self
        self.present(locationFilterVC, animated: true)
    }
    
    @objc
    func didTapPriceButton(_ sender: UIButton) {
        if let previousButton = selectedButton, previousButton != sender {
            previousButton.isSelected = false
            self.courseView.courseFilterView.updatePrice(button: previousButton, buttonType: UnselectedButton(), isSelected: false)
        }
        
        guard let cell = sender.superview?.superview as? UICollectionViewCell,
              let indexPath = courseView.courseFilterView.priceCollectionView.indexPath(for: cell) else {
            return
        }
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.courseView.courseFilterView.updatePrice(button: sender, buttonType: SelectedButton(), isSelected: true)
            courseViewModel.selectedPriceIndex.value = indexPath.row + 1
        } else {
            self.courseView.courseFilterView.updatePrice(button: sender, buttonType: UnselectedButton(), isSelected: false)
            courseViewModel.selectedPriceIndex.value = nil
        }
        
        selectedButton = sender.isSelected ? sender : nil
        getCourse()
    }
    
    @objc
    func didTapResetButton() {
        courseViewModel.fetchPriceData()
        courseViewModel.resetSelections()
        courseView.courseFilterView.resetPriceButtons()
        courseView.courseFilterView.resetLocationFilterButton()
        courseViewModel.selectedCityName.value = ""
        courseViewModel.selectedPriceIndex.value = nil
        getCourse()
    }
    
}

extension CourseViewController: LocationFilterDelegate {
    
    func getCourse() {
        let city = courseViewModel.selectedCityName.value ?? ""
        let cost = courseViewModel.selectedPriceIndex.value?.costNum()
        courseViewModel.getCourse(city: city, cost: cost)
    }
    
    func didSelectCity(_ country: LocationModel.Country, _ city: LocationModel.City) {
        let cityName = String(city.rawValue.split(separator: ".").first ?? "")
        courseViewModel.selectedCityName.value = cityName
        
        self.courseView.courseFilterView.locationFilterButton.do {
            $0.setTitleColor(UIColor(resource: .deepPurple), for: .normal)
            $0.setTitle(cityName, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .deepPurple).cgColor
            let image = UIImage(resource: .icDropdown).withRenderingMode(.alwaysTemplate)
            $0.setImage(image, for: .normal)
            $0.tintColor = UIColor(resource: .deepPurple)
        }
    }
    
}

extension CourseViewController: CourseNavigationBarViewDelegate {
    
    func didTapAddCourseButton() {
        let addCourseFirstVC = AddCourseFirstViewController(viewModel: AddCourseViewModel())
        self.navigationController?.pushViewController(addCourseFirstVC, animated: false)
    }
    
}

extension CourseViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let totalItems = collectionView.numberOfItems(inSection: indexPath.section)
            
            if indexPath.row == totalItems - 2 {
                // 로딩 뷰 표시
                self.loadingView.isHidden = false
                self.courseView.isHidden = true
                self.tabBarController?.tabBar.isHidden = true

                // 3초 후에 로딩 뷰 숨기고 마지막 셀 표시
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    self?.loadingView.isHidden = true
                    self?.courseView.isHidden = false
                    self?.tabBarController?.tabBar.isHidden = false
                }
            }
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCourse = courseViewModel.courseListModel[indexPath.row]
        
        if let courseId = selectedCourse.courseId {
            let detailViewModel = CourseDetailViewModel(courseId: courseId)
            let detailViewController = CourseDetailViewController(viewModel: detailViewModel)
            navigationController?.pushViewController(detailViewController, animated: false)
        }
    }
}



extension CourseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isCellEmpty(cellCount: self.courseViewModel.courseListModel.count)
        
        return collectionView == courseView.courseFilterView.priceCollectionView ? self.courseViewModel.priceData.count : self.courseViewModel.courseListModel.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = collectionView == courseView.courseFilterView.priceCollectionView ? PriceButtonCollectionViewCell.cellIdentifier : CourseListCollectionViewCell.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let priceCell = cell as? PriceButtonCollectionViewCell {
            priceCell.updateButtonTitle(title: self.courseViewModel.priceData[indexPath.item])
            priceCell.priceButton.addTarget(self, action: #selector(didTapPriceButton(_:)), for: .touchUpInside)
        } else if let courseListCell = cell as? CourseListCollectionViewCell {
            let course = self.courseListModel[indexPath.item]
            courseListCell.configure(with: course)
            courseListCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetialVC(_:))))
        }
        return cell
    }
    
    @objc
    func pushToCourseDetialVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: courseView.courseListView.courseListCollectionView)
        if let indexPath = courseView.courseListView.courseListCollectionView.indexPathForItem(at: location) {
            let selectedCourse = courseListModel[indexPath.row]
            
            if let courseId = selectedCourse.courseId {
                let viewModel = CourseDetailViewModel(courseId: courseId)
                let courseDetailVC = CourseDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(courseDetailVC, animated: false)
            } else {
                print("Error: Selected course does not have a valid courseId.")
            }
        }
    }
}

extension CourseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == courseView.courseFilterView.priceCollectionView {
            let priceTitle = self.courseViewModel.priceData[indexPath.item]
            let font = UIFont.suit(.body_med_13)
            let textWidth = priceTitle.width(withConstrainedHeight: 30, font: font)
            return CGSize(width: textWidth + 20, height: 30)
        } else {
            let screenWidth = ScreenUtils.width
            return CGSize(width: ((screenWidth - 32) - 15) / 2, height: 246)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == courseView.courseFilterView.priceCollectionView ? 8 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

