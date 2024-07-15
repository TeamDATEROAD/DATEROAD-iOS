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
    
    private var pointViewModel: PointViewModel
    
//    private lazy var gainedPointDummyData = pointViewModel.pointDummyData.gained
//    
//    private lazy var usedPointDummyData = pointViewModel.pointDummyData.used
    
    // MARK: - LifeCycle
    
    init(pointViewModel: PointViewModel) {
        self.pointViewModel = pointViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.PointDetail.title, alignment: .center)
        setProfile(userName: "수민", totalPoint: 200) // 나중에 푸쉬 전 뷰(메인뷰, 마이페이지뷰)에서 실행
        registerCell()
        setDelegate()
        setAddTarget()
        changeSelectedSegmentLayout(isEarnedPointHidden: false)
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
    
    func setSegmentViewHidden(_ view: UIView) {
        pointDetailView.pointUsedCollectionView.isHidden = true
        pointDetailView.pointGainedCollectionView.isHidden = true
        pointDetailView.emptyUsedPointView.isHidden = true
        pointDetailView.emptyGainedPointView.isHidden = true
        view.isHidden = false
        print(view)
    }
    
    func changeSelectedSegmentLayout(isEarnedPointHidden: Bool?) {
        guard let isEarnedPointHidden = isEarnedPointHidden else { return }
        print(isEarnedPointHidden)
        if isEarnedPointHidden {
            switch pointViewModel.usedDummyData.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyUsedPointView)
            case false:
                setSegmentViewHidden(pointDetailView.pointUsedCollectionView)
            }
            
            pointDetailView.selectedSegmentUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().inset(ScreenUtils.width/2)
            }
        } else {
            switch pointViewModel.gainedDummyData.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyGainedPointView)
            case false:
                setSegmentViewHidden(pointDetailView.pointGainedCollectionView)
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
        print("ho")
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
        print("cellsize")
        return CGSize(width: ScreenUtils.width, height: 86)
    }
}

// MARK: - UICollectionViewDataSource

extension PointDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pointDetailView.pointGainedCollectionView {
            print(pointViewModel.gainedDummyData.count)
            return pointViewModel.gainedDummyData.count
        } else {
            return pointViewModel.usedDummyData.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.cellIdentifier, for: indexPath) as? PointCollectionViewCell else { return UICollectionViewCell() }
        if collectionView == pointDetailView.pointGainedCollectionView {
            cell.dataBind(pointViewModel.gainedDummyData[indexPath.item], indexPath.item)
        } else {
            cell.dataBind(pointViewModel.usedDummyData[indexPath.item], indexPath.item)
        }
        return cell
    }
}
