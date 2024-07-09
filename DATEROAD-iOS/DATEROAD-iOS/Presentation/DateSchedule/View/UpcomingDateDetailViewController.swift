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
        setTitleLabelStyle(title: "데이트 일정")
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        
        setButton()
        setUpBindings()
        setDataSource()
       
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

extension UpcomingDateDetailViewController {
    
    @objc
    func deleteDateCourse() {
        print("delete date course 바텀시트")
    }
    
    @objc
    func kakaoShareCourse() {
        print("카카오 공유하기")
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
    
    func setUpBindings() {
        upcomingDateDetailContentView.kakaoShareButton.addTarget(self, action: #selector(kakaoShareCourse), for: .touchUpInside)
        
        self.upcomingDateDetailData = upcomingDateDetailViewModel.upcomingDateDetailDummyData
    }
    

}


// MARK: - CollectionView Methods

extension UpcomingDateDetailViewController {
    
    func setButton() {
        upcomingDateDetailContentView.kakaoShareButton.isHidden = false
        upcomingDateDetailContentView.courseShareButton.isHidden = true
    }
    
    func setDataSource() {
        upcomingDateDetailContentView.dateTimeLineCollectionView.dataSource = self
    }
    
    func setUpBindings(upcomingDateDetailData: DateTimeLineModel) {
        self.upcomingDateDetailData = upcomingDateDetailData
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
