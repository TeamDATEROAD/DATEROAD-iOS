//
//  UpcomingDateScheduleViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateScheduleViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var upcomingDateScheduleView = UpcomingDateScheduleView()
    
    
    // MARK: - Properties
    
    private let upcomingDateScheduleViewModel = DateScheduleViewModel()
    
    private lazy var upcomingDateScheduleData = upcomingDateScheduleViewModel.upcomingDateScheduleDummyData
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        setUIMethods()
        setAddTarget()
        setEmptyView()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(upcomingDateScheduleView)
    }
    
    override func setLayout() {
        upcomingDateScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UI Setting Methods

private extension UpcomingDateScheduleViewController {
    @objc
    func pushToDateRegisterVC() {
        if (upcomingDateScheduleData.dateCards.count) >= 5 {
            
        } else {
            print("일정 등록으로 이동")
        }
    }
    
    @objc
    func pushToPastDateVC() {
        let pastDateVC = PastDateViewController()
        self.navigationController?.pushViewController(pastDateVC, animated: true)
    }
    
    func setUIMethods() {
        upcomingDateScheduleView.cardPageControl.do {
            $0.numberOfPages = upcomingDateScheduleData.dateCards.count
        }
    }
    
    func setAddTarget() {
        upcomingDateScheduleView.dateRegisterButton.do {
            $0.addTarget(self, action: #selector(dateRegisterButtonTapped), for: .touchUpInside)
        }
        
        upcomingDateScheduleView.pastDateButton.do {
            $0.addTarget(self, action: #selector(pushToPastDateVC), for: .touchUpInside)
        }
    }
    
    func setEmptyView() {
        if upcomingDateScheduleData.dateCards.count == 0 {
            upcomingDateScheduleView.emptyView.isHidden = false
        }
    }
    
}

// MARK: - Alert Delegate

extension UpcomingDateScheduleViewController: CustomAlertDelegate {
    @objc
    private func dateRegisterButtonTapped() {
        if upcomingDateScheduleViewModel.isMoreThanFiveSchedule {
            let customAlertVC = CustomAlertViewController(alertTextType: .hasDecription, alertButtonType: .oneButton, titleText: StringLiterals.Alert.noMoreSchedule, descriptionText: StringLiterals.Alert.noMoreThanFive, longButtonText: StringLiterals.Alert.iChecked)
            customAlertVC.delegate = self
            customAlertVC.modalPresentationStyle = .overFullScreen
            self.present(customAlertVC, animated: false)
        } else {
            print("push to 일정등록하기")
        }
        
    }
}

// MARK: - CollectionView Methods

private extension UpcomingDateScheduleViewController {
    
    func registerCell() {
        upcomingDateScheduleView.cardCollectionView.register(DateCardCollectionViewCell.self, forCellWithReuseIdentifier: DateCardCollectionViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        upcomingDateScheduleView.cardCollectionView.delegate = self
        upcomingDateScheduleView.cardCollectionView.dataSource = self
    }
    
    func setUpBindings(upcomingDateScheduleData: DateScheduleModel) {
        upcomingDateScheduleView.upcomingDateScheduleData = upcomingDateScheduleData
        upcomingDateScheduleView.cardCollectionView.reloadData()
    }
}

// MARK: - Delegate

extension UpcomingDateScheduleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UpcomingDateScheduleView.dateCardCollectionViewLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: ScreenUtils.width * 0.112, bottom: 0, right: ScreenUtils.width * 0.112)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = UpcomingDateScheduleView.dateCardCollectionViewLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        upcomingDateScheduleView.updatePageControlSelectedIndex(index: Int(roundedIndex))
    }
}


// MARK: - DataSource

extension UpcomingDateScheduleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingDateScheduleData.dateCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(upcomingDateScheduleData.dateCards[indexPath.item], indexPath.item)
        cell.setColor(index: indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc 
    func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: upcomingDateScheduleView.cardCollectionView)
        if let indexPath = upcomingDateScheduleView.cardCollectionView.indexPathForItem(at: location) {
            let upcomingDateDetailVC = UpcomingDateDetailViewController()
            self.navigationController?.pushViewController(upcomingDateDetailVC, animated: true)
            upcomingDateDetailVC.upcomingDateDetailContentView.dataBind(upcomingDateScheduleData.dateCards[indexPath.item])
            upcomingDateDetailVC.setColor(index: indexPath.item)
        }
    }
}
  
