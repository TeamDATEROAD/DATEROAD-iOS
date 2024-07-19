//
//  CourseDetailViewController.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/12/24.
//

import UIKit

import SnapKit
import Then

final class CourseDetailViewController: BaseViewController, DRCustomAlertDelegate {
    
    
    // MARK: - UI Properties
    
    private let courseDetailView: CourseDetailView
    
    private let courseInfoTabBarView = CourseBottomTabBarView()
    
    private var deleteCourseSettingView = DeleteCourseSettingView()
    
    // MARK: - Properties
    
    private let courseDetailViewModel: CourseDetailViewModel
    
    private var currentPage: Int = 0
    
    var courseId: Int?
    
    init(viewModel: CourseDetailViewModel) {
        self.courseDetailViewModel = viewModel
        self.courseDetailViewModel.getCourseDetail()
        
        self.courseDetailView = CourseDetailView(courseDetailSection:self.courseDetailViewModel.sections)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //            setSetctionCount()
        bindViewModel()
        setDelegate()
        registerCell()
        setAddTarget()
        
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.view.addSubviews(courseDetailView, courseInfoTabBarView)
    }
    
    override func setLayout() {
        super.setLayout()
        
        courseDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        courseInfoTabBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(108)
        }
        
    }
    
    override func setStyle() {
        super.setStyle()
        
        self.view.backgroundColor = UIColor(resource: .drWhite)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    func bindViewModel() {
        self.courseDetailViewModel.isChange = { [weak self] in
            self?.courseDetailView.mainCollectionView.reloadData()
        }
        
        courseDetailViewModel.currentPage.bind { [weak self] currentPage in
            guard let self = self else { return }
            if let bottomPageControllView = self.courseDetailView.mainCollectionView.supplementaryView(forElementKind: BottomPageControllView.elementKinds, at: IndexPath(item: 0, section: 0)) as? BottomPageControllView {
                bottomPageControllView.pageIndex = currentPage ?? 0
            }
        }
        courseDetailViewModel.isSuccessGetData.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.setSetctionCount()
                self?.setTabBar()
                self?.setNavBar()
                self?.courseDetailView.mainCollectionView.reloadData()
            }
        }
        
        courseDetailViewModel.isAccess.bind { [weak self] isAccess in
            guard let isAccess else { return }
            self?.courseDetailView.isAccess = isAccess
            self?.courseDetailView.mainCollectionView.reloadData()
        }
        
        courseDetailViewModel.isUserLiked.bind { [weak self] isUserLiked in
            guard let self = self else { return }
            self.updateLikeButtonColor(isLiked: isUserLiked ?? false)
        }
        
    }
    
    func setAddTarget() {
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteLabel(sender:)))
        deleteCourseSettingView.deleteLabel.addGestureRecognizer(deleteGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLikeButton))
        courseInfoTabBarView.likeButtonView.isUserInteractionEnabled = true
        courseInfoTabBarView.likeButtonView.addGestureRecognizer(tapGesture)
        courseInfoTabBarView.bringCourseButton.addTarget(self, action: #selector(didTapMySchedule), for: .touchUpInside)
        
    }
    
}

private extension CourseDetailViewController {
    
