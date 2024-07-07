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
    
    private var courseCollectionView = ViewedCourseCollectionView()
    
    // MARK: - Properties
    
    private let viewedCourseViewModel = ViewedCourseViewModel()
    
    private lazy var userViewedCourseDummyData = viewedCourseViewModel.userViewedCourseDummyData
    
    private lazy var viewedCourseDummyData = viewedCourseViewModel.viewedCourseDummyData
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            $0.bottom.equalToSuperview().inset(88)
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
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = UIColor(resource: .drWhite)
        
        topLabel.do {
            $0.font = UIFont.suit(.title_extra_24)
            $0.setAttributedText(fullText: "\(userViewedCourseDummyData.userName ?? "00")님이 지금까지\n열람한 데이트 코스\n\(userViewedCourseDummyData.courseNumber ?? 0)개", pointText: "14", pointColor: UIColor(resource: .mediumPurple), lineHeight: 1)
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
            $0.text = "열람한 코스로 데이트를 짜보세요"
        }
        
        arrowButton.do {
            $0.setButtonStatus(buttonType: EnabledButton())
            $0.setImage(UIImage(resource: .createCourseArrow), for: .normal)
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        courseCollectionView.do {
            $0.setUpBindings(viewedCourseData: viewedCourseDummyData)
        }
    }

}

extension ViewedCourseViewController {
    @objc
    func pushToCourseUploadVC(_ gesture: UITapGestureRecognizer) {
        print("일정 등록 페이지로 이동")
    }
}
