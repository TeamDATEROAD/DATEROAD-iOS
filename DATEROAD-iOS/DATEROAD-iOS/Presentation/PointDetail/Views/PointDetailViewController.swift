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
        setProfile(userName: pointViewModel.userName, totalPoint: pointViewModel.totalPoint)
        registerCell()
        setDelegate()
        setAddTarget()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
       self.pointViewModel.isChange.bind { [weak self] isSuccess in
          guard let isSuccess else {return}
          if isSuccess == true {
             self?.pointDetailView.pointCollectionView.reloadData()
//             if pointViewModel.nowPointData.value.count == 0 {
////                setSegmentViewHidden(pointDetailView.emptyGainedPointView)
//                changeSelectedSegmentLayout
//             } else {
//
//             }
             self?.changeSelectedSegmentLayout(isEarnedPointHidden: false)
             

          } else {
             print("SDAfsdafsdafsdafdsafsdafsadfsad")
          }
       }
       
       setDelegate()
       setAddTarget()
       bindViewModel()
        pointViewModel.getPointDetail(nowEarnedPointHidden: false)
//       bindViewModel()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
        self.pointViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        // 선택된 내역의 데이터
        self.pointViewModel.nowPointData.bind { [weak self] data in
            print("좀 되라 \(data)")
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
    
    func setSegmentViewHidden(_ view: UIView) {
        pointDetailView.pointCollectionView.isHidden = true
        pointDetailView.emptyUsedPointView.isHidden = true
        pointDetailView.emptyGainedPointView.isHidden = true
        view.isHidden = false
    }
    
    func changeSelectedSegmentLayout(isEarnedPointHidden: Bool?) {
        guard let isEarnedPointHidden = isEarnedPointHidden else { return }
        print(isEarnedPointHidden)
        if isEarnedPointHidden {
            switch pointViewModel.usedPointData.value?.count == 0 {
            case true:
                setSegmentViewHidden(pointDetailView.emptyUsedPointView)
                pointDetailView.pointCollectionView.reloadData()
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
                pointDetailView.pointCollectionView.reloadData()
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
        pointDetailView.pointCollectionView.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: PointCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        pointDetailView.pointCollectionView.delegate = self
        pointDetailView.pointCollectionView.dataSource = self
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
        return pointViewModel.nowPointData.value?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.cellIdentifier, for: indexPath) as? PointCollectionViewCell else { return UICollectionViewCell() }
//        pointViewModel.updateData(nowEarnedPointHidden: pointViewModel.isEarnedPointHidden.value ?? false)
        let data = pointViewModel.nowPointData.value?[indexPath.item] ?? PointDetailModel(sign: "", point: 0, description: "", createdAt: "")
        cell.dataBind(data, indexPath.item)
//        cell.prepareForReuse()
        return cell
    }
}