    @objc
    func didTapMySchedule() {
        let courseId = courseDetailViewModel.courseId
        
        let courseDetailViewModel = CourseDetailViewModel(courseId: courseId)
        let addScheduleViewModel = AddScheduleViewModel()
        addScheduleViewModel.viewedDateCourseByMeData = courseDetailViewModel
        addScheduleViewModel.isImporting = true
        
        let vc = AddScheduleFirstViewController(viewModel: addScheduleViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
        
        // 데이터를 바인딩합니다.
        vc.pastDateBindViewModel()
        
    }
    
    //더보기 버튼
    @objc
    func didTapMoreButton() {
        let alertVC = DRBottomSheetViewController(contentView: DeleteCourseSettingView(), height: 215, buttonType: DisabledButton(), buttonTitle: StringLiterals.Common.cancel)
        alertVC.modalPresentationStyle = .overFullScreen
        self.present(alertVC, animated: true)
    }
    
    @objc
    func didTapLikeButton() {
        courseDetailViewModel.toggleUserLiked()
        
        //        if courseDetailViewModel.isUserLiked.value ?? true {
        //            courseDetailViewModel.isUserLiked.value = true
        //        } else {
        //            courseDetailViewModel.isUserLiked.value = false
        //
        //        }
        
    }
    
    private func updateLikeButtonColor(isLiked: Bool) {
        print(isLiked,"🔥")
        let courseId = self.courseDetailViewModel.courseId
        print(courseId,"🚬")
        if isLiked {
            courseInfoTabBarView.likeButtonImageView.tintColor = UIColor(resource: .deepPurple)
            //            self.courseDetailViewModel.likeCourse(courseId: courseId)
        } else {
            courseInfoTabBarView.likeButtonImageView.tintColor = UIColor(resource: .gray200)
            //            self.courseDetailViewModel.deleteLikeCourse(courseId: courseId) { success in
            //                if success {
            //                    print("Successfully unliked course")
            //                } else {
            //                    print("Failed to unlike course")
            //                }
            //            }
            
        }
    }
    
    func setDelegate() {
        courseDetailView.mainCollectionView.delegate = self
        courseDetailView.mainCollectionView.dataSource = self
        courseDetailView.stickyHeaderNavBarView.delegate = self
    }
    
    func registerCell() {
        courseDetailView.mainCollectionView.do {
            $0.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.cellIdentifier)
            
            $0.register(TitleInfoCell.self, forCellWithReuseIdentifier: TitleInfoCell.cellIdentifier)
            
            $0.register(MainContentsCell.self, forCellWithReuseIdentifier: MainContentsCell.cellIdentifier)
            
            $0.register(TimelineInfoCell.self, forCellWithReuseIdentifier: TimelineInfoCell.cellIdentifier)
            
            $0.register(CoastInfoCell.self, forCellWithReuseIdentifier: CoastInfoCell.cellIdentifier)
            
            $0.register(TagInfoCell.self, forCellWithReuseIdentifier: TagInfoCell.cellIdentifier)
            
            $0.register(VisitDateView.self, forSupplementaryViewOfKind: VisitDateView.elementKinds, withReuseIdentifier: VisitDateView.identifier)
            
            $0.register(InfoBarView.self, forSupplementaryViewOfKind: InfoBarView.elementKinds, withReuseIdentifier: InfoBarView.identifier)
            
            $0.register(InfoHeaderView.self, forSupplementaryViewOfKind: InfoHeaderView.elementKinds, withReuseIdentifier: InfoHeaderView.identifier)
            
            $0.register(GradientView.self, forSupplementaryViewOfKind: GradientView.elementKinds, withReuseIdentifier: GradientView.identifier)
            
            $0.register(BottomPageControllView.self, forSupplementaryViewOfKind: BottomPageControllView.elementKinds, withReuseIdentifier: BottomPageControllView.identifier)
            
            $0.register(ContentMaskView.self, forSupplementaryViewOfKind: ContentMaskView.elementKinds, withReuseIdentifier: ContentMaskView.identifier)
        }
    }
}


extension CourseDetailViewController: ImageCarouselDelegate {
    
    func didSwipeImage(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        courseDetailViewModel.didSwipeImage(to: index)
    }
}

