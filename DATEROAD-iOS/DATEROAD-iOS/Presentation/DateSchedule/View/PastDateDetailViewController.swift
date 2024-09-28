//
//  PastDateDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class PastDateDetailViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    var pastDateDetailContentView = DateDetailContentView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    var dateID: Int
    
    var networkType: NetworkType?
    
    var pastDateDetailViewModel: DateDetailViewModel
    
    private let dateScheduleDeleteView = DateScheduleDeleteView()
    
    
    // MARK: - LifeCycle
    
    init(dateID: Int, pastDateDetailViewModel: DateDetailViewModel) {
        self.dateID = dateID
        self.pastDateDetailViewModel = pastDateDetailViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.pastDateDetailViewModel.getDateDetailData(dateID: self.dateID)
    }
    
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
        
        pastDateDetailContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PastDateDetailViewController: DRCustomAlertDelegate {
    @objc
    func tapDeleteLabel() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: .deleteCourse, 
                                                        alertTextType: .hasDecription,
                                                        alertButtonType: .twoButton,
                                                        titleText: StringLiterals.Alert.deletePastDateSchedule,
                                                        descriptionText: StringLiterals.Alert.noMercy,
                                                        rightButtonText: StringLiterals.Alert.delete)
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }

    func action(rightButtonAction: RightButtonType) {
        if rightButtonAction == .deleteCourse {
            pastDateDetailViewModel.deleteDateSchdeuleData(dateID: pastDateDetailViewModel.dateDetailData.value?.dateID ?? 0)
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
        self.pastDateDetailViewModel.onDateDetailLoading.bind { [weak self] onLoading in
            guard let onLoading,
                    let onFailNetwork = self?.pastDateDetailViewModel.onFailNetwork.value,
                    let data = self?.pastDateDetailViewModel.dateDetailData.value
            else { return }
            if !onFailNetwork {
                if onLoading {
                    self?.showLoadingView()
                    self?.pastDateDetailContentView.isHidden = true
                } else {
                    self?.pastDateDetailContentView.dataBind(data)
                    self?.pastDateDetailContentView.dateTimeLineCollectionView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self?.pastDateDetailContentView.isHidden = false
                        self?.hideLoadingView()
                    }
                }
            }
         }
        
        self.pastDateDetailViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess, let dateID = self?.dateID else { return }
            if onSuccess {
                switch self?.networkType {
                case .deleteDateSchedule:
                    self?.pastDateDetailViewModel.deleteDateSchdeuleData(dateID: dateID)
                case .getDateDetail:
                    self?.pastDateDetailViewModel.getDateDetailData(dateID: dateID)
                default:
                    self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
                }
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.pastDateDetailViewModel.isSuccessGetDateDetailData.bind { [weak self] _ in
            self?.pastDateDetailViewModel.setDateDetailLoading()
        }
        
        self.pastDateDetailViewModel.isSuccessDeleteDateScheduleData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.navigationController?.popViewController(animated: false)
            } else {
                self?.presentAlertVC(title: StringLiterals.Alert.failToDeleteSchedule)
            }
        }
        
        self.pastDateDetailViewModel.onFailNetwork.bind { [weak self] onFailure in
           guard let onFailure else { return }
           if onFailure {
              let errorVC = DRErrorViewController()
              errorVC.onDismiss = {
                 self?.pastDateDetailViewModel.onFailNetwork.value = false
                 self?.pastDateDetailViewModel.onDateDetailLoading.value = false
              }
              self?.navigationController?.pushViewController(errorVC, animated: false)
           }
        }
    }
    
   //TODO: - 추후 데이트코스 공유 코스 등록 기능 살아날 시 수정해야함.
   // isBroughtData 변수 생성하여 AddSchedule과 동일하게 수행하도록 수정
    @objc
    private func tapShareCourse() {
        print("코스 등록해서 공유하기 여기!!!!!!!!!!!!")
       guard let data = pastDateDetailViewModel.dateDetailData.value
        else { return }
           
           let addCourseViewModel = AddCourseViewModel(pastDateDetailData: data)
       let vc = AddCourseFirstViewController(viewModel: addCourseViewModel, viewPath: StringLiterals.Amplitude.ViewPath.dateSchedule)
           self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func setButton() {
        pastDateDetailContentView.kakaoShareButton.isHidden = true
        
        // TODO: - 코스 공유 버튼 확정 시 courseShareButton.isHidden = false로 변경
        pastDateDetailContentView.courseShareButton.isHidden = true
        
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
        return pastDateDetailViewModel.dateDetailData.value?.places.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = pastDateDetailViewModel.dateDetailData.value?.places[indexPath.item] else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as? DateTimeLineCollectionViewCell else {
            return UICollectionViewCell() }
        cell.dataBind(data, indexPath.item)
        return cell
    }

}

