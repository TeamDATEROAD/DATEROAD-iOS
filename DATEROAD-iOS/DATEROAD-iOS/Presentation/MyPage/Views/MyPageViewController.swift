//
//  MyPageViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class MyPageViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let myPageView: MyPageView = MyPageView()
    
    
    // MARK: - Properties
    
    private var myPageViewModel: MyPageViewModel
    
    private var selectedAlertFlag: Int = 0
    
    // MARK: - Life Cycle
    
    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabelStyle(title: StringLiterals.MyPage.myPage, alignment: .left)
        setHierarchy()
        setStyle()
        registerCell()
        setDelegate()
        bindViewModel()
        setAddTarget()
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.contentView.addSubview(myPageView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.topInsetView.backgroundColor = UIColor(resource: .gray100)
        self.navigationBarView.backgroundColor = UIColor(resource: .gray100)
        self.titleLabel.isHidden = false
    }
    
}


// MARK: - Private Methods

private extension MyPageViewController {
    
    func registerCell() {
        self.myPageView.userInfoView.tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.cellIdentifier)
        self.myPageView.myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.myPageView.userInfoView.tagCollectionView.delegate = self
        self.myPageView.userInfoView.tagCollectionView.dataSource = self
        self.myPageView.myPageTableView.delegate = self
        self.myPageView.myPageTableView.dataSource = self
    }
    
    func bindViewModel() {
        self.myPageViewModel.dummyData.bind { [weak self] data in
            guard let data else { return }
            self?.myPageView.userInfoView.bindData(userInfo: data)
        }
    }
    
    func setAddTarget() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushToPointDetailVC))
        self.myPageView.userInfoView.goToPointHistoryStackView.addGestureRecognizer(gesture)
        self.myPageView.withdrawalButton.addTarget(self, action: #selector(withDrawalButtonTapped), for: .touchUpInside)
    }
    
    // TODO: - 추후 뷰컨 수정 예정
    @objc
    func pushToPointDetailVC() {
        self.navigationController?.pushViewController(PointDetailViewController(), animated: false)
    }
    
    @objc
    func pushToWithdrawalVC() {
        print("탈퇴하세요 그러세요 그럼")
    }

}

extension MyPageViewController: CustomAlertDelegate {
    
    @objc
    private func logOutSectionTapped() {
        let customAlertVC = CustomAlertViewController(alertTextType: .noDescription, alertButtonType: .twoButton, titleText: StringLiterals.Alert.wouldYouLogOut, leftButtonText: "취소", rightButtonText: "로그아웃")
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        selectedAlertFlag = 0
        self.present(customAlertVC, animated: false)
    }
    
    @objc
    private func withDrawalButtonTapped() {
        let customAlertVC = CustomAlertViewController(alertTextType: .noDescription, alertButtonType: .twoButton, titleText: StringLiterals.Alert.realWithdrawal, descriptionText: StringLiterals.Alert.lastWarning, leftButtonText: "탈퇴", rightButtonText: "취소")
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        selectedAlertFlag = 1
        self.present(customAlertVC, animated: false)
    }
    
    func action() {
        if selectedAlertFlag == 0 {
            print("로그아웃하세요 ~~")
        }
    }
    
    func exit() {
        if selectedAlertFlag == 1 {
            pushToWithdrawalVC()
        }
    }
}

// MARK: - UICollectionView Delegates

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = myPageViewModel.dummyTagData.value?[indexPath.item]
        let font = UIFont.suit(.body_med_13)
        let textWidth = tagTitle?.width(withConstrainedHeight: 30, font: font) ?? 90
        let padding: CGFloat = 28
                
       return CGSize(width: textWidth + padding, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

// TODO: - 추후 데이터 수정

extension MyPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPageViewModel.dummyTagData.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.cellIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        if let model = myPageViewModel.dummyTagData.value {
            cell.updateButtonTitle(title: model[indexPath.row])
        }
        return cell
    }
    
}

// MARK: - UITableView Delegates

// TODO: - 뷰컨 변경 예정

extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MyPageSection.dataSource[indexPath.item] {
        case .myCourse:
            let myCourseVC = MyRegisterCourseViewController()
            self.navigationController?.pushViewController(myCourseVC, animated: false)
        case .pointSystem:
            let pointSystemVC = PointSystemViewController(pointSystemViewModel: PointSystemViewModel())
            self.navigationController?.pushViewController(pointSystemVC, animated: false)
        case .inquiry:
            // 웹뷰는 present?
            let inquiryVC = OnboardingViewController()
            self.navigationController?.pushViewController(inquiryVC, animated: false)
        case .logout:
            logOutSectionTapped()
            /*
            let pointSystemVC = ProfileViewController(profileViewModel: ProfileViewModel())
            self.navigationController?.pushViewController(pointSystemVC, animated: false)
             */
        }
    }
    
}

extension MyPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPageSection.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.cellIdentifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        var title: String = ""
        
        switch MyPageSection.dataSource[indexPath.item] {
        case .myCourse:
            title = MyPageSection.myCourse.title
        case .pointSystem:
            title = MyPageSection.pointSystem.title
        case .inquiry:
            title = MyPageSection.inquiry.title
        case .logout:
            title = MyPageSection.logout.title
        }
        cell.bindTitle(title: title)
        cell.selectionStyle = .none
        return cell
    }
    
}
