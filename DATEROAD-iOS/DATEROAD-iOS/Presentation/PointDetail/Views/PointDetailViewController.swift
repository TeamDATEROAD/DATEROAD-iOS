//
//  PointDetailsViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/3/24.
//

import UIKit

import SnapKit
import Then

class PointDetailViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let pointDetailView = PointDetailView()
    
    // MARK: - Properties
    
    private let pointViewModel = PointViewModel()
    
    private lazy var gainedPointDummyData = pointViewModel.pointDummyData.gained
    
    private lazy var usedPointDummyData = pointViewModel.pointDummyData.used
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.PointDetail.title, alignment: .center)
        setProfile(userName: "수민", totalPoint: 200) // 나중에 푸쉬 전 뷰(메인뷰, 마이페이지뷰)에서 실행
        registerCell()
        setDelegate()
        setAddTarget()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubviews(pointDetailView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        pointDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}


extension PointDetailViewController {
    func bindViewModel() {
//        self.pointViewModel.isSuccessGetPointInfo.bind { [weak self] data in
//            self?.pointDetailView.pointCollectionView.reloadData()
//        }
        
        self.pointViewModel.nowPointData.bind { [weak self] data in
            self?.pointDetailView.pointCollectionView.reloadData()
        }
    }
    
    func setProfile(userName: String, totalPoint: Int) {
        pointDetailView.userNameLabel.text = "\(userName) 님의 포인트"
        pointDetailView.totalPointLabel.text = "\(totalPoint) P"
    }
    
    private func setAddTarget() {
        pointDetailView.segmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
    }
}

// MARK: - Private Method

private extension PointDetailViewController {
    @objc
    func didChangeValue(segment: UISegmentedControl) {
        pointViewModel.changeSegment(segmentIndex: pointDetailView.segmentControl.selectedSegmentIndex)
        changeSelectedSegmentLayout(isEarnedPointHidden: pointViewModel.isEarnedPointHidden.value)
    }
    
    func changeSelectedSegmentLayout(isEarnedPointHidden: Bool?) {
        guard let isEarnedPointHidden = isEarnedPointHidden else { return }
//        print(isEarnedPointHidden)
        if isEarnedPointHidden {
            switch pointViewModel.usedPointData.value?.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyUsedPointView)
            case false:
                setSegmentViewHidden(pointDetailView.pointCollectionView)
                pointDetailView.pointCollectionView.reloadData()
            }
            
            pointDetailView.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().inset(ScreenUtils.width/2)
            }
        } else {
            switch pointViewModel.gainedPointData.value?.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyGainedPointView)
            case false:
                setSegmentViewHidden(pointDetailView.pointCollectionView)
                pointDetailView.pointCollectionView.reloadData()
            }

            pointDetailView.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview()
            }
        }
    }
}

// MARK: - CollectionView Methods

extension PointDetailViewController {
    private func registerCell() {
        pointDetailView.pointGainedCollectionView.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: PointCollectionViewCell.cellIdentifier)
        
        pointDetailView.pointUsedCollectionView.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: PointCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        pointDetailView.pointGainedCollectionView.delegate = self
        pointDetailView.pointGainedCollectionView.dataSource = self
        
        pointDetailView.pointUsedCollectionView.delegate = self
        pointDetailView.pointUsedCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PointDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenUtils.width, height: 86)
    }
}

// MARK: - UICollectionViewDataSource

extension PointDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case pointDetailView.pointGainedCollectionView:
            return gainedPointDummyData.count
        case pointDetailView.pointUsedCollectionView:
            return usedPointDummyData.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.cellIdentifier, for: indexPath) as? PointCollectionViewCell else { return UICollectionViewCell() }
        
        switch collectionView {
        case pointDetailView.pointGainedCollectionView:
            cell.dataBind(gainedPointDummyData[indexPath.item], indexPath.item)
        case pointDetailView.pointUsedCollectionView:
            cell.dataBind(usedPointDummyData[indexPath.item], indexPath.item)
        default:
            print("그 컬뷰 없어요")
        }
        
        return cell
    }
}
