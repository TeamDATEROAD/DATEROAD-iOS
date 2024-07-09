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
    
    var currentIndex: CGFloat = 0
    
    private let pastDateDetailViewModel = DateDetailViewModel()

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftBackButton()
        setTitleLabelStyle(title: "지난 데이트")
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        
        setButton()
        setUpBindings()
        setDataSource()
       
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

extension PastDateDetailViewController {
    
    @objc
    func deleteDateCourse() {
        print("delete date course 바텀시트")
    }
    
    @objc
    func kakaoShareCourse() {
        print("카카오 공유하기")
    }
    
    func setUpBindings() {
        //pastDateDetailContentView.kakaoShareButton.addTarget(self, action: #selector(kakaoShareCourse), for: .touchUpInside)
        
        self.pastDateDetailData = pastDateDetailViewModel.pastDateDetailDummyData
    }

}


// MARK: - CollectionView Methods

extension PastDateDetailViewController {
    
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
    
    func setButton() {
        pastDateDetailContentView.kakaoShareButton.isHidden = true
        pastDateDetailContentView.courseShareButton.isHidden = false
    }
    
    func setDataSource() {
        pastDateDetailContentView.dateTimeLineCollectionView.dataSource = self
    }
    
    func setUpBindings(pastDateDetailData: DateTimeLineModel) {
        self.pastDateDetailData = pastDateDetailData
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