extension CourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return courseDetailViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        _ = courseDetailViewModel.fetchSection(at: section)
        
        return courseDetailViewModel.numberOfItemsInSection(section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = courseDetailViewModel.fetchSection(at: indexPath.section)
        let isAccess = self.courseDetailViewModel.isAccess.value ?? false
        
        switch sectionType {
        case .imageCarousel:
            guard let imageCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.cellIdentifier, for: indexPath) as? ImageCarouselCell else {
                return UICollectionViewCell()
            }
            let imageData = courseDetailViewModel.imageData.value ?? []
            imageCarouselCell.setPageVC(thumbnailModel: imageData)
            imageCarouselCell.setAccess(isAccess: isAccess)
            imageCarouselCell.delegate = self
            return imageCarouselCell
            
        case .titleInfo:
            guard let titleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleInfoCell.cellIdentifier, for: indexPath) as? TitleInfoCell else {
                return UICollectionViewCell()
            }
            let titleDate = courseDetailViewModel.titleHeaderData.value  ?? TitleHeaderModel(date: "", title: "", cost: 0, totalTime: 0, city: "")
            titleInfoCell.setCell(titleHeaderData: titleDate)
            return titleInfoCell
            
        case .mainContents:
            guard let mainContentsCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainContentsCell.cellIdentifier, for: indexPath) as? MainContentsCell else {
                return UICollectionViewCell()
            }
            let mainData = courseDetailViewModel.mainContentsData.value ?? MainContentsModel(description: "")
            mainContentsCell.setCell(mainContentsData: mainData)
            if isAccess {
                mainContentsCell.mainTextLabel.numberOfLines = 0
            } else {
                mainContentsCell.mainTextLabel.numberOfLines = 3
            }
            return mainContentsCell
            
        case .timelineInfo:
            guard let timelineInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineInfoCell.cellIdentifier, for: indexPath) as? TimelineInfoCell else {
                return UICollectionViewCell()
            }
            let timelineItem = self.courseDetailViewModel.timelineData.value?[indexPath.row] ?? TimelineModel(sequence: 0, title: "", duration: 0)
            timelineInfoCell.setCell(timelineData: timelineItem)
            return timelineInfoCell
            
        case .coastInfo:
            guard let coastInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoastInfoCell.cellIdentifier, for: indexPath) as? CoastInfoCell else {
                return UICollectionViewCell()
            }
            let coastData = self.courseDetailViewModel.titleHeaderData.value?.cost ?? 0
            coastInfoCell.setCell(coastData: coastData)
            return coastInfoCell
            
        case .tagInfo:
            guard let tagInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagInfoCell.cellIdentifier, for: indexPath) as? TagInfoCell else {
                return UICollectionViewCell()
            }
            let tagData = self.courseDetailViewModel.tagData.value?[indexPath.row] ?? TagModel(tag: "")
            tagInfoCell.setCell(tag: tagData.tag)
            return tagInfoCell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let isAccess = self.courseDetailViewModel.isAccess.value ?? false
        let titleHeaderData = self.courseDetailViewModel.titleHeaderData.value ?? TitleHeaderModel(date: "", title: "", cost: 0, totalTime: 0, city: "")
        let imageData = self.courseDetailViewModel.imageData.value ?? []
        
        if kind == VisitDateView.elementKinds {
            guard let visitDate = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VisitDateView.identifier, for: indexPath) as? VisitDateView else {
                return UICollectionReusableView()
            }
            visitDate.bindDate(titleHeaderData: titleHeaderData)
            return visitDate
        } else if kind == InfoBarView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoBarView.identifier, for: indexPath) as? InfoBarView else { return UICollectionReusableView() }
            footer.bindTitleHeader(titleHeaderData: titleHeaderData)
            return footer
        } else if kind == GradientView.elementKinds {
            guard let gradient = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GradientView.identifier, for: indexPath) as? GradientView else { return UICollectionReusableView() }
            return gradient
        } else if kind == BottomPageControllView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BottomPageControllView.identifier, for: indexPath) as? BottomPageControllView else { return UICollectionReusableView() }
            let likeNum = self.courseDetailViewModel.likeSum.value ?? 0
            footer.pageIndexSum = imageData.count
            footer.bindData(like: likeNum)
            return footer
        } else if kind == ContentMaskView.elementKinds {
            if isAccess {
                return UICollectionReusableView()
            } else {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentMaskView.identifier, for: indexPath) as? ContentMaskView else { return UICollectionReusableView() }
                let haveFree = self.courseDetailViewModel.haveFreeCount.value ?? false
                let count = self.courseDetailViewModel.conditionalData.value?.free ?? 0
                footer.checkFree(haveFree: haveFree, count: count)
                footer.delegate = self
                return footer
            }
        } else if kind == InfoHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else { return UICollectionReusableView() }
            switch courseDetailViewModel.fetchSection(at: indexPath.section) {
            case .timelineInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.timelineInfoLabel)
            case .coastInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.coastInfoLabel)
            case .tagInfo:
                header.bindTitle(headerTitle: StringLiterals.CourseDetail.tagInfoLabel)
            default:
                break
            }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
}

extension CourseDetailViewController {
    
    func setSetctionCount() {
        guard let isCourseMine = courseDetailViewModel.isCourseMine.value,
              let isAccess = courseDetailViewModel.isAccess.value else { return }
        if isCourseMine {
            if isAccess {
                courseDetailViewModel.setNumberOfSections(6)
            } else {
                courseDetailViewModel.setNumberOfSections(3)
            }
        } else {
            if isAccess {
                courseDetailViewModel.setNumberOfSections(6)
            } else {
                courseDetailViewModel.setNumberOfSections(3)
            }
        }
        courseDetailView.mainCollectionView.reloadData()
    }
    
    func setTabBar() {
        guard let isCourseMine = courseDetailViewModel.isCourseMine.value,
              let isAccess = courseDetailViewModel.isAccess.value else { return }
        if isCourseMine {
            courseInfoTabBarView.isHidden = true
        } else {
            if isAccess {
                courseInfoTabBarView.isHidden = false
            } else {
                courseInfoTabBarView.isHidden = true
            }
        }
    }
    
    //네비게이션 바 삭제 버튼 유무 분기 처리
    func setNavBar() {
        guard let isCourseMine = courseDetailViewModel.isCourseMine.value else { return }
        if isCourseMine {
            courseDetailView.stickyHeaderNavBarView.moreButton.isHidden = false
        } else {
            courseDetailView.stickyHeaderNavBarView.moreButton.isHidden = true
            
        }
    }
    
}

extension CourseDetailViewController: ContentMaskViewDelegate {
    
