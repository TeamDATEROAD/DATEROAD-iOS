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
    
    // MARK: - Life Cycle
  
    init(courseViewModel: CourseViewModel) {
        self.courseViewModel = courseViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        registerCell()
        setDelegate()
        
    }
    
    override func setHierarchy() {
        self.view.addSubview(courseView)
    }
    
    override func setLayout() {
        courseView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview()
        }
    }

}

extension CourseViewController {
    func registerCell() {
        self.courseView.priceCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.courseView.priceCollectionView.dataSource = self
        self.courseView.priceCollectionView.delegate = self
    }
    
    
    @objc
    func didTapTagButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? self.courseView.updateTag(button: sender, buttonType: SelectedButton())
        : self.courseView.updateTag(button: sender, buttonType: UnselectedButton())
    }
}

extension CourseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let priceTitle = self.courseViewModel.priceData[indexPath.item]
        let font = UIFont.suit(.body_med_13)
        let textWidth = priceTitle.width(withConstrainedHeight: 30, font: font)
        let padding: CGFloat = 20
                
       return CGSize(width: textWidth + padding, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension CourseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.courseViewModel.priceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
        
        cell.updateButtonTitle(title: self.courseViewModel.priceData[indexPath.item])
        cell.tendencyTagButton.addTarget(self, action: #selector(didTapTagButton(_:)), for: .touchUpInside)
        return cell
    }
    
}


