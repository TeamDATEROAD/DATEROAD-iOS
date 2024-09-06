//
//  MyPageViewController.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

import AuthenticationServices

final class MyPageViewController: BaseNavBarViewController {
    
    // MARK: - UI Properties
    
    private let myPageView: MyPageView = MyPageView()
    
    private let loadingView: DRLoadingView = DRLoadingView()
    
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    
    // MARK: - Properties
    
    private var myPageViewModel: MyPageViewModel
    
    private var loginViewModel: LoginViewModel = LoginViewModel()
    
    private var selectedAlertFlag: Int = 0
    
    // MARK: - Life Cycle
    
    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myPageViewModel.setLoading()
        self.myPageViewModel.getUserProfile()
        self.myPageViewModel.checkSocialLogin()
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
        
        self.view.addSubview(loadingView)
        self.contentView.addSubview(myPageView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.view.backgroundColor = UIColor(resource: .drWhite)
        self.topInsetView.backgroundColor = UIColor(resource: .gray100)
        self.navigationBarView.backgroundColor = UIColor(resource: .gray100)
        self.titleLabel.isHidden = false
    }
    
}


// MARK: - Private Methods

private extension MyPageViewController {
    
    func registerCell() {
        self.myPageView.userInfoView.tagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
        self.myPageView.myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.cellIdentifier)
    }
    
    func setDelegate() {
        self.myPageView.userInfoView.tagCollectionView.delegate = self
        self.myPageView.userInfoView.tagCollectionView.dataSource = self
        self.myPageView.myPageTableView.delegate = self
        self.myPageView.myPageTableView.dataSource = self
    }
    
    func bindViewModel() {
        self.myPageViewModel.onFailNetwork.bind { [weak self] onFailure in
            guard let onFailure else { return }
            if onFailure {
                let errorVC = DRErrorViewController()
                self?.navigationController?.pushViewController(errorVC, animated: false)
            }
        }
        
        self.myPageViewModel.onLoading.bind { [weak self] onLoading in
            guard let onLoading, let onFailNetwork = self?.myPageViewModel.onFailNetwork.value else { return }
            if !onFailNetwork {
                self?.loadingView.isHidden = !onLoading
                self?.myPageView.isHidden = onLoading
                self?.topInsetView.isHidden = onLoading
                self?.navigationBarView.isHidden = onLoading
                self?.tabBarController?.tabBar.isHidden = onLoading
            }
        }
        
        self.myPageViewModel.onReissueSuccess.bind { [weak self] onSuccess in
            guard let onSuccess else { return }
            if onSuccess {
                // TODO: - 서버 통신 재시도
            } else {
                self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
            }
        }
        
        self.myPageViewModel.onSuccessLogout.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.navigationController?.popToRootViewController(animated: false)
            }
        }
        
        self.myPageViewModel.onSuccessWithdrawal.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.navigationController?.popToRootViewController(animated: false)
            }
        }
        
        self.myPageViewModel.onSuccessGetUserProfile.bind { [weak self] isSuccess in
            guard let isSuccess, let data = self?.myPageViewModel.userInfoData.value else { return }
            if isSuccess {
                self?.myPageView.userInfoView.bindData(userInfo: data)
                self?.myPageView.userInfoView.tagCollectionView.reloadData()
            }
        }
    }
    
    func setAddTarget() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushToPointDetailVC))
        self.myPageView.userInfoView.goToPointHistoryStackView.addGestureRecognizer(gesture)
        
        let editProfileGesture = UITapGestureRecognizer(target: self, action: #selector(pushToProfileVC))
        self.myPageView.userInfoView.editProfileButton.addGestureRecognizer(editProfileGesture)
        
        self.myPageView.withdrawalButton.addTarget(self, action: #selector(withDrawalButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func pushToPointDetailVC() {
        self.navigationController?.pushViewController(PointDetailViewController(pointViewModel: PointViewModel(userName: myPageViewModel.userInfoData.value?.nickname ?? "-", totalPoint: myPageViewModel.userInfoData.value?.point ?? 10)), animated: false)
    }
    
    @objc
    func pushToProfileVC() {
        if let userInfoData = self.myPageViewModel.userInfoData.value {
            let nickname = userInfoData.nickname
            let tags = userInfoData.tagList
            
            let profile = ProfileModel(profileImage: self.myPageView.userInfoView.profileImageView.image, nickname: nickname, tags: tags)
            let profileVC = EditProfileViewController(profileViewModel: ProfileViewModel(profileData: profile))
            
            self.navigationController?.pushViewController(profileVC, animated: false)
        }
    }
    
}

extension MyPageViewController: DRCustomAlertDelegate {
    
    @objc
    private func logOutSectionTapped() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: RightButtonType.logout, 
                                                        alertTextType: .noDescription,
                                                        alertButtonType: .twoButton,
                                                        titleText: StringLiterals.Alert.wouldYouLogOut,
                                                        leftButtonText: StringLiterals.Common.cancel,
                                                        rightButtonText: StringLiterals.MyPage.logout)
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        selectedAlertFlag = 0
        self.present(customAlertVC, animated: false)
    }
    
    @objc
    private func withDrawalButtonTapped() {
        let customAlertVC = DRCustomAlertViewController(rightActionType: RightButtonType.none, 
                                                        alertTextType: .noDescription,
                                                        alertButtonType: .twoButton,
                                                        titleText: StringLiterals.Alert.realWithdrawal,
                                                        descriptionText: StringLiterals.Alert.lastWarning, 
                                                        leftButtonText: StringLiterals.MyPage.alertWithdrawal,
                                                        rightButtonText: StringLiterals.Common.cancel)
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        selectedAlertFlag = 1
        self.present(customAlertVC, animated: false)
    }
    
    func action(rightButtonAction: RightButtonType) {
        if selectedAlertFlag == 0 {
            myPageViewModel.deleteLogout()
        }
    }
    
    func exit() {
        if selectedAlertFlag == 1 {
            if self.myPageViewModel.isAppleLogin {
                appleLogin()
            }
            myPageViewModel.deleteWithdrawal()
        }
    }
    
    func appleLogin() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

// MARK: - UICollectionView Delegates

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let tagTitle = TendencyTag.getTag(byEnglish: self.myPageViewModel.tagData[indexPath.item])?.tag.tagTitle else { return CGSize(width: 100, height: 30) }
        let font = UIFont.suit(.body_med_13)
        let textWidth = tagTitle.width(withConstrainedHeight: 30, font: font) + 50
        
        return CGSize(width: textWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
}

extension MyPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = myPageViewModel.userInfoData.value ?? MyPageUserInfoModel(nickname: "", tagList: [], point: 0, imageURL: "")
        return data.tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTagCollectionViewCell else { return UICollectionViewCell() }
        let data = myPageViewModel.userInfoData.value ?? MyPageUserInfoModel(nickname: "", tagList: [], point: 0, imageURL: "")
        cell.updateButtonTitle(title: data.tagList[indexPath.row])
        if indexPath.row == self.myPageView.userInfoView.tagCollectionView.numberOfItems(inSection: indexPath.section) - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.myPageViewModel.setLoading()
            }
        }
        return cell
    }
    
}

// MARK: - UITableView Delegates

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
            let inquiryVC = DRWebViewController(urlString: StringLiterals.WebView.inquiryLink)
            self.present(inquiryVC, animated: true)
        case .logout:
            logOutSectionTapped()
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

extension MyPageViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return }
        
        self.loginViewModel.loginWithApple(userInfo: credential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        let alert = UIAlertController(title: "로그인 실패", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
    
}
