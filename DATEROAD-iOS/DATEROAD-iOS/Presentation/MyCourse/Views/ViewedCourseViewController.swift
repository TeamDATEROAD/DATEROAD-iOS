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
    
    private var nickName: String = ""
    
    private var topLabel = UILabel()
    
    private var createCourseView = UIView()
    
    private let createCourseLabel = UILabel()
    
    private let arrowButton = UIButton()
    
    private var viewedCourseView = MyCourseListView()
    
    // MARK: - Properties
    
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
    
   override func viewDidAppear(_ animated: Bool) {
       self.viewedCourseViewModel.setViewedCourseData()
       bindViewModel()
       viewedCourseView.myCourseListCollectionView.reloadData()
       setEmptyView()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      registerCell()
      setDelegate()
      bindViewModel()
      setEmptyView()
   }
   
   override func setHierarchy() {
      self.view.addSubviews(topLabel,
                            createCourseView,
                            viewedCourseView)
      
      self.createCourseView.addSubviews(createCourseLabel, arrowButton)
   }
   
   override func setLayout() {
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
         $0.top.equalTo(createCourseView.snp.bottom).offset(10)
         $0.bottom.equalToSuperview().inset(ScreenUtils.height*0.1)
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
      self.view.backgroundColor = UIColor(resource: .drWhite)
      
      topLabel.do {
         $0.font = UIFont.suit(.title_extra_24)
         $0.setAttributedText(fullText: "\(viewedCourseViewModel.userName)님이 지금까지\n열람한 데이트 코스\n\(viewedCourseViewModel.viewedCourseData.value?.count ?? 0)개", pointText: "\(viewedCourseViewModel.viewedCourseData.value?.count ?? 0)", pointColor: UIColor(resource: .mediumPurple), lineHeight: 1)
         $0.numberOfLines = 3
      }
      
      createCourseView.do {
         $0.backgroundColor = UIColor(resource: .drWhite)
         $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseUploadVC(_:))))
         $0.isUserInteractionEnabled = true
      }
      
      createCourseLabel.do {
         $0.font = UIFont.suit(.title_bold_18)
         $0.textColor = UIColor(resource: .drBlack)
         $0.text = StringLiterals.ViewedCourse.registerSchedule
      }
      
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
      let isEmpty = viewedCourseViewModel.viewedCourseData.value?.count == 0 ? true : false
    let name =  UserDefaults.standard.string(forKey: "userName") ?? ""
       topLabel.text = "\(name)님,\n아직 열람한\n데이트코스가 없어요"
      createCourseView.isHidden = isEmpty
      viewedCourseView.emptyView.snp.makeConstraints {
         $0.top.equalToSuperview()
      }
      viewedCourseView.emptyView.do {
         $0.isHidden = !isEmpty
         $0.setEmptyView(emptyImage: UIImage(resource: .emptyPastSchedule),
                         emptyTitle: StringLiterals.EmptyView.emptyViewedCourse)
      }
      self.viewedCourseView.myCourseListCollectionView.reloadData()
   }
}

// MARK: - DataBind

extension ViewedCourseViewController {
   
   func bindViewModel() {
       
      self.viewedCourseViewModel.isSuccessGetViewedCourseInfo.bind { [weak self] isSuccess in
         guard let isSuccess else { return }
         if isSuccess {
            
            self?.topLabel.do {
                let name =  UserDefaults.standard.string(forKey: "userName") ?? ""
               $0.font = UIFont.suit(.title_extra_24)
                $0.setAttributedText(fullText: "\(name)님이 지금까지\n열람한 데이트 코스\n\(self?.viewedCourseViewModel.viewedCourseData.value?.count ?? 0)개", pointText: "\(self?.viewedCourseViewModel.viewedCourseData.value?.count ?? 0)", pointColor: UIColor(resource: .mediumPurple), lineHeight: 1)
               $0.numberOfLines = 3
            }
             self?.setEmptyView()

         }
      }
      
   }
}

// MARK: - CollectionView Methods

extension ViewedCourseViewController {
   private func registerCell() {
      viewedCourseView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
   }
   
   private func setDelegate() {
      viewedCourseView.myCourseListCollectionView.delegate = self
      viewedCourseView.myCourseListCollectionView.dataSource = self
   }
   
   func updateNicknameLabel(nickName: String) {
      if viewedCourseViewModel.viewedCourseData.value?.count == 0 {
         topLabel.text = "\(nickName)님,\n아직 열람한\n데이트코스가 없어요"
      } else {
         topLabel.text = "\(nickName)님이 지금까지\n열람한 데이트 코스\n\(viewedCourseViewModel.viewedCourseData.value?.count ?? 0)개"
      }
   }
}

// MARK: - Delegate

extension ViewedCourseViewController : UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: ScreenUtils.width, height: 140)
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
      
      if let index = indexPath {
         let courseId = viewedCourseViewModel.viewedCourseData.value?[indexPath?.item ?? 0].courseId ?? 0
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
