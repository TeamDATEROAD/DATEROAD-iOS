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
    
//    private let loadingView: DRLoadingView = DRLoadingView()

    private let errorView: DRErrorViewController = DRErrorViewController()
    
    // MARK: - Properties
    
    var pastDateDetailViewModel: DateDetailViewModel? = nil
    
    private let dateScheduleDeleteView = DateScheduleDeleteView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftBackButton()
        setTitleLabelStyle(title: "지난 데이트", alignment: .center)
        setRightButtonStyle(image: UIImage(resource: .moreButton))
        setRightButtonAction(target: self, action: #selector(deleteDateCourse))
        bindViewModel()
        setButton()
        registerCell()
        setDelegate()
    }
    
    
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubviews(pastDateDetailContentView)
        
    }
    
    override func setLayout() {
        super.setLayout()
        
//        loadingView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
        pastDateDetailContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PastDateDetailViewController: DRCustomAlertDelegate {
    @objc
    func tapDeleteLabel() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: .deleteCourse, alertTextType: .hasDecription, alertButtonType: .twoButton, titleText: StringLiterals.Alert.deletePastDateSchedule, descriptionText: StringLiterals.Alert.noMercy, rightButtonText: "삭제")
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }

    func action(rightButtonAction: RightButtonType) {
        if rightButtonAction == .deleteCourse {
            pastDateDetailViewModel?.deleteDateSchdeuleData(dateID: pastDateDetailViewModel?.dateDetailData.value?.dateID ?? 0)
            print("헉 헤어졌나??? 서버연결 delete")
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - BottomSheet Methods

extension PastDateDetailViewController: DRBottomSheetDelegate {
    @objc
    private func deleteDateCourse() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(didTapFirstLabel))
        dateScheduleDeleteView.deleteLabel.addGestureRecognizer(labelTap)
        let bottomSheetVC = DRBottomSheetViewController(contentView: dateScheduleDeleteView, height: 222, buttonType: DisabledButton(), buttonTitle: StringLiterals.DateSchedule.quit)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.delegate = self
        self.present(bottomSheetVC, animated: false)
    }
    
    func didTapBottomButton() {
        self.dismiss(animated: false)
    }
    
    @objc
    func didTapFirstLabel() {
        self.dismiss(animated: false)
        tapDeleteLabel()
    }
}

// MARK: - UI Setting Methods

extension PastDateDetailViewController {
    func bindViewModel() {
        self.pastDateDetailViewModel?.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.pastDateDetailViewModel?.isSuccessGetDateDetailData.bind { [weak self] isSuccess in
            guard let isSuccess, let data = self?.pastDateDetailViewModel?.dateDetailData.value else { return }
            if isSuccess {
                self?.pastDateDetailContentView.dataBind(data)
                self?.pastDateDetailContentView.dateTimeLineCollectionView.reloadData()
            }
        }
        
        self.pastDateDetailViewModel?.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
//            self?.errorView.isHidden = !onFailure
            self?.pastDateDetailContentView.isHidden = onFailure
            self?.tabBarController?.tabBar.isHidden = onFailure
            if onFailure {
//                self?.loadingView.isHidden = true
            }
        }
        
    }
    
    @objc
    private func tapShareCourse() {
        print("코스 등록해서 공유하기 여기!!!!!!!!!!!!")
       guard let data = pastDateDetailViewModel?.dateDetailData.value else {
               print("No date detail data available")
               return
           }
           
           let addCourseViewModel = AddCourseViewModel(pastDateDetailData: data)
           let vc = AddCourseFirstViewController(viewModel: addCourseViewModel)
           self.navigationController?.pushViewController(vc, animated: false)
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
        return pastDateDetailViewModel?.dateDetailData.value?.places.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = pastDateDetailViewModel?.dateDetailData.value?.places[indexPath.item] else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(data, indexPath.item)
        return cell
    }

}

//extension PastDateDetailViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.pastDateDetailViewModel?.setDateDetailLoading()
//            }
//        }
//    }
//}
