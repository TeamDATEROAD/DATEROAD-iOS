//
//  CourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

import SnapKit
import Then

final class CourseViewController: BaseViewController, LocationFilterDelegate, CourseFilterViewDelegate {
    
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
        
        registerCell()
        setDelegate()
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
        self.courseView.courseFilterView.resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    @objc
    func didTapResetButton() {
        courseViewModel.fetchPriceData()
        courseView.courseFilterView.priceCollectionView.reloadData()
        
        courseViewModel.resetSelections()
        courseView.courseFilterView.locationFilterButton.setTitle("지역", for: .normal)
    }
    
    @objc
    func didTapPriceButton(_ sender: UIButton) {
        if let previousButton = selectedButton, previousButton != sender {
            previousButton.isSelected = false
            self.courseView.courseFilterView.updatePrice(button: previousButton, buttonType: UnselectedButton(), isSelected: false)
        }
        
        sender.isSelected = !sender.isSelected
        
        sender.isSelected ? self.courseView.courseFilterView.updatePrice(button: sender, buttonType: SelectedButton(), isSelected: sender.isSelected)
        : self.courseView.courseFilterView.updatePrice(button: sender, buttonType: UnselectedButton(), isSelected: sender.isSelected)
        
        // 현재 버튼이 선택되었다면 selectedButton으로 비활성화되었다면 nil로 설정
        selectedButton = sender.isSelected ? sender : nil
    }
    
    
    func didTapLocationFilter() {
        let locationFilterVC = LocationFilterViewController()
        locationFilterVC.modalPresentationStyle = .overFullScreen
        locationFilterVC.delegate = self
        self.present(locationFilterVC, animated: true)
    }
    
    func didSelectCity(_ city: LocationModel.City) {
        print("Selected city: \(city.rawValue)")
        self.courseView.courseFilterView.locationFilterButton.setTitle("\(city.rawValue)", for: .normal)
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
            cellHeight = 226
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

extension CourseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
        }
        
        return cell
    }
}
