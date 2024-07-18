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
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
//        bindViewModel()
         drawDateCardView()
        print("~~~~")
        
//        registerCell()
//        setDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        setUIMethods()
        setAddTarget()
        setEmptyView()
//        bindViewModel()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(upcomingDateScheduleView)
    }
    
    override func setLayout() {
        upcomingDateScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func drawDateCardView() {
        print("hi im drawing")
        self.upcomingDateScheduleViewModel.getUpcomingDateScheduleData()
//        reload()
        
    }
    
    func reload() {
        print("~~~")
        upcomingDateScheduleView.cardCollectionView.reloadData()
    }
}

// MARK: - UI Setting Methods

private extension UpcomingDateScheduleViewController {
    @objc
    func pushToDateRegisterVC() {
        if (upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0) >= 5 {
            dateRegisterButtonTapped()
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
            $0.numberOfPages = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
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
        if upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count == 0 {
            upcomingDateScheduleView.emptyView.isHidden = false
        }
    }
    
    func bindViewModel() {
        self.upcomingDateScheduleViewModel.isSuccessGetUpcomingDateScheduleData.bind { [weak self] isSuccess in
            self?.upcomingDateScheduleViewModel.isSuccessGetUpcomingDateScheduleData.value = false
            self?.upcomingDateScheduleView.cardCollectionView.reloadData()
            
//            guard let isSuccess else { return }
//            if isSuccess {
//
                
//            
//            }
        }
//        self.upcomingDateScheduleViewModel.upcomingDateScheduleData.bind { [weak self] _ in
//            self?.upcomingDateScheduleView.cardCollectionView.reloadData()
//        }
    }
}

// MARK: - Alert Delegate

extension UpcomingDateScheduleViewController: DRCustomAlertDelegate {
    @objc
    private func dateRegisterButtonTapped() {
        if upcomingDateScheduleViewModel.isMoreThanFiveSchedule {
            let customAlertVC = DRCustomAlertViewController(rightActionType: RightButtonType.none, alertTextType: .hasDecription, alertButtonType: .oneButton, titleText: StringLiterals.Alert.noMoreSchedule, descriptionText: StringLiterals.Alert.noMoreThanFive, longButtonText: StringLiterals.Alert.iChecked)
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
        return upcomingDateScheduleViewModel.upcomingDateScheduleData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.row] ?? DateCardModel(dateID: 0, title: "", date: "", city: "", tags: [], dDay: 0)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCardCollectionViewCell.cellIdentifier, for: indexPath) as? DateCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        print("🥵🥵🥵")
        cell.dataBind(data, indexPath.row)
        cell.setColor(index: indexPath.row)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToUpcomingDateDetailVC(_:))))
        return cell
    }
    
    @objc 
    func pushToUpcomingDateDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: upcomingDateScheduleView.cardCollectionView)
        if let indexPath = upcomingDateScheduleView.cardCollectionView.indexPathForItem(at: location) {
            let data = upcomingDateScheduleViewModel.upcomingDateScheduleData.value?[indexPath.item] ?? DateCardModel(dateID: 0, title: "", date: "", city: "", tags: [], dDay: 0)
            let upcomingDateDetailVC = UpcomingDateDetailViewController()
            self.navigationController?.pushViewController(upcomingDateDetailVC, animated: true)
            upcomingDateDetailVC.upcomingDateScheduleView = upcomingDateScheduleView
            upcomingDateDetailVC.upcomingDateDetailViewModel = DateDetailViewModel(dateID: data.dateID)
            upcomingDateDetailVC.setColor(index: indexPath.item)
        }
    }
}
  
