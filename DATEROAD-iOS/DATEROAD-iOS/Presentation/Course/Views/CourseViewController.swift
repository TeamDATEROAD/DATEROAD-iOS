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
        self.view.addSubview(courseView)
    }
    
    override func setLayout() {
        courseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension CourseViewController {
    
    @objc
    func didTapResetButton() {
        courseViewModel.fetchPriceData()
        courseView.courseFilterView.priceCollectionView.reloadData()
        courseViewModel.resetSelections()
        courseView.courseFilterView.resetPriceButtons()
        self.courseView.courseFilterView.locationFilterButton.do {
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.setTitle("지역", for: .normal)
            $0.layer.borderWidth = 0
            $0.tintColor = UIColor(resource: .gray400)
        }
        courseViewModel.selectedCityName.value = ""
        courseViewModel.selectedPriceIndex.value = nil
        getCourse()
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

    
    func bindViewModel() {
        self.courseViewModel.selectedPriceIndex.bind { [weak self] index in
            self?.courseViewModel.didUpdateSelectedPriceIndex?(index)
        }
        
        self.courseViewModel.selectedCityName.bind { [weak self] index in
            self?.courseViewModel.didUpdateselectedCityName?(index)
        }
        
        self.courseViewModel.didUpdateCourseList = { [weak self] in
            DispatchQueue.main.async {
                self?.courseView.courseListView.courseListCollectionView.reloadData()
                self?.isCellEmpty(cellCount: self?.courseViewModel.courseListModel.count ?? 0)
            }
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
    
    func isCellEmpty(cellCount: Int) {
        if cellCount == 0 {
            self.courseView.courseListView.courseListCollectionView.isHidden = true
            self.courseView.courseListView.courseEmptyImageView.isHidden = false
            self.courseView.courseListView.courseEmptyLabel.isHidden = false
        } else {
            self.courseView.courseListView.courseListCollectionView.isHidden = false
            self.courseView.courseListView.courseEmptyImageView.isHidden = true
            self.courseView.courseListView.courseEmptyLabel.isHidden = true
        }
    }
    
}

extension CourseViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCourse = courseListModel[indexPath.row]
        if let courseId = selectedCourse.courseId {
            let detailViewModel = CourseDetailViewModel(courseId: courseId)
            let detailViewController = CourseDetailViewController(viewModel: detailViewModel)
            navigationController?.pushViewController(detailViewController, animated: false)
        }
    }
}

extension CourseViewController: LocationFilterDelegate, CourseFilterViewDelegate {
    
    func getCourse() {
        let city = courseViewModel.selectedCityName.value ?? ""
        let cost = courseViewModel.selectedPriceIndex.value?.costNum()
        
        courseViewModel.getCourse(city: city, cost: cost)
    }
    
    
    func didTapLocationFilter() {
        let locationFilterVC = LocationFilterViewController()
        locationFilterVC.modalPresentationStyle = .overFullScreen
        locationFilterVC.delegate = self
        self.present(locationFilterVC, animated: true)
    }
    
    func didSelectCity(_ country: LocationModel.Country, _ city: LocationModel.City) {
       // 'Seoul.jongnoJunggu'와 같은 rawValue에서 'jongnoJunggu'만 추출
       let cityNameComponents = city.rawValue.split(separator: ".")
       let cityName = cityNameComponents.last.map { String($0) } ?? city.rawValue
       
       if let subRegion = SubRegion(rawValue: cityName) {
           print(subRegion)
           
           let selectedSubRegion = "\(subRegion)"
           
           courseViewModel.selectedCityName.value = selectedSubRegion
       } else {
           print(cityName)
       }
       
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


extension CourseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("어떻게 짖걸이는지 보자 ㅋㅋ",self.courseListModel.count)

        isCellEmpty(cellCount: self.courseListModel.count)
        
        return collectionView == courseView.courseFilterView.priceCollectionView ? self.courseViewModel.priceData.count : self.courseListModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isPriceCollection = collectionView == courseView.courseFilterView.priceCollectionView
        
        let cellIdentifier = isPriceCollection ? PriceButtonCollectionViewCell.cellIdentifier : CourseListCollectionViewCell.cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if isPriceCollection, let priceCell = cell as? PriceButtonCollectionViewCell {
            priceCell.updateButtonTitle(title: self.courseViewModel.priceData[indexPath.item])
            priceCell.priceButton.addTarget(self, action: #selector(didTapPriceButton(_:)), for: .touchUpInside)
        } else if let courseListCell = cell as? CourseListCollectionViewCell {
            let course = self.courseListModel[indexPath.item]
            courseListCell.configure(with: course)
            courseListCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetialVC(_:))))
        }
        return cell
    }
    
    //코스 상세로 화면 전환
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
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        if collectionView == courseView.courseFilterView.priceCollectionView {
            let priceTitle = self.courseViewModel.priceData[indexPath.item]
            let font = UIFont.suit(.body_med_13)
            let textWidth = priceTitle.width(withConstrainedHeight: 30, font: font)
            let padding: CGFloat = 20
            cellWidth = textWidth + padding
            cellHeight = 30
        } else {
            let screenWidth = ScreenUtils.width
            cellWidth = ((screenWidth - 32) - 15) / 2
            cellHeight = 246
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == courseView.courseFilterView.priceCollectionView ? 8 : 15
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView == courseView.courseFilterView.priceCollectionView ? 0 : 20
    }
    
}

