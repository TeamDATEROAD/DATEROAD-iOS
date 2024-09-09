//
//  ViewedCourseViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/5/24.
//

import UIKit

import SnapKit
import Then

class ViewedCourseViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private var contentView = UIView()
    
    private var topLabel = UILabel()
    
    private var createCourseView = UIView()
    
    private let createCourseLabel = UILabel()
    
    private let arrowButton = UIButton()
    
    private var viewedCourseView = MyCourseListView()
        
    private let errorView: DRErrorViewController = DRErrorViewController()
    
    // MARK: - Properties
    
    private var nickName: String = ""
    
    private let viewedCourseViewModel: MyCourseListViewModel
    
    
    init(viewedCourseViewModel: MyCourseListViewModel) {
        self.viewedCourseViewModel = viewedCourseViewModel
        nickName = self.viewedCourseViewModel.userName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.viewedCourseViewModel.setViewedCourseData()
    }

   override func viewDidLoad() {
      super.viewDidLoad()
      
      registerCell()
      setDelegate()
      bindViewModel()
   }
   
   override func setHierarchy() {
       super.setHierarchy()
       
      self.view.addSubview(contentView)
       
      self.contentView.addSubviews(topLabel,
                                   createCourseView,
                                   viewedCourseView)
       
      self.createCourseView.addSubviews(createCourseLabel, arrowButton)
   }
   
   override func setLayout() {
       super.setLayout()
       
       contentView.snp.makeConstraints {
           $0.edges.equalToSuperview()
       }
       
      topLabel.snp.makeConstraints {
         $0.top.equalToSuperview().inset(82)
         $0.leading.equalToSuperview().inset(16)
         $0.height.equalTo(93)
      }
      
      createCourseView.snp.makeConstraints {
         $0.top.equalTo(topLabel.snp.bottom).offset(4)
         $0.leading.equalToSuperview().inset(16)
         $0.height.equalTo(40)
         $0.width.equalTo(288)
      }
      
      viewedCourseView.snp.makeConstraints {
         $0.top.equalTo(topLabel.snp.bottom).offset(54)
         $0.bottom.equalToSuperview().inset(ScreenUtils.height * 0.11)
         $0.horizontalEdges.equalToSuperview()
      }
      
      createCourseLabel.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.leading.equalToSuperview()
         $0.width.equalTo(233)
      }
      
      arrowButton.snp.makeConstraints {
         $0.centerY.equalToSuperview()
         $0.trailing.equalToSuperview()
         $0.width.equalTo(45)
         $0.height.equalTo(26)
      }
    }
   
   override func setStyle() {
       super.setStyle()
             
      topLabel.do {
         $0.font = UIFont.suit(.title_extra_24)
         $0.setAttributedText(fullText: "\(viewedCourseViewModel.userName)님이 지금까지\n열람한 데이트 코스\n\(viewedCourseViewModel.viewedCourseData.value?.count ?? 0)개", 
                              pointText: "\(viewedCourseViewModel.viewedCourseData.value?.count ?? 0)",
                              pointColor: UIColor(resource: .mediumPurple),
                              lineHeight: 1)
         $0.numberOfLines = 3
      }
      
      createCourseView.do {
         $0.backgroundColor = UIColor(resource: .drWhite)
         $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseUploadVC(_:))))
         $0.isUserInteractionEnabled = true
      }
      
      createCourseLabel.setLabel(text: StringLiterals.ViewedCourse.registerSchedule,
                      textColor: UIColor(resource: .drBlack),
                      font: UIFont.suit(.title_bold_18))
      
      arrowButton.do {
         $0.setButtonStatus(buttonType: EnabledButton())
         $0.setImage(UIImage(resource: .createCourseArrow), for: .normal)
         $0.roundedButton(cornerRadius: 13, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
         $0.isUserInteractionEnabled = false
      }
   }
   
}

// MARK: - EmptyView Methods

