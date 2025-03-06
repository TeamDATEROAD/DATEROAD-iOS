//
//  ViewedCourseView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/4/25.
//

import UIKit

protocol ViewedCourseDelegate: AnyObject {
    
    func didTapAddCourse()
    
}

final class ViewedCourseView: BaseView {
    
    // MARK: - UI Properties
    
    private var topLabel = UILabel()
    
    private var addCourseView = UIView()
    
    private let createCourseLabel = UILabel()
    
    private let arrowButton: DRImageButton = DRImageButton(
        image: UIImage(resource: .createCourseArrow),
        buttonName: .bold_purple_14,
        isEnabled: false
    )
    
    var viewedCourseListView = MyCourseListView(type: "tab")
    
    
    // MARK: - Properties
    
    weak var delegate: ViewedCourseDelegate?
    
    private let userName: String = UserDefaults.standard.string(forKey: StringLiterals.Network.userName) ?? ""
    
    private var loaded: Bool = false
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        self.addSubviews(
            topLabel,
            addCourseView,
            viewedCourseListView
        )
        
        self.addCourseView.addSubviews(createCourseLabel, arrowButton)
    }
    
    override func setLayout() {
        super.setLayout()
        
        topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(82)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(93)
        }
        
        addCourseView.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(288)
        }
        
        viewedCourseListView.snp.makeConstraints {
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
            $0.font = UIFont.systemFont(ofSize: 24, weight: .black)
            $0.numberOfLines = 3
        }
        
        addCourseView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.isUserInteractionEnabled = true
        }
        
        createCourseLabel.setLabel(text: StringLiterals.ViewedCourse.registerSchedule,
                                   textColor: UIColor(resource: .drBlack),
                                   font: UIFont.suit(.title_bold_18))
    }
    
}


// MARK: - Methods

extension ViewedCourseView {
    
    func setAddTarget() {
        addCourseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAddCourse)))
    }
    
    func registerCell() {
        viewedCourseListView.myCourseListCollectionView.register(MyCourseListCollectionViewCell.self, forCellWithReuseIdentifier: MyCourseListCollectionViewCell.cellIdentifier)
    }
    
    func setEmptyView(_ isEmpty: Bool) {
        viewedCourseListView.emptyView.isHidden = !isEmpty
        addCourseView.isHidden = isEmpty
    }
    
    func updateTopLabel(_ username: String, _ courseCount: Int, _ pointText: String) {
        viewedCourseListView.myCourseListCollectionView.reloadData()
        topLabel.setAttributedText(
            fullText: "\(userName)님이 지금까지\n열람한 데이트 코스\n\(String(courseCount))개",
            pointText: "\(pointText)",
            pointColor: UIColor(resource: .mediumPurple),
            lineHeight: 1
        )
    }
    
    func updateEmptyTopLabel(_ name: String) {
        topLabel.text = "\(name)님,\n아직 열람한\n데이트코스가 없어요"
        viewedCourseListView.emptyView.setEmptyView(emptyImage: UIImage(resource: .emptyViewedCourse), emptyTitle: StringLiterals.EmptyView.emptyViewedCourse)
    }
    
}


// MARK: - @objc Methods

extension ViewedCourseView {
    
    @objc
    func didTapAddCourse() {
        delegate?.didTapAddCourse()
    }
    
}
