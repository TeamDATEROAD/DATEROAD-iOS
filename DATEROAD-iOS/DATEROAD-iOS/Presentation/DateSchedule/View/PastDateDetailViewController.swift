//
//  PastDateDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

class PastDateDetailViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    var pastDateDetailContentView = DateDetailContentView()
    
    // MARK: - Properties
    
    var pastDateDetailData = DateTimeLineModel(startTime: "", places: [])
    
    private let pastDateDetailViewModel = DateDetailViewModel()

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftBackButton()
        setTitleLabelStyle(title: "지난 데이트")
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        
        setButton()
        registerCell()
        setDelegate()
        setUpBindings()
    }
    
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubviews(pastDateDetailContentView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
        pastDateDetailContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


// MARK: - UI Setting Methods

extension PastDateDetailViewController {
    @objc
    private func deleteDateCourse() {
        print("delete date course 바텀시트")
    }
    
    @objc
    private func tapShareCourse() {
        print("일정 공유하기")
    }
    
    private func setButton() {
        pastDateDetailContentView.kakaoShareButton.isHidden = true
        pastDateDetailContentView.courseShareButton.isHidden = false
        
        pastDateDetailContentView.courseShareButton.addTarget(self, action: #selector(tapShareCourse), for: .touchUpInside)
    }
    
    func setColor(index: Int) {
        let colorIndex = index % 3
        if colorIndex == 0 {
            self.setBackgroundColor(color: UIColor(resource: .pink200))
        } else if colorIndex == 1 {
            self.setBackgroundColor(color: UIColor(resource: .purple200))
        } else {
            self.setBackgroundColor(color: UIColor(resource: .lime))
        }
        pastDateDetailContentView.setColor(index: index)
    }
}

// MARK: - CollectionView Methods

private extension PastDateDetailViewController {
    
    func registerCell() {
        pastDateDetailContentView.dateTimeLineCollectionView.register(DateTimeLineCollectionViewCell.self, forCellWithReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        pastDateDetailContentView.dateTimeLineCollectionView.delegate = self
        pastDateDetailContentView.dateTimeLineCollectionView.dataSource = self
    }
    
    func setUpBindings() {
        self.pastDateDetailData = pastDateDetailViewModel.pastDateDetailDummyData
    }
    
}

// MARK: - Delegate

extension PastDateDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DateDetailContentView.dateTimeLineCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
}

// MARK: - DataSource

extension PastDateDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastDateDetailData.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(pastDateDetailData.places[indexPath.item], indexPath.item)
        return cell
    }

}

