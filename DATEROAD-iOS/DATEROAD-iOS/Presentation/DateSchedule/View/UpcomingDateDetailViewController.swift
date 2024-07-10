//
//  UpcomingDateDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateDetailViewController: BaseNavBarViewController {

    // MARK: - UI Properties
    
    var upcomingDateDetailContentView = DateDetailContentView()
    
    // MARK: - Properties
    
    var upcomingDateDetailData = DateTimeLineModel(startTime: "", places: [])
    
    var currentIndex: CGFloat = 0
    
    private let upcomingDateDetailViewModel = DateDetailViewModel()

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.DateSchedule.upcomingDate)
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        
        setButton()
        registerCell()
        setDelegate()
        setUpBindings()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubviews(upcomingDateDetailContentView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
        upcomingDateDetailContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UI Setting Methods

extension UpcomingDateDetailViewController {
    @objc
    private func deleteDateCourse() {
        print("delete date course 바텀시트")
    }
    
    @objc
    private func kakaoShareCourse() {
        print("카카오 공유하기")
    }
    
    private func setButton() {
        upcomingDateDetailContentView.kakaoShareButton.isHidden = false
        upcomingDateDetailContentView.courseShareButton.isHidden = true
        
        upcomingDateDetailContentView.kakaoShareButton.addTarget(self, action: #selector(kakaoShareCourse), for: .touchUpInside)
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
        upcomingDateDetailContentView.setColor(index: index)
    }
}


// MARK: - CollectionView Methods

private extension UpcomingDateDetailViewController {
    func registerCell() {
        upcomingDateDetailContentView.dateTimeLineCollectionView.register(DateTimeLineCollectionViewCell.self, forCellWithReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        upcomingDateDetailContentView.dateTimeLineCollectionView.delegate = self
        upcomingDateDetailContentView.dateTimeLineCollectionView.dataSource = self
    }
    
    func setUpBindings() {
        self.upcomingDateDetailData = upcomingDateDetailViewModel.upcomingDateDetailDummyData
    }

}

// MARK: - Delegate

extension UpcomingDateDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DateDetailContentView.dateTimeLineCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
}

// MARK: - DataSource

extension UpcomingDateDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateDetailData.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(upcomingDateDetailData.places[indexPath.item], indexPath.item)
        return cell
    }

}
