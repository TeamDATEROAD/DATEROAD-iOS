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
    
    private var topLabel = UILabel()
    
    private var createCourseView = UIView()
    
    private let createCourseLabel = UILabel()
    
    private let arrowButton = UIButton()
    
    private var courseCollectionView = MyCourseListCollectionView()
    
    // MARK: - Properties
    
    private let viewedCourseViewModel = MyCourseListViewModel()
    
    private lazy var viewedCourseData = viewedCourseViewModel.viewedCourseData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setDelegate()
    }
    
    override func setHierarchy() {
        self.view.addSubviews(topLabel,
                              createCourseView,
                              courseCollectionView)
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
        
        courseCollectionView.snp.makeConstraints {
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
            $0.setAttributedText(fullText: "\(viewedCourseViewModel.userName)님이 지금까지\n열람한 데이트 코스\n\(viewedCourseData.count)개", pointText: "\(viewedCourseData.count)", pointColor: UIColor(resource: .mediumPurple), lineHeight: 1)
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

// MARK: - CollectionView Methods

extension ViewedCourseViewController {
    private func registerCell() {
        courseCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    private func setDelegate() {
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
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
        return viewedCourseData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier, for: indexPath) as? MyCourseListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.dataBind(viewedCourseData[indexPath.item], indexPath.item)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToCourseDetailVC(_:))))
        return cell
    }
    
    @objc func pushToCourseDetailVC(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: courseCollectionView)
        let indexPath = courseCollectionView.indexPathForItem(at: location)

       if let index = indexPath {
           print("일정 상세 페이지로 이동 \(viewedCourseData[indexPath?.item ?? 0].courseId )")
       }
    }
    
}

extension ViewedCourseViewController {
    @objc
    func pushToCourseUploadVC(_ gesture: UITapGestureRecognizer) {
        print("일정 등록 페이지로 이동")
    }
}