    func action(rightButtonAction: RightButtonType) {
        
        switch rightButtonAction {
        case .addCourse:
            didTapAddCourseButton()
        case .checkCourse:
            //무료 열람 기회 확인 & 잔여 포인트
            guard let haveFreeCount = self.courseDetailViewModel.haveFreeCount.value,
                  let havePoint = self.courseDetailViewModel.havePoint.value else { return }
            if haveFreeCount {
                //무료 열람 기회 사용
                let request = PostUsePointRequest(point: 50, type: "POINT_USED", description: "무료 열람 기회 사용")
                print("포인트 사용한 코스 아이디:",self.courseDetailViewModel.courseId )
                let courseId = self.courseDetailViewModel.courseId
                self.courseDetailViewModel.postUsePoint(courseId: courseId, request: request)
                //접근 가능
                self.courseDetailViewModel.isAccess.value = true
                dismiss(animated: false)
            } else {
                if havePoint {
                    //포인트로 구입
                    let request = PostUsePointRequest(point: 50, type: "POINT_USED", description: "코스 열람 50P 사용")
                    print("포인트 사용한 코스 아이디:",self.courseDetailViewModel.courseId )
                    let courseId = self.courseDetailViewModel.courseId
                    self.courseDetailViewModel.postUsePoint(courseId: courseId, request: request)
                    self.courseDetailViewModel.isAccess.value = true
                    dismiss(animated: false)
                } else {
                    didTapBuyButton()
                }
            }
        default:
            return
            
        }
        setSetctionCount()
        setTabBar()
        
    }
    
    //버튼 분기 처리하기
    func didTapButton() {
        guard let haveFreeCount = self.courseDetailViewModel.haveFreeCount.value else { return }
        if haveFreeCount {
            didTapFreeViewButton()
        } else {
            didTapReadCourseButton()
        }
    }
    
    
    //열람 전 분기 처리 - 무료 사용 기회 다 쓴 경우
    func didTapReadCourseButton() {
        let customAlertVC = DRCustomAlertViewController(
            rightActionType: RightButtonType.checkCourse,
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: StringLiterals.Alert.buyCourse,
            descriptionText: StringLiterals.Alert.canNotRefund,
            rightButtonText: "확인"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    //열람 전 분기 처리 - 무료 사용 기회 남은 경우
    func didTapFreeViewButton() {
        let customAlertVC = DRCustomAlertViewController(
            rightActionType: RightButtonType.checkCourse,
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: "무료 열람 기회를 사용해 보시겠어요?",
            descriptionText: "무료 열람 기회는 한번 사용하면 취소할 수 없어요",
            rightButtonText: "확인"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    
    //포인트가 부족할 때
    func didTapBuyButton(){
        let customAlertVC = DRCustomAlertViewController(
            rightActionType: RightButtonType.addCourse,
            alertTextType: .hasDecription,
            alertButtonType: .twoButton,
            titleText: "코스를 열람하기에 포인트가 부족해요",
            descriptionText: "코스를 등록하고 포인트를 모아보세요",
            rightButtonText: "코스 등록하기"
        )
        customAlertVC.delegate = self
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
    }
    
    //코스 등록하기로 화면 전환
    func didTapAddCourseButton() {
        let addCourseVC = AddCourseFirstViewController(viewModel: AddCourseViewModel())
        self.navigationController?.pushViewController(addCourseVC, animated: false)
    }
    
    @objc func didTapDeleteLabel(sender: UITapGestureRecognizer) {
        print("didTapDeleteLabel")
        self.dismiss(animated: true)
        courseDetailViewModel.deleteCourse { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    print("성공이다")
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    print("망함")
                }
            }
        }
        courseDetailView.mainCollectionView.reloadData()
    }
}

extension CourseDetailViewController: StickyHeaderNavBarViewDelegate {
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapDeleteButton() {
        let deleteBottomSheetVC = DRBottomSheetViewController(contentView: deleteCourseSettingView,
                                                              height: 188,
                                                              buttonType: DisabledButton(),
                                                              buttonTitle: StringLiterals.Common.close)
        deleteBottomSheetVC.delegate = self
        deleteBottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(deleteBottomSheetVC, animated: true)
    }
}

extension CourseDetailViewController: DRBottomSheetDelegate {
    
    func didTapBottomButton() {
        self.dismiss(animated: true)
    }
}

extension CourseDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 350 {
            courseDetailView.stickyHeaderNavBarView.backgroundColor = .white
            courseDetailView.stickyHeaderNavBarView.moreButton.tintColor = .gray600
            courseDetailView.stickyHeaderNavBarView.previousButton.tintColor = .gray600
        } else {
            courseDetailView.stickyHeaderNavBarView.backgroundColor = .clear
            courseDetailView.stickyHeaderNavBarView.moreButton.tintColor = .drWhite
            courseDetailView.stickyHeaderNavBarView.previousButton.tintColor = .drWhite
        }
    }
}
