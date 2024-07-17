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
    
    var upcomingDateDetailViewModel: DateDetailViewModel? = nil
    
    private let dateScheduleDeleteView = DateScheduleDeleteView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftBackButton()
        setTitleLabelStyle(title: StringLiterals.DateSchedule.upcomingDate, alignment: .center)
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        bindViewModel()
        setButton()
        registerCell()
        setDelegate()
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
    func bindViewModel() {
        self.upcomingDateDetailViewModel?.isSuccessGetDateDetailData.bind { [weak self] isSuccess in
            guard let isSuccess, let data = self?.upcomingDateDetailViewModel?.dateDetailData.value else { return }
            if isSuccess {
                self?.upcomingDateDetailContentView.dataBind(data)
                self?.upcomingDateDetailContentView.dateTimeLineCollectionView.reloadData()
            }
        }
    }
    
    private func setButton() {
        upcomingDateDetailContentView.dDayButton.isHidden = false
        upcomingDateDetailContentView.kakaoShareButton.isHidden = false
        upcomingDateDetailContentView.courseShareButton.isHidden = true
        
        upcomingDateDetailContentView.kakaoShareButton.addTarget(self, action: #selector(tapKakaoButton), for: .touchUpInside)
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

// MARK: - Alert Methods

extension UpcomingDateDetailViewController: DRCustomAlertDelegate {
    @objc
    func tapDeleteLabel() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: .deleteCourse, alertTextType: .hasDecription, alertButtonType: .twoButton, titleText: StringLiterals.Alert.deleteDateSchedule, descriptionText: StringLiterals.Alert.noMercy, rightButtonText: "삭제")
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    @objc
    private func tapKakaoButton() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: .kakaoShare,
                                                      alertTextType: .noDescription,
                                                      alertButtonType: .twoButton,
                                                      titleText: StringLiterals.Alert.kakaoAlert,
                                                      rightButtonText: "열기")
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    func action(rightButtonAction: RightButtonType) {
        if rightButtonAction == .deleteCourse {
            print("헉 헤어졌나??? 서버연결 delete")
        } else if rightButtonAction == .kakaoShare {
            upcomingDateDetailViewModel?.shareToKaKao()
            print("카카오 공유하기")
        }
    }
}

extension UpcomingDateDetailViewController: DRBottomSheetDelegate {
    @objc
    private func deleteDateCourse() {
        let bottomSheetVC = DRBottomSheetViewController(contentView: dateScheduleDeleteView, height: 222, buttonType: DisabledButton(), buttonTitle: StringLiterals.DateSchedule.quit)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.delegate = self
        self.present(bottomSheetVC, animated: false)
    }
    
    @objc
    func didTapFirstLabel() {
        self.dismiss(animated: false)
        tapDeleteLabel()
    }
    
    func didTapBottomButton() {
        self.dismiss(animated: false)
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
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFirstLabel))
        dateScheduleDeleteView.deleteLabel.addGestureRecognizer(deleteGesture)
        
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
        return upcomingDateDetailViewModel?.dateDetailData.value?.places.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = upcomingDateDetailViewModel?.dateDetailData.value?.places[indexPath.item] else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(data, indexPath.item)
        return cell
    }

}