private extension ViewedCourseViewController {
    func setEmptyView() {
       let name =  UserDefaults.standard.string(forKey: "userName") ?? ""
        let isEmpty = (self.viewedCourseViewModel.viewedCourseData.value?.count == 0)
       viewedCourseView.emptyView.isHidden = !isEmpty
       createCourseView.isHidden = isEmpty

       if isEmpty {
           topLabel.text = "\(name)님,\n아직 열람한\n데이트코스가 없어요"
           viewedCourseView.emptyView.setEmptyView(emptyImage: UIImage(resource: .emptyViewedCourse), emptyTitle: StringLiterals.EmptyView.emptyViewedCourse)
       } else {
           self.viewedCourseView.myCourseListCollectionView.reloadData()
           self.topLabel.setAttributedText(fullText: "\(name)님이 지금까지\n열람한 데이트 코스\n\(self.viewedCourseViewModel.viewedCourseData.value?.count ?? 0)개",
                                    pointText: "\(self.viewedCourseViewModel.viewedCourseData.value?.count ?? 0)",
                                    pointColor: UIColor(resource: .mediumPurple),
                                    lineHeight: 1)
       }
   }
}

// MARK: - DataBind

extension ViewedCourseViewController {
   
   func bindViewModel() {
       self.viewedCourseViewModel.onReissueSuccess.bind { [weak self] onSuccess in
           guard let onSuccess else { return }
           if onSuccess {
               // TODO: - 서버 통신 재시도
           } else {
               self?.navigationController?.pushViewController(SplashViewController(splashViewModel: SplashViewModel()), animated: false)
           }
       }
       
       self.viewedCourseViewModel.onViewedCourseFailNetwork.bind { [weak self] onFailure in
           guard let onFailure else { return }
           if onFailure {
               self?.hideLoadingView()
               let errorVC = DRErrorViewController()
               self?.navigationController?.pushViewController(errorVC, animated: false)
           }
       }

       self.viewedCourseViewModel.onViewedCourseLoading.bind { [weak self] onLoading in
           guard let onLoading, let onFailNetwork = self?.viewedCourseViewModel.onViewedCourseFailNetwork.value else { return }
           if !onFailNetwork {
               onLoading ? self?.showLoadingView() : self?.hideLoadingView()
               self?.contentView.isHidden = onLoading
               self?.tabBarController?.tabBar.isHidden = onLoading
           }
       }
       
      self.viewedCourseViewModel.isSuccessGetViewedCourseInfo.bind { [weak self] isSuccess in
         guard let isSuccess else { return }
         if isSuccess {
             self?.setEmptyView()
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                 self?.viewedCourseViewModel.setViewedCourseLoading()
             }
         }
      }
   }
}

// MARK: - CollectionView Methods

private extension ViewedCourseViewController {
    
func registerCell() {
      viewedCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
   }
   
func setDelegate() {
      viewedCourseView.myCourseListCollectionView.dataSource = self
   }

}

// MARK: - DataSource

extension ViewedCourseViewController : UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewedCourseViewModel.viewedCourseData.value?.count ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
         return UICollectionViewCell()
      }
      cell.dataBind(viewedCourseViewModel.viewedCourseData.value?[indexPath.item], indexPath.item)
      cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
      return cell
   }
   
   @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
      let location = sender.location(in: viewedCourseView.myCourseListCollectionView)
      let indexPath = viewedCourseView.myCourseListCollectionView.indexPathForItem(at: location)
      
      if let indexPath {
          let courseId = viewedCourseViewModel.viewedCourseData.value?[indexPath.item].courseId ?? 0
         self.navigationController?.pushViewController(CourseDetailViewController(viewModel: CourseDetailViewModel(courseId: courseId)), animated: false)
      }
   }
   
}

extension ViewedCourseViewController {
   @objc
   func pushToCourseUploadVC(_ gesture: UITapGestureRecognizer) {
      goToUpcomingDateScheduleVC()
   }
   
   ///'데이트 일정' 바텀 탭으로 이동은 성공이나 뷰를 띄워도 그리지 않아서 문제
   func goToUpcomingDateScheduleVC() {
      let tabbarVC = TabBarController()
      tabbarVC.selectedIndex = 2
      navigationController?.pushViewController(tabbarVC, animated: false)
   }
}
